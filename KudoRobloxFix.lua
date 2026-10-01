local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Terrain = Workspace:FindFirstChildOfClass("Terrain")
local Camera = Workspace.CurrentCamera
local Stats = game:GetService("Stats")

-- ==================== GUI CHÍNH ====================
local sg = Instance.new("ScreenGui")
sg.Name = "KudoPotato"
sg.ResetOnSpawn = false
sg.IgnoreGuiInset = true
sg.Parent = playerGui

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 260, 0, 90)
main.Position = UDim2.new(0.5, -130, 0.5, -45)
main.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
main.BackgroundTransparency = 0.05
main.BorderSizePixel = 0
main.Parent = sg
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(0, 220, 100)
stroke.Thickness = 1.5
stroke.Transparency = 0.3
stroke.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 22)
title.Position = UDim2.new(0, 10, 0, 8)
title.BackgroundTransparency = 1
title.Text = "🥔 POTATO MODE"
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextColor3 = Color3.fromRGB(0, 255, 120)
title.TextXAlignment = Enum.TextXAlignment.Center
title.Parent = main

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -20, 0, 16)
status.Position = UDim2.new(0, 10, 0, 32)
status.BackgroundTransparency = 1
status.Text = "Đang khởi tạo..."
status.Font = Enum.Font.Gotham
status.TextSize = 10
status.TextColor3 = Color3.fromRGB(200, 200, 200)
status.TextXAlignment = Enum.TextXAlignment.Center
status.Parent = main

local percent = Instance.new("TextLabel")
percent.Size = UDim2.new(1, -20, 0, 14)
percent.Position = UDim2.new(0, 10, 0, 50)
percent.BackgroundTransparency = 1
percent.Text = "0%"
percent.Font = Enum.Font.GothamBold
percent.TextSize = 11
percent.TextColor3 = Color3.fromRGB(0, 255, 120)
percent.TextXAlignment = Enum.TextXAlignment.Center
percent.Parent = main

local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(1, -40, 0, 5)
barBg.Position = UDim2.new(0, 20, 0, 68)
barBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
barBg.BorderSizePixel = 0
barBg.Parent = main
Instance.new("UICorner", barBg).CornerRadius = UDim.new(0, 3)

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(0, 220, 100)
barFill.BorderSizePixel = 0
barFill.Parent = barBg
Instance.new("UICorner", barFill).CornerRadius = UDim.new(0, 3)

local function setProgress(p, text)
    p = math.clamp(p, 0, 100)
    barFill.Size = UDim2.new(p / 100, 0, 1, 0)
    percent.Text = math.floor(p) .. "%"
    if text then status.Text = text end
end

