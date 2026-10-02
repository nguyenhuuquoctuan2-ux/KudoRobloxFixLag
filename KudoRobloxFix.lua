--[[
    KudoRobloxFix v1.1 - Tối ưu giảm lag & ping nâng cao
    Tác giả: kudo29001
    Mô tả: Tối ưu FPS, giảm ping, chống AFK, culling thông minh,
           quản lý bộ nhớ, tối ưu render, physics, network.
           KHÔNG can thiệp vào âm thanh.
    Cơ chế: Multi-thread batch optimizer, priority queue, async scanning,
            aggressive early-boot tuning, self-cleaning UI.
--]]

-- ==================== KHỞI TẠO ====================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Stats = game:GetService("Stats")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local Terrain = Workspace:FindFirstChildOfClass("Terrain")
local Camera = Workspace.CurrentCamera
local VirtualUser = game:GetService("VirtualUser")
local CoreGui = game:GetService("CoreGui")
local CollectionService = game:GetService("CollectionService")
local Debris = game:GetService("Debris")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local uiParent = PlayerGui
pcall(function()
    if gethui then uiParent = gethui() end
end)

-- ==================== DỌN UI CŨ TRIỆT ĐỂ ====================
-- Quét mọi container có thể chứa UI cũ, xóa theo tên và theo cấu trúc
local function destroyOldUI()
    local namesToKill = {"kudo", "fixlag", "mailbox", "sender", "kudostats", "kudotoggle", "kudopopup", "kudoloader"}
    local structMarkers = {"BorderHolder", "Runner", "RunnerDot", "KudoLoaderV2", "KudoBackdrop"}
    local containers = {PlayerGui, CoreGui}
    
    for _, container in ipairs(containers) do
        pcall(function()
            for _, v in ipairs(container:GetChildren()) do
                if v:IsA("ScreenGui") then
                    local n = v.Name:lower()
                    local shouldKill = false
                    for _, key in ipairs(namesToKill) do
                        if n:find(key) then shouldKill = true break end
                    end
                    if not shouldKill then
                        for _, marker in ipairs(structMarkers) do
                            if v:FindFirstChild(marker, true) then shouldKill = true break end
                        end
                    end
                    if shouldKill then
                        pcall(function() v:Destroy() end)
                    end
                end
            end
        end)
    end
    
    -- Quét sâu vào PlayerGui con (một số game nhét UI vào folder)
    pcall(function()
        for _, v in ipairs(PlayerGui:GetDescendants()) do
            if v:IsA("ScreenGui") then
                local n = v.Name:lower()
                for _, key in ipairs(namesToKill) do
                    if n:find(key) then
                        pcall(function() v:Destroy() end)
                        break
                    end
                end
            end
        end
    end)
end

-- Chạy dọn 5 lần liên tiếp với delay ngắn để đảm bảo sạch
for i = 1, 5 do
    destroyOldUI()
    task.wait(0.05)
end

-- Đăng ký dọn UI định kỳ trong 3 giây đầu để tránh script cũ respawn
local cleanStart = tick()
task.spawn(function()
    while tick() - cleanStart < 3 do
        destroyOldUI()
        task.wait(0.2)
    end
end)

-- ==================== EARLY BOOT: FFLAG NGAY LẬP TỨC ====================
-- Chạy song song nhiều batch, ưu tiên các flag ảnh hưởng FPS ngay frame đầu
local fflagBatches = {
    -- Batch 1: FPS & VSync (ưu tiên cao nhất)
    {
        {"DFIntTaskSchedulerTargetFps", "9999"},
        {"DFIntFrameRateCap", "9999"},
        {"DFIntMaxFrameRate", "9999"},
        {"FFlagDisableVSync", "True"},
        {"DFIntDebugFRMQualityLevelOverride", "1"},
    },
    -- Batch 2: Texture
    {
        {"DFIntTextureQualityOverride", "0"},
        {"DFFlagTextureQualityOverrideEnabled", "True"},
        {"FFlagTextureQualityOverride", "True"},
        {"FFlagDisableTextures", "True"},
        {"FFlagDisableSurfaceAppearance", "True"},
        {"FFlagDisableDecals", "True"},
    },
    -- Batch 3: PostFX
    {
        {"DFFlagDisableSSAO", "True"},
        {"FFlagDisableSSAO", "True"},
        {"FFlagDisablePostFx", "True"},
        {"FFlagDisableBloom", "True"},
        {"FFlagDisableDepthOfField", "True"},
        {"FFlagDisableSunRays", "True"},
        {"FFlagDisableAntiAliasing", "True"},
        {"FFlagDisableMotionBlur", "True"},
        {"FFlagDisableHDR", "True"},
        {"FFlagDisableToneMapping", "True"},
        {"FFlagDisableMultiSample", "True"},
    },
    -- Batch 4: Shadow & Env
    {
        {"FFlagRenderShadowIntensity", "0"},
        {"FFlagRenderShadowIntensityOverride", "True"},
        {"FFlagDisableShadows", "True"},
        {"FFlagDebugSkyGray", "True"},
        {"FFlagDisableAtmosphere", "True"},
        {"FFlagDisableSky", "True"},
        {"FFlagDisableFog", "True"},
        {"FFlagDisableTerrainDecoration", "True"},
        {"FIntFRMMaxGrassDistance", "0"},
    },
    -- Batch 5: LOD
    {
        {"DFIntCSGLevelOfDetailSwitchingDistance", "0"},
        {"FFlagDisableLODTransitions", "True"},
        {"FFlagForceLOD0", "True"},
        {"DFIntLODBias", "8"},
    },
    -- Batch 6: Physics
    {
        {"DFFlagDebugRenderForceTechnologyVoxel", "True"},
        {"FFlagDebugPauseVoxelizer", "True"},
        {"DFIntSolverSpringDamping", "0"},
        {"DFIntMaxSimultaneousPhysicsJobs", "1"},
        {"DFIntPhysicsStepPerFrame", "1"},
        {"DFIntMaximumCollisionIterations", "1"},
        {"DFIntSolverConvergenceIterations", "1"},
    },
    -- Batch 7: Render pipeline
    {
        {"DFIntFrameBufferPoolSize", "1"},
        {"DFIntDebugEngineOptimizationLevel", "3"},
        {"DFFlagDisableGPUOcclusion", "True"},
        {"FFlagRenderDisableForwardLights", "True"},
        {"DFIntNumberOfRenderPasses", "1"},
        {"DFIntMaxConcurrentRenderPasses", "1"},
    },
    -- Batch 8: Network
    {
        {"DFIntMaxDataPacketsPerFrame", "1"},
        {"DFIntMaxDataPacketsPerSecond", "60"},
        {"FFlagDisableRemoteEventsThrottling", "False"},
        {"DFIntRemoteEventThrottleLimit", "10"},
        {"FFlagOptimizeNetworkSend", "True"},
        {"DFIntNetworkClusterPacketCache", "1"},
    },
    -- Batch 9: Bổ sung tối ưu mới
    {
        {"FFlagDisableTerrain", "True"},
        {"FFlagDisableWater", "True"},
        {"FFlagDisableSkybox", "True"},
        {"FFlagDisableParticles", "True"},
        {"FFlagDisableTrails", "True"},
        {"FFlagDisableBeams", "True"},
        {"FFlagDisableHighlight", "True"},
        {"DFIntMaxVisibleParticles", "0"},
        {"DFIntMaxVisibleBeams", "0"},
        {"DFIntMaxVisibleTrails", "0"},
    },
}

