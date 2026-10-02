--[[
    KudoRobloxFix v2.0 - Tối ưu giảm lag & ping nâng cao
    Tác giả gốc: kudo29001
    Nâng cấp bởi: palofsc
    Mô tả: Script tối ưu FPS, giảm ping, chống AFK, culling thông minh,
           quản lý bộ nhớ, tối ưu render, physics, network.
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

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Xác định UI parent an toàn
local uiParent = PlayerGui
pcall(function()
    if gethui then uiParent = gethui() end
end)

-- ==================== DỌN UI CŨ ====================
local function destroyOldUI()
    local function scan(container)
        if not container then return end
        for _, v in ipairs(container:GetChildren()) do
            if v:IsA("ScreenGui") then
                local n = v.Name:lower()
                if n:find("kudo") or n:find("fixlag") or n:find("mailbox") or n:find("sender") then
                    pcall(function() v:Destroy() end)
                end
                -- Dọn UI rác từ script cũ
                if v:FindFirstChild("BorderHolder") or v:FindFirstChild("Runner") or v:FindFirstChild("RunnerDot") then
                    pcall(function() v:Destroy() end)
                end
            end
        end
    end
    scan(PlayerGui)
    pcall(function() scan(CoreGui) end)
end

for _ = 1, 3 do
    destroyOldUI()
    task.wait(0.1)
end

-- ==================== FFLAG TỐI ƯU ====================
-- Nhóm 1: FPS & VSync
pcall(function()
    setfflag("DFIntTaskSchedulerTargetFps", "9999")
    setfflag("DFIntFrameRateCap", "9999")
    setfflag("DFIntMaxFrameRate", "9999")
    setfflag("FFlagDisableVSync", "True")
    setfflag("DFIntDebugFRMQualityLevelOverride", "1")
end)

-- Nhóm 2: Texture & Material
pcall(function()
    setfflag("DFIntTextureQualityOverride", "0")
    setfflag("DFFlagTextureQualityOverrideEnabled", "True")
    setfflag("FFlagTextureQualityOverride", "True")
    setfflag("FFlagDisableTextures", "True")
    setfflag("FFlagDisableSurfaceAppearance", "True")
    setfflag("FFlagDisableDecals", "True")
end)

-- Nhóm 3: Post-processing & Lighting
pcall(function()
    setfflag("DFFlagDisableSSAO", "True")
    setfflag("FFlagDisableSSAO", "True")
    setfflag("FFlagDisablePostFx", "True")
    setfflag("FFlagDisableBloom", "True")
    setfflag("FFlagDisableDepthOfField", "True")
    setfflag("FFlagDisableSunRays", "True")
    setfflag("FFlagDisableAntiAliasing", "True")
    setfflag("FFlagDisableMotionBlur", "True")
    setfflag("FFlagDisableHDR", "True")
    setfflag("FFlagDisableToneMapping", "True")
    setfflag("FFlagDisableMultiSample", "True")
end)

-- Nhóm 4: Shadow & Environment
pcall(function()
    setfflag("FFlagRenderShadowIntensity", "0")
    setfflag("FFlagRenderShadowIntensityOverride", "True")
    setfflag("FFlagDisableShadows", "True")
    setfflag("FFlagDebugSkyGray", "True")
    setfflag("FFlagDisableAtmosphere", "True")
    setfflag("FFlagDisableSky", "True")
    setfflag("FFlagDisableFog", "True")
    setfflag("FFlagDisableTerrainDecoration", "True")
    setfflag("FIntFRMMaxGrassDistance", "0")
end)

-- Nhóm 5: LOD & Mesh
pcall(function()
    setfflag("DFIntCSGLevelOfDetailSwitchingDistance", "0")
    setfflag("FFlagDisableLODTransitions", "True")
    setfflag("FFlagForceLOD0", "True")
    setfflag("DFIntLODBias", "8")
end)

-- Nhóm 6: Physics
pcall(function()
    setfflag("DFFlagDebugRenderForceTechnologyVoxel", "True")
    setfflag("FFlagDebugPauseVoxelizer", "True")
    setfflag("DFIntSolverSpringDamping", "0")
    setfflag("DFIntMaxSimultaneousPhysicsJobs", "1")
    setfflag("DFIntPhysicsStepPerFrame", "1")
    setfflag("DFIntMaximumCollisionIterations", "1")
    setfflag("DFIntSolverConvergenceIterations", "1")
end)

-- Nhóm 7: Render pipeline
pcall(function()
    setfflag("DFIntFrameBufferPoolSize", "1")
    setfflag("DFIntDebugEngineOptimizationLevel", "3")
    setfflag("DFFlagDisableGPUOcclusion", "True")
    setfflag("FFlagRenderDisableForwardLights", "True")
    setfflag("DFIntNumberOfRenderPasses", "1")
    setfflag("DFIntMaxConcurrentRenderPasses", "1")
end)

-- Nhóm 8: Network & Replication (giảm ping)
pcall(function()
    setfflag("DFIntMaxDataPacketsPerFrame", "1")
    setfflag("DFIntMaxDataPacketsPerSecond", "60")
    setfflag("FFlagDisableRemoteEventsThrottling", "False")
    setfflag("DFIntRemoteEventThrottleLimit", "10")
    setfflag("FFlagOptimizeNetworkSend", "True")
    setfflag("DFIntNetworkClusterPacketCache", "1")
end)

-- ==================== CÀI ĐẶT RENDERING ====================
pcall(function()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01
    settings().Rendering.AnimationWeightedBlendFix = Enum.AnimationWeightedBlendFix.Disabled
    settings().Rendering.EagerBulkExecution = true
end)

-- ==================== TỐI ƯU CAMERA & WORKSPACE ====================
pcall(function()
    if Camera then
        Camera.FieldOfView = 70
        -- Giảm render distance của camera
        Camera.CFrame = Camera.CFrame
    end
    Workspace.StreamingEnabled = true
    Workspace.StreamingTargetRadius = 64  -- Giảm từ 80 xuống 64
    Workspace.StreamingMinRadius = 32     -- Giảm từ 40 xuống 32
end)

-- ==================== TỐI ƯU LIGHTING ====================
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
    Lighting.FogEnd = 3000  -- Giảm từ 5000 xuống 3000 để giảm tải
end)

-- ==================== TỐI ƯU TERRAIN ====================
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

-- ==================== CHỐNG AFK TỐI ƯU ====================
-- Chỉ gửi input khi cần, không spam network
task.spawn(function()
    while true do
        task.wait(120)  -- Tăng từ 90 lên 120 giây
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

-- ==================== LOẠI BỎ VẬT THỂ GÂY LAG ====================
local killTypes = {
    ParticleEmitter = true, Trail = true, Smoke = true, Fire = true,
    Sparkles = true, Beam = true, Highlight = true, SelectionBox = true,
    BoxHandleAdornment = true, PointLight = true, SpotLight = true,
    SurfaceLight = true, ForceField = true, Explosion = true,
    Animation = true, SurfaceAppearance = true,
    Decal = true, Texture = true, SpecialMesh = true,
    -- Thêm các loại mới
    BillboardGui = false,  -- Giữ lại billboard quan trọng
    Sound = false,         -- Sound xử lý riêng
    Cloth = true,
    WrapLayer = true,
    WrapTarget = true,
    Atmosphere = true,
    Clouds = true,
    Sky = true,
    DepthOfFieldEffect = true,
    BloomEffect = true,
    BlurEffect = true,
    ColorCorrectionEffect = true,
    SunRaysEffect = true,
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
            -- Giảm chi tiết mesh
            if v:IsA("MeshPart") then
                v.RenderFidelity = Enum.RenderFidelity.Performance
            end
        end)
    elseif cn == "Model" then
        -- Tắt collision của model trang trí
        pcall(function()
            v.LevelOfDetail = Enum.ModelLevelOfDetail.StreamingMesh
        end)
    end
end

-- Quét toàn bộ workspace ban đầu (chia nhỏ để không block)
task.spawn(function()
    local descendants = Workspace:GetDescendants()
    for i = 1, #descendants do
        handleObject(descendants[i])
        if i % 500 == 0 then task.wait() end
    end
end)

-- Xử lý vật thể mới thêm vào
Workspace.DescendantAdded:Connect(function(v)
    task.defer(function()
        pcall(function() handleObject(v) end)
    end)
end)

-- ==================== CULLING THÔNG MINH ====================
-- Culling part xa camera, chỉ áp dụng cho part tĩnh
local CULL_DIST_SQ = 60 * 60  -- Giảm từ 70 xuống 60
local culled = {}
local cullEnabled = true

task.spawn(function()
    while cullEnabled do
        task.wait(1.0)  -- Tăng từ 0.8 lên 1.0 giây để giảm tải CPU
        pcall(function()
            if not Camera then return end
            local camPos = Camera.CFrame.Position
            for _, v in ipairs(Workspace:GetChildren()) do
                if v:IsA("BasePart") and not isChar(v) then
                    -- Chỉ cull part không quan trọng
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

-- ==================== TỐI ƯU ÂM THANH ====================
-- Tắt âm thanh xa camera để giảm tải network
task.spawn(function()
    while true do
        task.wait(8)  -- Tăng từ 5 lên 8 giây
        pcall(function()
            if not Camera then return end
            local camPos = Camera.CFrame.Position
            for _, v in ipairs(Workspace:GetDescendants()) do
                if v:IsA("Sound") and v.Playing then
                    local parent = v.Parent
                    if parent and parent:IsA("BasePart") then
                        local d = parent.Position - camPos
                        if d.X*d.X + d.Y*d.Y + d.Z*d.Z > 3600 then  -- 60 studs
                            v.Volume = 0
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
            if count > 8 then  -- Giảm từ 10 xuống 8
                v.Enabled = false
            end
        end
    end
end)

-- ==================== QUẢN LÝ BỘ NHỚ ====================
-- GC định kỳ, tăng tần suất khi cần
task.spawn(function()
    while true do
        task.wait(45)  -- Giảm từ 60 xuống 45 giây
        pcall(function()
            collectgarbage("collect")
            collectgarbage("collect")
        end)
    end
end)

-- ==================== TỐI ƯU NETWORK PING ====================
-- Giảm tần suất gửi dữ liệu không cần thiết
task.spawn(function()
    while true do
        task.wait(3)
        pcall(function()
            -- Tắt các hiệu ứng không cần thiết để giảm network sync
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

-- ==================== POPUP THÔNG BÁO ====================
local sg = Instance.new("ScreenGui")
sg.Name = "KudoPopup"
sg.ResetOnSpawn = false
sg.IgnoreGuiInset = true
sg.DisplayOrder = 2147483647
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.Parent = uiParent

local popup = Instance.new("Frame")
popup.Size = UDim2.new(0, 380, 0, 150)
popup.Position = UDim2.new(0.5, -190, 0.4, -75)
popup.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
popup.BorderSizePixel = 0
popup.Active = false
popup.ZIndex = 1000
popup.ClipsDescendants = true
popup.Parent = sg
Instance.new("UICorner", popup).CornerRadius = UDim.new(0, 14)

local borderHolder = Instance.new("Frame")
borderHolder.Name = "BorderHolder"
borderHolder.Size = UDim2.new(1, -4, 1, -4)
borderHolder.Position = UDim2.new(0, 2, 0, 2)
borderHolder.BackgroundTransparency = 1
borderHolder.ZIndex = 1001
borderHolder.Active = false
borderHolder.Parent = popup
Instance.new("UICorner", borderHolder).CornerRadius = UDim.new(0, 13)

local borderStroke = Instance.new("UIStroke")
borderStroke.Color = Color3.fromRGB(255, 60, 60)
borderStroke.Thickness = 1.2
borderStroke.Transparency = 0
borderStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
borderStroke.Parent = borderHolder

task.spawn(function()
    while borderStroke.Parent do
        borderStroke.Color = Color3.fromRGB(255, 60 + math.abs(math.sin(tick() * 2)) * 40, 60)
        borderStroke.Thickness = 1 + math.abs(math.sin(tick() * 1.5)) * 0.6
        task.wait(0.05)
    end
end)

local iconWrap = Instance.new("Frame")
iconWrap.Size = UDim2.new(0, 52, 0, 52)
iconWrap.Position = UDim2.new(0, 20, 0, 22)
iconWrap.BackgroundColor3 = Color3.fromRGB(25, 15, 20)
iconWrap.BorderSizePixel = 0
iconWrap.ZIndex = 1010
iconWrap.Active = false
iconWrap.Parent = popup
Instance.new("UICorner", iconWrap).CornerRadius = UDim.new(1, 0)

local iconStroke = Instance.new("UIStroke")
iconStroke.Color = Color3.fromRGB(80, 50, 55)
iconStroke.Thickness = 1.5
iconStroke.Parent = iconWrap

local arcHolder = Instance.new("Frame")
arcHolder.Size = UDim2.new(0, 34, 0, 34)
arcHolder.Position = UDim2.new(0.5, -17, 0.5, -17)
arcHolder.BackgroundTransparency = 1
arcHolder.ZIndex = 1011
arcHolder.Active = false
arcHolder.Parent = iconWrap

local arcRing = Instance.new("Frame")
arcRing.Size = UDim2.new(1, 0, 1, 0)
arcRing.BackgroundTransparency = 1
arcRing.Active = false
arcRing.Parent = arcHolder
Instance.new("UICorner", arcRing).CornerRadius = UDim.new(1, 0)

local arcStroke = Instance.new("UIStroke")
arcStroke.Color = Color3.fromRGB(255, 255, 255)
arcStroke.Thickness = 3
arcStroke.Parent = arcRing

local mask1 = Instance.new("Frame")
mask1.Size = UDim2.new(0, 20, 0, 20)
mask1.Position = UDim2.new(0, -3, 0, -3)
mask1.BackgroundColor3 = Color3.fromRGB(25, 15, 20)
mask1.BorderSizePixel = 0
mask1.ZIndex = 1012
mask1.Active = false
mask1.Parent = arcHolder
Instance.new("UICorner", mask1).CornerRadius = UDim.new(0, 4)

local mask2 = Instance.new("Frame")
mask2.Size = UDim2.new(0, 20, 0, 20)
mask2.Position = UDim2.new(1, -17, 1, -17)
mask2.BackgroundColor3 = Color3.fromRGB(25, 15, 20)
mask2.BorderSizePixel = 0
mask2.ZIndex = 1012
mask2.Active = false
mask2.Parent = arcHolder
Instance.new("UICorner", mask2).CornerRadius = UDim.new(0, 4)

task.spawn(function()
    while arcHolder.Parent do
        arcHolder.Rotation = (arcHolder.Rotation + 12) % 360
        task.wait(0.04)
    end
end)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -200, 0, 26)
title.Position = UDim2.new(0, 88, 0, 22)
title.BackgroundTransparency = 1
title.Text = "fix lag + anti-afk v2.0"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(255, 100, 100)
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 1010
title.Active = false
title.Parent = popup

local checkMark = Instance.new("TextLabel")
checkMark.Size = UDim2.new(0, 24, 0, 26)
checkMark.Position = UDim2.new(1, -32, 0, 22)
checkMark.BackgroundTransparency = 1
checkMark.Text = "✓"
checkMark.Font = Enum.Font.GothamBold
checkMark.TextSize = 18
checkMark.TextColor3 = Color3.fromRGB(80, 255, 130)
checkMark.ZIndex = 1010
checkMark.Active = false
checkMark.Parent = popup

local sub = Instance.new("TextLabel")
sub.Size = UDim2.new(1, -180, 0, 18)
sub.Position = UDim2.new(0, 88, 0, 50)
sub.BackgroundTransparency = 1
sub.Text = "made by kudo29001 | upgrade by palofsc"
sub.Font = Enum.Font.Gotham
sub.TextSize = 12
sub.TextColor3 = Color3.fromRGB(170, 170, 180)
sub.TextXAlignment = Enum.TextXAlignment.Left
sub.ZIndex = 1010
sub.Active = false
sub.Parent = popup

local percentL = Instance.new("TextLabel")
percentL.Size = UDim2.new(1, -40, 0, 22)
percentL.Position = UDim2.new(0, 20, 0, 82)
percentL.BackgroundTransparency = 1
percentL.Text = "0%"
percentL.Font = Enum.Font.GothamBold
percentL.TextSize = 16
percentL.TextColor3 = Color3.fromRGB(255, 130, 100)
percentL.ZIndex = 1010
percentL.Active = false
percentL.Parent = popup

local pBg = Instance.new("Frame")
pBg.Size = UDim2.new(1, -40, 0, 8)
pBg.Position = UDim2.new(0, 20, 0, 112)
pBg.BackgroundColor3 = Color3.fromRGB(40, 30, 35)
pBg.BorderSizePixel = 0
pBg.ZIndex = 1010
pBg.Active = false
pBg.Parent = popup
Instance.new("UICorner", pBg).CornerRadius = UDim.new(1, 0)

local pFill = Instance.new("Frame")
pFill.Size = UDim2.new(0, 0, 1, 0)
pFill.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
pFill.BorderSizePixel = 0
pFill.ZIndex = 1011
pFill.Active = false
pFill.Parent = pBg
Instance.new("UICorner", pFill).CornerRadius = UDim.new(1, 0)

task.spawn(function()
    local st = tick()
    while tick() - st < 3 do
        local t = (tick() - st) / 3
        if t > 1 then t = 1 end
        percentL.Text = math.floor(t * 100) .. "%"
        pFill.Size = UDim2.new(t, 0, 1, 0)
        task.wait(0.06)
    end
    percentL.Text = "DONE ✓"
    percentL.TextColor3 = Color3.fromRGB(80, 255, 130)
    pFill.Size = UDim2.new(1, 0, 1, 0)
    pFill.BackgroundColor3 = Color3.fromRGB(80, 255, 130)
end)

task.delay(4.5, function()
    local fadeItems = {popup, title, checkMark, sub, percentL, pBg, pFill, iconWrap, arcStroke, mask1, mask2, iconStroke, borderStroke}
    for _, item in ipairs(fadeItems) do
        if item:IsA("TextLabel") then
            TweenService:Create(item, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
        elseif item:IsA("Frame") then
            TweenService:Create(item, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
        elseif item:IsA("UIStroke") then
            TweenService:Create(item, TweenInfo.new(0.6), {Transparency = 1}):Play()
        end
    end
    task.wait(0.7)
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
credit.Text = "@script by kudo29001 | v2.0 palofsc"
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

print("✅ fix lag + anti-afk v2.0 by kudo29001 | upgrade by palofsc loaded")