-- ==================== 1. FFLAG (đẩy lên mức tối đa) ====================
pcall(function()
    setfflag("DFIntTaskSchedulerTargetFps", "9999")
    setfflag("DFIntFrameRateCap", "9999")
    setfflag("DFIntMaxFrameRate", "9999")
    setfflag("DFIntMinFrameRate", "1")
    setfflag("FFlagDisableVSync", "True")
    setfflag("DFIntFrameRateCapOverride", "9999")
    setfflag("DFIntRenderThrottleEnabled", "0")
    setfflag("DFIntRenderThrottleMs", "0")
    setfflag("FFlagRenderThrottleDisable", "True")
    setfflag("DFIntMaxFramesInFlight", "1")
    setfflag("FFlagDisableFrameLimiter", "True")

    setfflag("DFIntDebugFRMQualityLevelOverride", "1")
    setfflag("DFIntTextureQualityOverride", "0")
    setfflag("DFFlagTextureQualityOverrideEnabled", "True")
    setfflag("FFlagTextureQualityOverride", "True")
    setfflag("FIntDebugForceMSAASamples", "1")

    setfflag("DFFlagDisableSSAO", "True")
    setfflag("FFlagDisableSSAO", "True")
    setfflag("FFlagDisablePostFx", "True")
    setfflag("FFlagDisableBloom", "True")
    setfflag("FFlagDisableDepthOfField", "True")
    setfflag("FFlagDisableSunRays", "True")
    setfflag("FFlagDisableColorCorrection", "True")
    setfflag("FFlagDisableAntiAliasing", "True")
    setfflag("FFlagDisableMotionBlur", "True")

    setfflag("FFlagRenderShadowIntensity", "0")
    setfflag("FFlagRenderShadowIntensityOverride", "True")
    setfflag("DFFlagDisableRenderShadowMap", "True")
    setfflag("FFlagDisableShadows", "True")

    setfflag("FFlagDebugSkyGray", "True")
    setfflag("FFlagDisableAtmosphere", "True")
    setfflag("FFlagDisableSky", "True")
    setfflag("FFlagDisableSkybox", "True")
    setfflag("FFlagDisableFog", "True")
    setfflag("FFlagDisableWater", "True")

    setfflag("FFlagDisableTerrain", "True")
    setfflag("DFFlagDisableTerrainTextures", "True")
    setfflag("FFlagDisableTerrainDecoration", "True")
    setfflag("FIntFRMMaxGrassDistance", "0")
    setfflag("FIntFRMMinGrassDistance", "0")

    setfflag("DFIntCSGLevelOfDetailSwitchingDistance", "0")
    setfflag("DFIntCSGLevelOfDetailSwitchingDistanceL12", "0")
    setfflag("DFIntCSGLevelOfDetailSwitchingDistanceL23", "0")
    setfflag("DFIntCSGLevelOfDetailSwitchingDistanceL34", "0")
    setfflag("FFlagDisableLODTransitions", "True")
    setfflag("FFlagForceLOD0", "True")
    setfflag("DFIntLODBias", "4")

    setfflag("FFlagDisableDynamicLighting", "True")
    setfflag("FFlagDisablePointLightShadows", "True")
    setfflag("FFlagDisableSpotLightShadows", "True")
    setfflag("FFlagDisableSurfaceLightShadows", "True")
    setfflag("DFFlagDebugRenderForceTechnologyVoxel", "True")
    setfflag("FFlagDebugPauseVoxelizer", "True")

    setfflag("DFIntSolverSpringDamping", "0")
    setfflag("DFIntPhysicsSendRate", "1")
    setfflag("DFIntMaxSimultaneousPhysicsJobs", "1")
    setfflag("DFIntPhysicsStepPerFrame", "1")
    setfflag("DFIntMaximumCollisionIterations", "1")
    setfflag("DFIntSolverConvergenceIterations", "1")

    setfflag("DFFlagGCEnableIncremental", "True")
    setfflag("DFIntGCIncrementalPause", "0")
    setfflag("DFIntGCIncrementalStepMul", "1000")

    setfflag("DFIntFrameBufferPoolSize", "1")
    setfflag("DFIntRenderMeshMaxBones", "1")
    setfflag("DFIntDebugEngineOptimizationLevel", "3")
    setfflag("DFFlagForceTextureLOD", "True")
    setfflag("DFFlagTextureCompositorEnable", "False")
    setfflag("DFFlagTextureCompositorEnabled", "False")
    setfflag("FFlagDisableAnimationBlending", "True")
    setfflag("DFFlagSkipAnimationBlending", "True")
    setfflag("FFlagDisableFacialAnimation", "True")
    setfflag("DFIntConnectionMTUSize", "1400")
end)

setProgress(10, "Tối ưu engine...")

-- Engine config chạy song song
task.spawn(function()
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01
        settings().Rendering.AnimationWeightedBlendFix = Enum.AnimationWeightedBlendFix.Disabled
        settings().Rendering.EagerBulkExecution = true
    end)
end)

task.spawn(function()
    pcall(function()
        if Camera then
            Camera.FieldOfView = 70
            Camera.CameraType = Enum.CameraType.Custom
        end
    end)
end)

-- ==================== 2. DỌN HÀNG LOẠT (bulk) ====================
setProgress(20, "Dọn sky / atmo / terrain...")

-- Xóa toàn bộ PostFX, Sky, Atmosphere, Clouds khỏi Lighting
pcall(function()
    for _, v in ipairs(Lighting:GetChildren()) do
        if v:IsA("PostEffect") or v:IsA("Sky") or v:IsA("Atmosphere") or v:IsA("Clouds") then
            v:Destroy()
        end
    end
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 1e9
    Lighting.FogStart = 1e9
    Lighting.Brightness = 2
    Lighting.EnvironmentDiffuseScale = 0
    Lighting.EnvironmentSpecularScale = 0
    Lighting.OutdoorAmbient = Color3.fromRGB(180, 180, 180)
    Lighting.Ambient = Color3.fromRGB(180, 180, 180)
    Lighting.ClockTime = 14
    Lighting.ExposureCompensation = 0
    Lighting.ShadowSoftness = 0
end)