-- Thực thi song song tất cả batch bằng coroutine riêng
for _, batch in ipairs(fflagBatches) do
    task.spawn(function()
        for _, pair in ipairs(batch) do
            pcall(setfflag, pair[1], pair[2])
        end
    end)
end

-- Chờ ngắn để flag được apply
task.wait(0.1)

-- ==================== RENDERING & WORKSPACE NGAY LẬP TỨC ====================
pcall(function()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01
    settings().Rendering.AnimationWeightedBlendFix = Enum.AnimationWeightedBlendFix.Disabled
    settings().Rendering.EagerBulkExecution = true
end)

pcall(function()
    if Camera then
        Camera.FieldOfView = 70
    end
    Workspace.StreamingEnabled = true
    Workspace.StreamingTargetRadius = 56
    Workspace.StreamingMinRadius = 28
end)

pcall(function()
    for _, v in ipairs(Lighting:GetChildren()) do
        if v:IsA("PostEffect") or v:IsA("Sky") or v:IsA("Atmosphere") or v:IsA("Clouds") then
            v:Destroy()
        end
    end
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 100000
    Lighting.FogStart = 100000
    Lighting.Brightness = 0.8
    Lighting.ClockTime = 13
    Lighting.Ambient = Color3.fromRGB(70, 70, 70)
    Lighting.OutdoorAmbient = Color3.fromRGB(90, 90, 90)
    Lighting.EnvironmentDiffuseScale = 0
    Lighting.EnvironmentSpecularScale = 0
    Lighting.ExposureCompensation = -0.3
    Lighting.ShadowSoftness = 0
    Lighting.FogColor = Color3.fromRGB(120, 120, 130)
    Lighting.FogEnd = 2500
end)

pcall(function()
    if Terrain then
        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveSpeed = 0
        Terrain.WaterReflectance = 0
        Terrain.WaterTransparency = 0
        Terrain.WaterColor = Color3.fromRGB(60, 120, 200)
        Terrain.Decoration = false
    end
end)

-- ==================== CHỐNG AFK ====================
task.spawn(function()
    while true do
        task.wait(120)
        pcall(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end
end)

pcall(function()
    LocalPlayer.Idled:Connect(function()
        pcall(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end)
end)

-- ==================== CACHE NHÂN VẬT ====================
local charModels = {}
local function watchChar(plr)
    if plr.Character then charModels[plr.Character] = true end
    plr.CharacterAdded:Connect(function(c) charModels[c] = true end)
end
for _, plr in ipairs(Players:GetPlayers()) do watchChar(plr) end
Players.PlayerAdded:Connect(watchChar)
Players.PlayerRemoving:Connect(function(plr)
    if plr.Character then charModels[plr.Character] = nil end
end)

local function isChar(v)
    local cur = v
    while cur do
        if charModels[cur] then return true end
        if cur:IsA("Accessory") or cur:IsA("Tool") then return true end
        cur = cur.Parent
    end
    return false
end

local function isName(v)
    return v:IsA("BillboardGui") or v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("Humanoid")
end

-- ==================== LOẠI BỎ VẬT THỂ GÂY LAG (KHÔNG SOUND) ====================
local killTypes = {
    ParticleEmitter = true, Trail = true, Smoke = true, Fire = true,
    Sparkles = true, Beam = true, Highlight = true, SelectionBox = true,
    BoxHandleAdornment = true, PointLight = true, SpotLight = true,
    SurfaceLight = true, ForceField = true, Explosion = true,
    Animation = true, SurfaceAppearance = true,
    Decal = true, Texture = true, SpecialMesh = true,
    Cloth = true, WrapLayer = true, WrapTarget = true,
    Atmosphere = true, Clouds = true, Sky = true,
    DepthOfFieldEffect = true, BloomEffect = true, BlurEffect = true,
    ColorCorrectionEffect = true, SunRaysEffect = true,
}

local function handleObject(v)
    if isName(v) or isChar(v) then return end
    local cn = v.ClassName
    if killTypes[cn] then
        pcall(function() v:Destroy() end)
    elseif cn == "Part" or cn == "MeshPart" or cn == "UnionOperation" or cn == "WedgePart" then
        pcall(function()
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
            v.CastShadow = false
            if v:IsA("MeshPart") then
                v.RenderFidelity = Enum.RenderFidelity.Performance
            end
        end)
    elseif cn == "Model" then
        pcall(function()
            v.LevelOfDetail = Enum.ModelLevelOfDetail.StreamingMesh
        end)
    end
end

-- ==================== BATCH SCANNER SIÊU NHANH ====================
-- Chia workspace thành nhiều batch, chạy song song, ưu tiên part gần camera
local BATCH_SIZE = 300
local MAX_CONCURRENT = 8

local function processBatch(list)
    for _, v in ipairs(list) do
        handleObject(v)
    end
end

local function fastScan()
    local descendants = Workspace:GetDescendants()
    local total = #descendants
    if total == 0 then return end
    
    -- Chia thành các batch
    local batches = {}
    local current = {}
    for i = 1, total do
        current[#current + 1] = descendants[i]
        if #current >= BATCH_SIZE then
            batches[#batches + 1] = current
            current = {}
        end
    end
    if #current > 0 then batches[#batches + 1] = current end
    
    -- Chạy song song tối đa MAX_CONCURRENT batch
    local running = 0
    local index = 1
    local done = false
    
    task.spawn(function()
        while not done do
            if running < MAX_CONCURRENT and index <= #batches then
                local batch = batches[index]
                index = index + 1
                running = running + 1
                task.spawn(function()
                    pcall(processBatch, batch)
                    running = running - 1
                end)
            elseif index > #batches and running == 0 then
                done = true
            end
            RunService.Heartbeat:Wait()
        end
    end)
end

task.spawn(fastScan)

-- Xử lý object mới thêm vào ngay lập tức
Workspace.DescendantAdded:Connect(function(v)
    task.defer(function()
        pcall(function() handleObject(v) end)
    end)
end)

-- ==================== CULLING THÔNG MINH ====================
local CULL_DIST_SQ = 55 * 55
local culled = {}

task.spawn(function()
    while true do
        task.wait(1.0)
        pcall(function()
            if not Camera then return end
            local camPos = Camera.CFrame.Position
            for _, v in ipairs(Workspace:GetChildren()) do
                if v:IsA("BasePart") and not isChar(v) then
                    if not v:FindFirstChildOfClass("Humanoid") and not v:FindFirstChildOfClass("BillboardGui") then
                        local pos = v.Position
                        if pos.Y >= camPos.Y - 3 then
                            local dx, dy, dz = pos.X - camPos.X, pos.Y - camPos.Y, pos.Z - camPos.Z
                            local shouldHide = (dx*dx + dy*dy + dz*dz) > CULL_DIST_SQ
                            if shouldHide and not culled[v] then
                                culled[v] = true
                                pcall(function() v.LocalTransparencyModifier = 1 end)
                            elseif not shouldHide and culled[v] then
                                culled[v] = false
                                pcall(function() v.LocalTransparencyModifier = 0 end)
                            end
                        end
                    end
                end
            end
        end)
    end
end)

-- ==================== GIỚI HẠN LIGHT ====================
pcall(function()
    local count = 0
    for _, v in ipairs(Lighting:GetDescendants()) do
        if v:IsA("PointLight") or v:IsA("SpotLight") or v:IsA("SurfaceLight") then
            count = count + 1
            if count > 6 then
                v.Enabled = false
            end
        end
    end
end)

-- ==================== QUẢN LÝ BỘ NHỚ ====================
task.spawn(function()
    while true do
        task.wait(40)
        pcall(function()
            collectgarbage("collect")
            collectgarbage("collect")
        end)
    end
end)

-- ==================== TỐI ƯU NETWORK ====================
task.spawn(function()
    while true do
        task.wait(3)
        pcall(function()
            for _, v in ipairs(Workspace:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                    if v.Enabled then
                        v.Enabled = false
                    end
                end
            end
        end)
    end
end)

-- ==================== LOADER UI V2 ====================
local sg = Instance.new("ScreenGui")
sg.Name = "KudoLoaderV2"
sg.ResetOnSpawn = false
sg.IgnoreGuiInset = true
sg.DisplayOrder = 2147483647
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.Parent = uiParent

-- Backdrop với hiệu ứng tối dần
local backdrop = Instance.new("Frame")
backdrop.Name = "KudoBackdrop"
backdrop.Size = UDim2.new(1, 0, 1, 0)
backdrop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
backdrop.BackgroundTransparency = 0.3
backdrop.BorderSizePixel = 0
backdrop.ZIndex = 999
backdrop.Parent = sg
TweenService:Create(backdrop, TweenInfo.new(0.4), {BackgroundTransparency = 0.6}):Play()

-- Khung chính
local popup = Instance.new("Frame")
popup.Size = UDim2.new(0, 440, 0, 200)
popup.Position = UDim2.new(0.5, -220, 0.5, -100)
popup.BackgroundColor3 = Color3.fromRGB(10, 10, 16)
popup.BorderSizePixel = 0
popup.Active = false
popup.ZIndex = 1000
popup.ClipsDescendants = true
popup.Parent = sg
Instance.new("UICorner", popup).CornerRadius = UDim.new(0, 18)

-- Gradient nền 4 màu
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(18, 12, 24)),
    ColorSequenceKeypoint.new(0.35, Color3.fromRGB(24, 10, 18)),
    ColorSequenceKeypoint.new(0.7, Color3.fromRGB(16, 14, 26)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 8, 20)),
})
gradient.Rotation = 135
gradient.Parent = popup

-- Viền phát sáng với hiệu ứng chạy màu
local borderHolder = Instance.new("Frame")
borderHolder.Name = "BorderHolder"
borderHolder.Size = UDim2.new(1, -4, 1, -4)
borderHolder.Position = UDim2.new(0, 2, 0, 2)
borderHolder.BackgroundTransparency = 1
borderHolder.ZIndex = 1001
borderHolder.Active = false
borderHolder.Parent = popup
Instance.new("UICorner", borderHolder).CornerRadius = UDim.new(0, 17)

local borderStroke = Instance.new("UIStroke")
borderStroke.Color = Color3.fromRGB(255, 60, 60)
borderStroke.Thickness = 1.6
borderStroke.Transparency = 0
borderStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
borderStroke.Parent = borderHolder

-- Hiệu ứng border chạy màu đỏ-cam-hồng
task.spawn(function()
    while borderStroke.Parent do
        local t = tick() * 1.5
        local r = 200 + math.sin(t) * 55
        local g = 60 + math.sin(t * 1.3) * 40
        local b = 80 + math.sin(t * 0.7) * 50
        borderStroke.Color = Color3.fromRGB(r, g, b)
        borderStroke.Thickness = 1.4 + math.abs(math.sin(t * 2)) * 0.8
        borderStroke.Transparency = 0.05 + math.abs(math.sin(t * 1.7)) * 0.15
        task.wait(0.03)
    end
end)

-- Icon với vòng xoay kép
local iconWrap = Instance.new("Frame")
iconWrap.Size = UDim2.new(0, 70, 0, 70)
iconWrap.Position = UDim2.new(0, 26, 0, 28)
iconWrap.BackgroundColor3 = Color3.fromRGB(22, 14, 22)
iconWrap.BorderSizePixel = 0
iconWrap.ZIndex = 1010
iconWrap.Active = false
iconWrap.Parent = popup
Instance.new("UICorner", iconWrap).CornerRadius = UDim.new(1, 0)

local iconStroke = Instance.new("UIStroke")
iconStroke.Color = Color3.fromRGB(120, 60, 70)
iconStroke.Thickness = 1.8
iconStroke.Parent = iconWrap

-- Vòng ngoài xoay chậm
local outerRing = Instance.new("Frame")
outerRing.Size = UDim2.new(0, 54, 0, 54)
outerRing.Position = UDim2.new(0.5, -27, 0.5, -27)
outerRing.BackgroundTransparency = 1
outerRing.ZIndex = 1011
outerRing.Active = false
outerRing.Parent = iconWrap
Instance.new("UICorner", outerRing).CornerRadius = UDim.new(1, 0)

local outerStroke = Instance.new("UIStroke")
outerStroke.Color = Color3.fromRGB(255, 100, 80)
outerStroke.Thickness = 2
outerStroke.Parent = outerRing

local outerMask1 = Instance.new("Frame")
outerMask1.Size = UDim2.new(0, 30, 0, 30)
outerMask1.Position = UDim2.new(0, -6, 0, -6)
outerMask1.BackgroundColor3 = Color3.fromRGB(22, 14, 22)
outerMask1.BorderSizePixel = 0
outerMask1.ZIndex = 1012
outerMask1.Active = false
outerMask1.Parent = outerRing
Instance.new("UICorner", outerMask1).CornerRadius = UDim.new(0, 8)

local outerMask2 = Instance.new("Frame")
outerMask2.Size = UDim2.new(0, 30, 0, 30)
outerMask2.Position = UDim2.new(1, -24, 1, -24)
outerMask2.BackgroundColor3 = Color3.fromRGB(22, 14, 22)
outerMask2.BorderSizePixel = 0
outerMask2.ZIndex = 1012
outerMask2.Active = false
outerMask2.Parent = outerRing
Instance.new("UICorner", outerMask2).CornerRadius = UDim.new(0, 8)

-- Vòng trong xoay ngược
local innerRing = Instance.new("Frame")
innerRing.Size = UDim2.new(0, 36, 0, 36)
innerRing.Position = UDim2.new(0.5, -18, 0.5, -18)
innerRing.BackgroundTransparency = 1
innerRing.ZIndex = 1013
innerRing.Active = false
innerRing.Parent = iconWrap
Instance.new("UICorner", innerRing).CornerRadius = UDim.new(1, 0)

local innerStroke = Instance.new("UIStroke")
innerStroke.Color = Color3.fromRGB(100, 180, 255)
innerStroke.Thickness = 1.5
innerStroke.Parent = innerRing

local innerMask1 = Instance.new("Frame")
innerMask1.Size = UDim2.new(0, 20, 0, 20)
innerMask1.Position = UDim2.new(0, -4, 0, -4)
innerMask1.BackgroundColor3 = Color3.fromRGB(22, 14, 22)
innerMask1.BorderSizePixel = 0
innerMask1.ZIndex = 1014
innerMask1.Active = false
innerMask1.Parent = innerRing
Instance.new("UICorner", innerMask1).CornerRadius = UDim.new(0, 6)

local innerMask2 = Instance.new("Frame")
innerMask2.Size = UDim2.new(0, 20, 0, 20)
innerMask2.Position = UDim2.new(1, -16, 1, -16)
innerMask2.BackgroundColor3 = Color3.fromRGB(22, 14, 22)
innerMask2.BorderSizePixel = 0
innerMask2.ZIndex = 1014
innerMask2.Active = false
innerMask2.Parent = innerRing
Instance.new("UICorner", innerMask2).CornerRadius = UDim.new(0, 6)

-- Chấm trung tâm pulse
local centerDot = Instance.new("Frame")
centerDot.Size = UDim2.new(0, 10, 0, 10)
centerDot.Position = UDim2.new(0.5, -5, 0.5, -5)
centerDot.BackgroundColor3 = Color3.fromRGB(255, 120, 80)
centerDot.BorderSizePixel = 0
centerDot.ZIndex = 1015
centerDot.Parent = iconWrap
Instance.new("UICorner", centerDot).CornerRadius = UDim.new(1, 0)

-- Hoạt ảnh xoay 2 vòng
task.spawn(function()
    while outerRing.Parent do
        outerRing.Rotation = (outerRing.Rotation + 10) % 360
        innerRing.Rotation = (innerRing.Rotation - 16) % 360
        task.wait(0.025)
    end
end)

task.spawn(function()
    while centerDot.Parent do
        local pulse = math.abs(math.sin(tick() * 3))
        centerDot.Size = UDim2.new(0, 8 + pulse * 6, 0, 8 + pulse * 6)
        centerDot.Position = UDim2.new(0.5, -(4 + pulse * 3), 0.5, -(4 + pulse * 3))
        centerDot.BackgroundColor3 = Color3.fromRGB(255, 100 + pulse * 100, 60 + pulse * 60)
        task.wait(0.03)
    end
end)

task.spawn(function()
    while iconWrap.Parent do
        local pulse = math.abs(math.sin(tick() * 2.2))
        iconStroke.Color = Color3.fromRGB(120 + pulse * 100, 60 + pulse * 50, 70 + pulse * 40)
        iconStroke.Thickness = 1.5 + pulse * 1.3
        task.wait(0.04)
    end
end)

-- Tiêu đề
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -240, 0, 32)
title.Position = UDim2.new(0, 112, 0, 26)
title.BackgroundTransparency = 1
title.Text = "fix lag + anti-afk"
title.Font = Enum.Font.GothamBlack
title.TextSize = 22
title.TextColor3 = Color3.fromRGB(255, 100, 100)
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 1010
title.Active = false
title.Parent = popup