-- Terrain: xóa nước, cỏ, decoration
pcall(function()
    if Terrain then
        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveSpeed = 0
        Terrain.WaterReflectance = 0
        Terrain.WaterTransparency = 0.5
        Terrain.WaterColor = Color3.fromRGB(60, 130, 220)  -- nước = dải xanh đơn giản
        Terrain.Decoration = false
    end
end)

-- Streaming để render ít part hơn
pcall(function()
    Workspace.StreamingEnabled = true
    Workspace.StreamingTargetRadius = 128
    Workspace.StreamingMinRadius = 64
end)

-- ==================== 3. CACHE NHÂN VẬT ====================
setProgress(35, "Chuẩn bị danh sách...")

local charModels = {}
local function watchPlayer(plr)
    plr.CharacterAdded:Connect(function(c) charModels[c] = true end)
    if plr.Character then charModels[plr.Character] = true end
end
for _, plr in ipairs(game.Players:GetPlayers()) do watchPlayer(plr) end
game.Players.PlayerAdded:Connect(watchPlayer)
game.Players.PlayerRemoving:Connect(function(plr)
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

-- ==================== 4. BULK DESTROY — xoá hàng loạt ====================
setProgress(45, "Dọn hàng loạt...")

-- Danh sách loại có thể xoá thẳng (không cần kiểm tra parent phức tạp)
local killTypes = {
    ParticleEmitter = true,
    Trail = true,
    Smoke = true,
    Fire = true,
    Sparkles = true,
    Beam = true,
    Highlight = true,
    SelectionBox = true,
    BoxHandleAdornment = true,
    PointLight = true,
    SpotLight = true,
    SurfaceLight = true,
    ForceField = true,
    Explosion = true,
    Sound = true,
    Animation = true,
    SurfaceAppearance = true,
}

-- Kiểm tra kiểu có thuộc nhân vật không (dùng cho Sound/Animation của char)
local function insideChar(v)
    if isName(v) then return true end
    if isChar(v) then return true end
    return false
end

local descendants = Workspace:GetDescendants()
local total = #descendants
local batch = math.max(1, math.floor(total / 10))

-- Gom theo nhóm để xoá hàng loạt
for i = 1, total do
    local v = descendants[i]
    local cn = v.ClassName

    if killTypes[cn] then
        if not insideChar(v) then
            pcall(function() v:Destroy() end)
        end
    elseif cn == "BasePart" or cn == "MeshPart" or cn == "UnionOperation" or cn == "Part" then
        if isChar(v) then
            pcall(function()
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
                v.CastShadow = false
            end)
        else
            pcall(function()
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
                v.CastShadow = false
            end)
        end
    elseif cn == "Decal" or cn == "Texture" then
        pcall(function() v.Transparency = 1 end)
    elseif cn == "SpecialMesh" then
        pcall(function()
            if v.MeshType == Enum.MeshType.FileMesh or v.MeshType == Enum.MeshType.Head then
                v.MeshType = Enum.MeshType.Brick
                v.TextureId = ""
            end
        end)
    end

    if i % batch == 0 then
        setProgress(45 + math.floor((i / total) * 50), "Dọn " .. i .. "/" .. total)
        task.wait()
    end
end

-- ==================== 5. LẮNG NGHE OBJECT MỚI ====================
setProgress(96, "Hoàn thiện...")

local scanConn = Workspace.DescendantAdded:Connect(function(v)
    task.defer(function()
        local cn = v.ClassName
        pcall(function()
            if killTypes[cn] then
                if not insideChar(v) then v:Destroy() end
            elseif cn == "BasePart" or cn == "MeshPart" then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
                v.CastShadow = false
            elseif cn == "Decal" or cn == "Texture" then
                v.Transparency = 1
            elseif cn == "SpecialMesh" then
                if v.MeshType == Enum.MeshType.FileMesh or v.MeshType == Enum.MeshType.Head then
                    v.MeshType = Enum.MeshType.Brick
                    v.TextureId = ""
                end
            end
        end)
    end)
end)

-- ==================== 6. VÒNG LẶP NGẦM ====================
task.spawn(function()
    while sg.Parent do
        task.wait(20)
        pcall(function() collectgarbage("collect") end)
    end
end)

-- ==================== 7. CAMERA CULLING ====================
local cullCounter = 0
local cullConn = RunService.Heartbeat:Connect(function()
    cullCounter = cullCounter + 1
    if cullCounter < 4 then return end
    cullCounter = 0
    pcall(function()
        if not Camera then return end
        local camPos = Camera.CFrame.Position
        local camLook = Camera.CFrame.LookVector
        for _, v in ipairs(Workspace:GetChildren()) do
            if v:IsA("BasePart") and not isChar(v) then
                local dist = (v.Position - camPos).Magnitude
                if dist > 250 then
                    v.LocalTransparencyModifier = 1
                else
                    local toPart = (v.Position - camPos).Unit
                    if camLook:Dot(toPart) < -0.15 then
                        v.LocalTransparencyModifier = 1
                    else
                        v.LocalTransparencyModifier = 0
                    end
                end
            end
        end
    end)
end)

-- ==================== 8. FPS + PING COUNTER ====================
local statsGui = Instance.new("ScreenGui")
statsGui.Name = "KudoStats"
statsGui.ResetOnSpawn = false
statsGui.IgnoreGuiInset = true
statsGui.Parent = playerGui

local statsFrame = Instance.new("Frame")
statsFrame.Size = UDim2.new(0, 130, 0, 46)
statsFrame.Position = UDim2.new(1, -140, 1, -56)
statsFrame.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
statsFrame.BackgroundTransparency = 0.35
statsFrame.BorderSizePixel = 0
statsFrame.Parent = statsGui
Instance.new("UICorner", statsFrame).CornerRadius = UDim.new(0, 8)

local fpsLabel = Instance.new("TextLabel")
fpsLabel.Size = UDim2.new(1, -10, 0, 20)
fpsLabel.Position = UDim2.new(0, 5, 0, 3)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Text = "FPS: --"
fpsLabel.Font = Enum.Font.Times
fpsLabel.TextSize = 15
fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 120)
fpsLabel.TextXAlignment = Enum.TextXAlignment.Right
fpsLabel.Parent = statsFrame