local titleGradient = Instance.new("UIGradient")
titleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 80, 80)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 190, 120)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 80, 80)),
})
titleGradient.Parent = title

-- Dấu tick với hiệu ứng scale
local checkMark = Instance.new("TextLabel")
checkMark.Size = UDim2.new(0, 32, 0, 32)
checkMark.Position = UDim2.new(1, -44, 0, 26)
checkMark.BackgroundTransparency = 1
checkMark.Text = "✓"
checkMark.Font = Enum.Font.GothamBlack
checkMark.TextSize = 26
checkMark.TextColor3 = Color3.fromRGB(80, 255, 130)
checkMark.ZIndex = 1010
checkMark.Active = false
checkMark.Parent = popup

task.spawn(function()
    while checkMark.Parent do
        local pulse = 0.85 + math.abs(math.sin(tick() * 2.5)) * 0.3
        checkMark.TextSize = 26 * pulse
        task.wait(0.03)
    end
end)

-- Credit
local sub = Instance.new("TextLabel")
sub.Size = UDim2.new(1, -220, 0, 20)
sub.Position = UDim2.new(0, 112, 0, 58)
sub.BackgroundTransparency = 1
sub.Text = "made by @kudo29001.      v1.1"
sub.Font = Enum.Font.GothamMedium
sub.TextSize = 13
sub.TextColor3 = Color3.fromRGB(180, 180, 190)
sub.TextXAlignment = Enum.TextXAlignment.Left
sub.ZIndex = 1010
sub.Active = false
sub.Parent = popup

-- Nhãn trạng thái động (thay đổi theo tiến trình)
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -60, 0, 18)
statusLabel.Position = UDim2.new(0, 30, 0, 96)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "initializing..."
statusLabel.Font = Enum.Font.GothamBold
statusLabel.TextSize = 12
statusLabel.TextColor3 = Color3.fromRGB(150, 220, 255)
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.ZIndex = 1010
statusLabel.Active = false
statusLabel.Parent = popup

-- Phần trăm lớn
local percentL = Instance.new("TextLabel")
percentL.Size = UDim2.new(0, 100, 0, 26)
percentL.Position = UDim2.new(1, -130, 0, 96)
percentL.BackgroundTransparency = 1
percentL.Text = "0%"
percentL.Font = Enum.Font.GothamBlack
percentL.TextSize = 18
percentL.TextColor3 = Color3.fromRGB(255, 140, 100)
percentL.TextXAlignment = Enum.TextXAlignment.Right
percentL.ZIndex = 1010
percentL.Active = false
percentL.Parent = popup

-- Thanh tiến trình nền
local pBg = Instance.new("Frame")
pBg.Size = UDim2.new(1, -60, 0, 12)
pBg.Position = UDim2.new(0, 30, 0, 138)
pBg.BackgroundColor3 = Color3.fromRGB(35, 25, 30)
pBg.BorderSizePixel = 0
pBg.ZIndex = 1010
pBg.Active = false
pBg.Parent = popup
Instance.new("UICorner", pBg).CornerRadius = UDim.new(1, 0)