local pingLabel = Instance.new("TextLabel")
pingLabel.Size = UDim2.new(1, -10, 0, 20)
pingLabel.Position = UDim2.new(0, 5, 0, 22)
pingLabel.BackgroundTransparency = 1
pingLabel.Text = "Ping: --"
pingLabel.Font = Enum.Font.Times
pingLabel.TextSize = 15
pingLabel.TextColor3 = Color3.fromRGB(0, 255, 120)
pingLabel.TextXAlignment = Enum.TextXAlignment.Right
pingLabel.Parent = statsFrame

local frames = 0
task.spawn(function()
    RunService.RenderStepped:Connect(function() frames = frames + 1 end)
    while statsGui.Parent do
        task.wait(0.5)
        local fps = math.floor(frames * 2 + 0.5)
        frames = 0
        local fpsColor
        if fps >= 60 then fpsColor = Color3.fromRGB(0, 255, 120)
        elseif fps >= 30 then fpsColor = Color3.fromRGB(255, 220, 60)
        else fpsColor = Color3.fromRGB(255, 80, 80) end
        fpsLabel.Text = "FPS: " .. fps
        fpsLabel.TextColor3 = fpsColor

        local ping = 0
        pcall(function()
            ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        end)
        local pingColor
        if ping <= 60 then pingColor = Color3.fromRGB(0, 255, 120)
        elseif ping <= 150 then pingColor = Color3.fromRGB(255, 220, 60)
        else pingColor = Color3.fromRGB(255, 80, 80) end
        pingLabel.Text = "Ping: " .. ping .. "ms"
        pingLabel.TextColor3 = pingColor
    end
end)

-- ==================== 9. KẾT THÚC ====================
setProgress(100, "✅ Potato Mode bật")
title.Text = "🥔 kudo29001"
status.Text = ""
percent.Text = ""
barBg.Visible = false
barFill.Visible = false
main.Size = UDim2.new(0, 200, 0, 40)
main.Position = UDim2.new(0, 15, 0, 15)
title.Size = UDim2.new(1, -20, 1, -10)
title.Position = UDim2.new(0, 10, 0, 5)
title.TextSize = 12

task.delay(3, function()
    pcall(function()
        main.Visible = false
        if scanConn then scanConn:Disconnect() end
        if cullConn then cullConn:Disconnect() end
        sg:Destroy()
    end)
end)

print("✅ Kudo Potato Mode loaded")