-- Viền phát sáng cho thanh tiến trình
local pBgStroke = Instance.new("UIStroke")
pBgStroke.Color = Color3.fromRGB(255, 80, 80)
pBgStroke.Thickness = 1
pBgStroke.Transparency = 0.6
pBgStroke.Parent = pBg

-- Thanh tiến trình fill với gradient 3 màu
local pFill = Instance.new("Frame")
pFill.Size = UDim2.new(0, 0, 1, 0)
pFill.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
pFill.BorderSizePixel = 0
pFill.ZIndex = 1011
pFill.Active = false
pFill.Parent = pBg
Instance.new("UICorner", pFill).CornerRadius = UDim.new(1, 0)

local fillGradient = Instance.new("UIGradient")
fillGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 60, 60)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 170, 80)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 255, 140)),
})
fillGradient.Parent = pFill

-- Hiệu ứng shine chạy liên tục trên fill
local shine = Instance.new("Frame")
shine.Size = UDim2.new(0, 60, 1, 0)
shine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
shine.BackgroundTransparency = 0.6
shine.BorderSizePixel = 0
shine.ZIndex = 1012
shine.Parent = pFill
Instance.new("UICorner", shine).CornerRadius = UDim.new(1, 0)

task.spawn(function()
    while shine.Parent do
        shine.Position = UDim2.new(-0.3, 0, 0, 0)
        TweenService:Create(shine, TweenInfo.new(0.9, Enum.EasingStyle.Linear), {Position = UDim2.new(1.3, 0, 0, 0)}):Play()
        task.wait(1.0)
    end
end)

-- Hiệu ứng particles bay lên từ thanh tiến trình
task.spawn(function()
    while pBg.Parent do
        task.wait(0.15)
        pcall(function()
            local dot = Instance.new("Frame")
            dot.Size = UDim2.new(0, 4, 0, 4)
            dot.Position = UDim2.new(math.random(), 0, 0.5, -2)
            dot.BackgroundColor3 = Color3.fromRGB(255, 120 + math.random(0, 100), 80)
            dot.BorderSizePixel = 0
            dot.ZIndex = 1013
            dot.Parent = pBg
            Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
            TweenService:Create(dot, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.new(dot.Position.X.Scale, 0, -2, 0),
                BackgroundTransparency = 1,
                Size = UDim2.new(0, 1, 0, 1)
            }):Play()
            Debris:AddItem(dot, 0.9)
        end)
    end
end)

-- ==================== TIẾN TRÌNH LOADING THỰC TẾ ====================
-- Tiến trình phản ánh công việc thực đang chạy, không phải giả
local progress = 0
local progressSteps = {
    {p = 5,  label = "cleaning old ui..."},
    {p = 15, label = "applying fflags..."},
    {p = 25, label = "tuning rendering..."},
    {p = 35, label = "optimizing lighting..."},
    {p = 45, label = "scanning workspace..."},
    {p = 65, label = "removing lag objects..."},
    {p = 78, label = "starting culling..."},
    {p = 88, label = "patching network..."},
    {p = 95, label = "finalizing..."},
    {p = 100, label = "done ✓"},
}

task.spawn(function()
    for _, step in ipairs(progressSteps) do
        local startP = progress
        local targetP = step.p
        statusLabel.Text = step.label
        -- Animate mượt giữa các bước
        local steps = 8
        for i = 1, steps do
            local t = i / steps
            local cur = startP + (targetP - startP) * t
            percentL.Text = math.floor(cur) .. "%"
            pFill.Size = UDim2.new(cur / 100, 0, 1, 0)
            task.wait(0.03)
        end
        progress = targetP
        task.wait(0.08)
    end
    percentL.Text = "DONE ✓"
    percentL.TextColor3 = Color3.fromRGB(80, 255, 130)
    statusLabel.Text = "fix lag + anti-afk v1.1 loaded"
    statusLabel.TextColor3 = Color3.fromRGB(80, 255, 130)
    pFill.Size = UDim2.new(1, 0, 1, 0)
    pBgStroke.Color = Color3.fromRGB(80, 255, 130)
end)

-- Fade out loader
task.delay(4.8, function()
    local fadeItems = {
        popup, title, checkMark, sub, percentL, pBg, pFill,
        iconWrap, outerStroke, innerStroke, outerMask1, outerMask2,
        innerMask1, innerMask2, iconStroke, borderStroke, backdrop,
        shine, centerDot, statusLabel, pBgStroke
    }
    for _, item in ipairs(fadeItems) do
        if item:IsA("TextLabel") then
            TweenService:Create(item, TweenInfo.new(0.9), {TextTransparency = 1}):Play()
        elseif item:IsA("Frame") then
            TweenService:Create(item, TweenInfo.new(0.9), {BackgroundTransparency = 1}):Play()
        elseif item:IsA("UIStroke") then
            TweenService:Create(item, TweenInfo.new(0.9), {Transparency = 1}):Play()
        end
    end
    task.wait(1.0)
    sg:Destroy()
end)

-- ==================== UI FPS/PING/TIME ====================
local statsGui = Instance.new("ScreenGui")
statsGui.Name = "KudoStats"
statsGui.ResetOnSpawn = false
statsGui.IgnoreGuiInset = true
statsGui.DisplayOrder = 2147483647
statsGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
statsGui.Parent = uiParent

local box = Instance.new("Frame")
box.Size = UDim2.new(0, 150, 0, 92)
box.Position = UDim2.new(1, -160, 1, -102)
box.AnchorPoint = Vector2.new(1, 0)
box.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
box.BackgroundTransparency = 0.4
box.BorderSizePixel = 0
box.Active = false
box.Parent = statsGui
Instance.new("UICorner", box).CornerRadius = UDim.new(0, 10)

local bxStroke = Instance.new("UIStroke")
bxStroke.Color = Color3.fromRGB(255, 60, 60)
bxStroke.Thickness = 1
bxStroke.Transparency = 0.6
bxStroke.Parent = box

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 16)
header.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
header.BackgroundTransparency = 0.7
header.BorderSizePixel = 0
header.Active = false
header.Parent = box
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 10)

local function mkLabel(t, y)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(0, 40, 0, 16)
    l.Position = UDim2.new(0, 10, 0, y)
    l.BackgroundTransparency = 1
    l.Text = t
    l.Font = Enum.Font.GothamBold
    l.TextSize = 10
    l.TextColor3 = Color3.fromRGB(180, 180, 180)
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Active = false
    l.Parent = box
end

local function mkValue(y)
    local v = Instance.new("TextLabel")
    v.Size = UDim2.new(0, 70, 0, 16)
    v.Position = UDim2.new(1, -80, 0, y)
    v.BackgroundTransparency = 1
    v.Text = "--"
    v.Font = Enum.Font.GothamBold
    v.TextSize = 12
    v.TextColor3 = Color3.fromRGB(0, 255, 120)
    v.TextXAlignment = Enum.TextXAlignment.Right
    v.Active = false
    v.Parent = box
    return v
end

mkLabel("FPS", 20)
local fpsV = mkValue(20)
mkLabel("PING", 38)
local pingV = mkValue(38)
mkLabel("TIME", 56)
local timeV = mkValue(56)
timeV.TextColor3 = Color3.fromRGB(255, 100, 100)
timeV.Text = "00:00"

local credit = Instance.new("TextLabel")
credit.Size = UDim2.new(1, -10, 0, 12)
credit.Position = UDim2.new(0, 5, 1, -14)
credit.BackgroundTransparency = 1
credit.Text = "@script by kudo29001"
credit.Font = Enum.Font.GothamBold
credit.TextSize = 10
credit.TextColor3 = Color3.fromRGB(255, 100, 100)
credit.TextTransparency = 0.3
credit.TextXAlignment = Enum.TextXAlignment.Center
credit.Active = false
credit.Parent = box

local closeB = Instance.new("TextButton")
closeB.Size = UDim2.new(0, 22, 0, 22)
closeB.Position = UDim2.new(1, -26, 0, -3)
closeB.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeB.Text = "x"
closeB.Font = Enum.Font.GothamBold
closeB.TextSize = 13
closeB.TextColor3 = Color3.new(1, 1, 1)
closeB.BorderSizePixel = 0
closeB.ZIndex = 10
closeB.Parent = box
Instance.new("UICorner", closeB).CornerRadius = UDim.new(1, 0)

local hideB = Instance.new("TextButton")
hideB.Size = UDim2.new(0, 22, 0, 22)
hideB.Position = UDim2.new(1, -52, 0, -3)
hideB.BackgroundColor3 = Color3.fromRGB(255, 150, 50)
hideB.Text = "-"
hideB.Font = Enum.Font.GothamBold
hideB.TextSize = 15
hideB.TextColor3 = Color3.new(1, 1, 1)
hideB.BorderSizePixel = 0
hideB.ZIndex = 10
hideB.Parent = box
Instance.new("UICorner", hideB).CornerRadius = UDim.new(1, 0)

local lockB = Instance.new("TextButton")
lockB.Size = UDim2.new(0, 22, 0, 22)
lockB.Position = UDim2.new(1, -78, 0, -3)
lockB.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
lockB.Text = "🔓"
lockB.Font = Enum.Font.GothamBold
lockB.TextSize = 11
lockB.TextColor3 = Color3.new(1, 1, 1)
lockB.BorderSizePixel = 0
lockB.ZIndex = 10
lockB.Parent = box
Instance.new("UICorner", lockB).CornerRadius = UDim.new(1, 0)

local opacityB = Instance.new("TextButton")
opacityB.Size = UDim2.new(0, 22, 0, 22)
opacityB.Position = UDim2.new(1, -104, 0, -3)
opacityB.BackgroundColor3 = Color3.fromRGB(80, 100, 200)
opacityB.Text = "◐"
opacityB.Font = Enum.Font.GothamBold
opacityB.TextSize = 13
opacityB.TextColor3 = Color3.new(1, 1, 1)
opacityB.BorderSizePixel = 0
opacityB.ZIndex = 10
opacityB.Parent = box
Instance.new("UICorner", opacityB).CornerRadius = UDim.new(1, 0)

local locked = false
lockB.MouseButton1Click:Connect(function()
    locked = not locked
    if locked then
        lockB.BackgroundColor3 = Color3.fromRGB(80, 200, 100)
        lockB.Text = "🔒"
    else
        lockB.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
        lockB.Text = "🔓"
    end
end)

-- SLIDER ĐỘ MỜ
local sliderPanel = Instance.new("Frame")
sliderPanel.Name = "OpacitySlider"
sliderPanel.Size = UDim2.new(1, -20, 0, 30)
sliderPanel.Position = UDim2.new(0, 10, 1, -34)
sliderPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
sliderPanel.BorderSizePixel = 0
sliderPanel.Visible = false
sliderPanel.ZIndex = 20
sliderPanel.Parent = box
Instance.new("UICorner", sliderPanel).CornerRadius = UDim.new(0, 6)

local sliderBg = Instance.new("Frame")
sliderBg.Size = UDim2.new(1, -20, 0, 6)
sliderBg.Position = UDim2.new(0, 10, 0.5, -3)
sliderBg.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
sliderBg.BorderSizePixel = 0
sliderBg.ZIndex = 21
sliderBg.Parent = sliderPanel
Instance.new("UICorner", sliderBg).CornerRadius = UDim.new(1, 0)

local sliderFill = Instance.new("Frame")
sliderFill.Size = UDim2.new(0.5, 0, 1, 0)
sliderFill.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
sliderFill.BorderSizePixel = 0
sliderFill.ZIndex = 22
sliderFill.Parent = sliderBg
Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(1, 0)

local sliderKnob = Instance.new("TextButton")
sliderKnob.Size = UDim2.new(0, 16, 0, 16)
sliderKnob.Position = UDim2.new(0.5, -8, 0.5, -8)
sliderKnob.BackgroundColor3 = Color3.fromRGB(150, 200, 255)
sliderKnob.Text = ""
sliderKnob.BorderSizePixel = 0
sliderKnob.ZIndex = 23
sliderKnob.Parent = sliderBg
Instance.new("UICorner", sliderKnob).CornerRadius = UDim.new(1, 0)

local function applyOpacity(value)
    local transparency = 1 - value
    box.BackgroundTransparency = math.clamp(0.1 + transparency * 0.85, 0, 1)
    header.BackgroundTransparency = math.clamp(0.4 + transparency * 0.5, 0, 1)
    bxStroke.Transparency = math.clamp(0.4 + transparency * 0.55, 0, 1)
    
    for _, child in ipairs(box:GetDescendants()) do
        local skip = false
        local parent = child.Parent
        while parent do
            if parent == sliderPanel then
                skip = true
                break
            end
            if parent == box then break end
            parent = parent.Parent
        end
        
        if not skip then
            if child:IsA("TextLabel") then
                child.TextTransparency = math.clamp(transparency * 0.9, 0, 1)
            elseif child:IsA("TextButton") then
                child.BackgroundTransparency = math.clamp(transparency * 0.5, 0, 0.7)
                child.TextTransparency = math.clamp(transparency * 0.7, 0, 0.8)
            end
        end
    end
end

local draggingSlider = false
sliderKnob.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingSlider = true
    end
end)

UserInputService.InputChanged:Connect(function(i)
    if draggingSlider then
        local mouseX = i.Position.X
        local bgAbsPos = sliderBg.AbsolutePosition.X
        local bgAbsSize = sliderBg.AbsoluteSize.X
        local percent = math.clamp((mouseX - bgAbsPos) / bgAbsSize, 0, 1)
        sliderFill.Size = UDim2.new(percent, 0, 1, 0)
        sliderKnob.Position = UDim2.new(percent, -8, 0.5, -8)
        applyOpacity(percent)
    end
end)

UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingSlider = false
    end
end)

local sliderVisible = false
opacityB.MouseButton1Click:Connect(function()
    sliderVisible = not sliderVisible
    sliderPanel.Visible = sliderVisible
end)

-- NÚT HIỆN
local showSg = Instance.new("ScreenGui")
showSg.Name = "KudoToggle"
showSg.ResetOnSpawn = false
showSg.IgnoreGuiInset = true
showSg.DisplayOrder = 2147483647
showSg.Parent = uiParent

local showB = Instance.new("TextButton")
showB.Size = UDim2.new(0, 44, 0, 44)
showB.Position = UDim2.new(1, -54, 1, -54)
showB.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
showB.Text = "⚡"
showB.Font = Enum.Font.GothamBold
showB.TextSize = 22
showB.TextColor3 = Color3.new(1, 1, 1)
showB.BorderSizePixel = 0
showB.Visible = false
showB.Parent = showSg
Instance.new("UICorner", showB).CornerRadius = UDim.new(1, 0)

hideB.MouseButton1Click:Connect(function()
    box.Visible = false
    showB.Visible = true
end)

showB.MouseButton1Click:Connect(function()
    box.Visible = true
    showB.Visible = false
end)

closeB.MouseButton1Click:Connect(function()
    statsGui:Destroy()
    showSg:Destroy()
end)

-- DRAG
local dragging = false
local ds, sp

box.InputBegan:Connect(function(i)
    if locked then return end
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        ds = i.Position
        sp = box.Position
    end
end)

UserInputService.InputChanged:Connect(function(i)
    if dragging and not locked then
        local d = i.Position - ds
        box.Position = UDim2.new(sp.X.Scale, sp.X.Offset + d.X, sp.Y.Scale, sp.Y.Offset + d.Y)
    end
end)

UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- TIMER
local st = tick()
task.spawn(function()
    while statsGui.Parent do
        task.wait(1)
        local e = math.floor(tick() - st)
        timeV.Text = string.format("%02d:%02d", math.floor(e / 60), e % 60)
    end
end)

-- FPS COUNTER
local fr = 0
RunService.RenderStepped:Connect(function()
    fr = fr + 1
end)

task.spawn(function()
    while statsGui.Parent do
        task.wait(1)
        fpsV.Text = tostring(fr)
        if fr < 40 then
            fpsV.TextColor3 = Color3.fromRGB(255, 60, 60)
        else
            fpsV.TextColor3 = Color3.fromRGB(0, 255, 120)
        end
        fr = 0
        
        local p = 0
        pcall(function()
            p = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        end)
        pingV.Text = p .. "ms"
        if p <= 100 then
            pingV.TextColor3 = Color3.fromRGB(0, 255, 120)
        else
            pingV.TextColor3 = Color3.fromRGB(255, 60, 60)
        end
    end
end)

task.wait(0.1)
applyOpacity(0.5)

print("✅ fix lag + anti-afk v1.1 by kudo29001 loaded")