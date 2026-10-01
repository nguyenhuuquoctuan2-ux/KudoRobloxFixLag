local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local Terrain = Workspace:FindFirstChildOfClass("Terrain")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ==================== FPS COUNTER (độc lập) ====================
local fpsGui = Instance.new("ScreenGui")
fpsGui.Name = "KudoFPS"
fpsGui.ResetOnSpawn = false
fpsGui.IgnoreGuiInset = true
fpsGui.Parent = PlayerGui

local fpsLabel = Instance.new("TextLabel")
fpsLabel.Name = "FPSLabel"
fpsLabel.Size = UDim2.new(0, 120, 0, 24)
fpsLabel.Position = UDim2.new(1, -130, 1, -30)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Text = "FPS: --"
fpsLabel.Font = Enum.Font.Times
fpsLabel.TextSize = 16
fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 120)
fpsLabel.TextXAlignment = Enum.TextXAlignment.Right
fpsLabel.Parent = fpsGui

local frameCount = 0
task.spawn(function()
    RunService.RenderStepped:Connect(function()
        frameCount = frameCount + 1
    end)
    while fpsGui.Parent do
        task.wait(0.5)
        local fps = math.floor(frameCount * 2 + 0.5)
        frameCount = 0
        local color
        if fps >= 60 then
            color = Color3.fromRGB(0, 255, 120)
        elseif fps >= 30 then
            color = Color3.fromRGB(255, 220, 60)
        else
            color = Color3.fromRGB(255, 80, 80)
        end
        fpsLabel.Text = "FPS: " .. fps
        fpsLabel.TextColor3 = color
    end
end)

-- ==================== GUI FIX LAG ====================
local gui = Instance.new("ScreenGui")
gui.Name = "KudoFixLag"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = PlayerGui

local panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 260, 0, 100)
panel.Position = UDim2.new(0.5, -130, 0.5, -50)
panel.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
panel.BorderSizePixel = 0
panel.Parent = gui
Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 10)

local panelStroke = Instance.new("UIStroke")
panelStroke.Color = Color3.fromRGB(0, 220, 100)
panelStroke.Thickness = 1
panelStroke.Transparency = 0.3
panelStroke.Parent = panel

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 22)
title.Position = UDim2.new(0, 10, 0, 10)
title.BackgroundTransparency = 1
title.Text = "⚡ KUDO FIX LAG"
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextColor3 = Color3.fromRGB(0, 255, 120)
title.Parent = panel

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -20, 0, 16)
status.Position = UDim2.new(0, 10, 0, 34)
status.BackgroundTransparency = 1
status.Text = "Đang khởi tạo..."
status.Font = Enum.Font.Gotham
status.TextSize = 10
status.TextColor3 = Color3.fromRGB(200, 200, 200)
status.Parent = panel

local percentText = Instance.new("TextLabel")
percentText.Size = UDim2.new(1, -20, 0, 14)
percentText.Position = UDim2.new(0, 10, 0, 52)
percentText.BackgroundTransparency = 1
percentText.Text = "0%"
percentText.Font = Enum.Font.GothamBold
percentText.TextSize = 11
percentText.TextColor3 = Color3.fromRGB(0, 255, 120)
percentText.Parent = panel

local progressBg = Instance.new("Frame")
progressBg.Size = UDim2.new(1, -40, 0, 5)
progressBg.Position = UDim2.new(0, 20, 0, 72)
progressBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
progressBg.BorderSizePixel = 0
progressBg.Parent = panel
Instance.new("UICorner", progressBg).CornerRadius = UDim.new(0, 3)

local progressFill = Instance.new("Frame")
progressFill.Size = UDim2.new(0, 0, 1, 0)
progressFill.BackgroundColor3 = Color3.fromRGB(0, 220, 100)
progressFill.BorderSizePixel = 0
progressFill.Parent = progressBg
Instance.new("UICorner", progressFill).CornerRadius = UDim.new(0, 3)

local function setProgress(p, text)
    p = math.clamp(p, 0, 100)
    progressFill.Size = UDim2.new(p / 100, 0, 1, 0)
    percentText.Text = math.floor(p) .. "%"
    if text then status.Text = text end
end

-- ==================== ÁP DỤNG CẤU HÌNH ====================
setProgress(5, "Tối ưu ánh sáng...")
pcall(function()
    for _, v in ipairs(Lighting:GetChildren()) do
        if v:IsA("PostEffect") then v.Enabled = false end
        if v:IsA("Sky") then v.Parent = nil end
        if v:IsA("Atmosphere") then v.Density = 0; v.Haze = 0 end
        if v:IsA("Clouds") then v.Cover = 0; v.Density = 0 end
    end
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 1e9
    Lighting.FogStart = 1e9
    Lighting.Brightness = 1
    Lighting.EnvironmentDiffuseScale = 0
    Lighting.EnvironmentSpecularScale = 0
    Lighting.OutdoorAmbient = Color3.fromRGB(128,128,128)
    Lighting.Ambient = Color3.fromRGB(128,128,128)
    Lighting.ClockTime = 14
    Lighting.ExposureCompensation = 0
    Lighting.ShadowSoftness = 0
end)

setProgress(15, "Tối ưu Terrain...")
pcall(function()
    if Terrain then
        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveSpeed = 0
        Terrain.WaterReflectance = 0
        Terrain.WaterTransparency = 1
        Terrain.Decoration = false
    end
end)

setProgress(25, "Tối ưu Camera...")
pcall(function()
    if Camera then
        Camera.FieldOfView = 70
        Camera.CameraType = Enum.CameraType.Custom
    end
    Workspace.StreamingEnabled = true
    Workspace.StreamingTargetRadius = 256
    Workspace.StreamingMinRadius = 64
end)

setProgress(35, "Áp dụng FastFlags...")
pcall(function()
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
    setfflag("FFlagDisableVSync", "True")
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
    setfflag("DFFlagDebugRenderForceTechnologyVoxel", "True")
    setfflag("FFlagDebugPauseVoxelizer", "True")
    setfflag("DFIntSolverSpringDamping", "0")
    setfflag("DFIntMaxSimultaneousPhysicsJobs", "1")
    setfflag("DFIntMaximumCollisionIterations", "1")
    setfflag("DFIntSolverConvergenceIterations", "1")
    setfflag("DFIntTaskSchedulerTargetFps", "240")
    setfflag("DFIntFrameRateCap", "240")
    setfflag("DFIntMinFrameRate", "30")
    setfflag("DFIntMaxFrameRate", "240")
    setfflag("DFFlagGCEnableIncremental", "True")
    setfflag("DFIntGCIncrementalPause", "1")
    setfflag("DFIntGCIncrementalStepMul", "500")
    setfflag("DFIntFrameBufferPoolSize", "1")
    setfflag("DFIntRenderMeshMaxBones", "1")
    setfflag("DFIntDebugEngineOptimizationLevel", "3")
    setfflag("DFFlagForceTextureLOD", "True")
    setfflag("DFFlagTextureCompositorEnable", "False")
    setfflag("DFFlagTextureCompositorEnabled", "False")
    setfflag("FFlagDisableAnimationBlending", "True")
    setfflag("DFFlagSkipAnimationBlending", "True")
end)

setProgress(45, "Tối ưu âm thanh...")
pcall(function()
    SoundService.AmbientReverb = Enum.ReverbType.NoReverb
    SoundService.DistanceFactor = 0
    SoundService.DopplerScale = 0
    pcall(function() SoundService.VolumetricAudio = Enum.VolumetricAudio.Disabled end)
end)

-- ==================== CHUẨN BỊ QUÉT ====================
local protectedTypes = {
    BillboardGui = true,
    TextLabel = true,
    TextButton = true,
    TextScreenGui = true,
    Humanoid = true,
    Accessory = true,
    Sound = true,
    Animator = true,
    AnimationController = true,
    Animation = true,
    KeyframeSequence = true,
    Keyframe = true,
    Pose = true,
}

local potatoMaterials = {
    [Enum.Material.Grass]=true, [Enum.Material.LeafyGrass]=true, [Enum.Material.Wood]=true,
    [Enum.Material.WoodPlanks]=true, [Enum.Material.Rock]=true, [Enum.Material.Slate]=true,
    [Enum.Material.Sand]=true, [Enum.Material.Mud]=true, [Enum.Material.Snow]=true,
    [Enum.Material.Ice]=true, [Enum.Material.Glacier]=true, [Enum.Material.CorrodedMetal]=true,
    [Enum.Material.DiamondPlate]=true, [Enum.Material.Foil]=true, [Enum.Material.Marble]=true,
    [Enum.Material.Granite]=true, [Enum.Material.Brick]=true, [Enum.Material.Cobblestone]=true,
    [Enum.Material.Concrete]=true, [Enum.Material.Fabric]=true, [Enum.Material.Pebble]=true,
    [Enum.Material.Limestone]=true, [Enum.Material.Pavement]=true, [Enum.Material.Asphalt]=true,
    [Enum.Material.Basalt]=true, [Enum.Material.CrackedLava]=true, [Enum.Material.Neon]=true,
    [Enum.Material.Glass]=true, [Enum.Material.ForceField]=true, [Enum.Material.Metal]=true,
    [Enum.Material.Cardboard]=true, [Enum.Material.Carpet]=true, [Enum.Material.CeramicTiles]=true,
    [Enum.Material.ClayRoofTiles]=true, [Enum.Material.RoofShingles]=true, [Enum.Material.Leather]=true,
    [Enum.Material.Plaster]=true, [Enum.Material.Rubber]=true,
}

local function optimize(v)
    local cn = v.ClassName
    if protectedTypes[cn] then return end

    if v:IsA("BasePart") then
        pcall(function()
            if potatoMaterials[v.Material] then v.Material = Enum.Material.SmoothPlastic end
            v.Reflectance = 0
            v.CastShadow = false
        end)
    elseif cn == "Decal" or cn == "Texture" then
        pcall(function() v.Transparency = 1 end)
    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke")
        or v:IsA("Fire") or v:IsA("Sparkles") or v:IsA("Beam") then
        pcall(function() v.Enabled = false end)
    elseif cn == "SurfaceAppearance" then
        pcall(function() v:Destroy() end)
    elseif cn == "SpecialMesh" then
        pcall(function()
            if v.MeshType == Enum.MeshType.FileMesh or v.MeshType == Enum.MeshType.Head then
                v.TextureId = ""
            end
        end)
    elseif cn == "MeshPart" then
        pcall(function()
            v.TextureID = ""
            v.RenderFidelity = Enum.RenderFidelity.Performance
            v.CastShadow = false
        end)
    elseif v:IsA("Highlight") or v:IsA("SelectionBox") or v:IsA("BoxHandleAdornment") then
        pcall(function() v.Enabled = false end)
    elseif cn == "Attachment" then
        pcall(function()
            for _, c in ipairs(v:GetChildren()) do
                if c:IsA("ParticleEmitter") or c:IsA("Trail") or c:IsA("Beam") or c:IsA("Light") then
                    c:Destroy()
                end
            end
        end)
    elseif v:IsA("PointLight") or v:IsA("SpotLight") or v:IsA("SurfaceLight") then
        pcall(function() v:Destroy() end)
    end
end

-- ==================== QUÉT ====================
local descendants = Workspace:GetDescendants()
local total = #descendants
local stepSize = math.max(1, math.floor(total / 25))

for i, v in ipairs(descendants) do
    optimize(v)
    if i % stepSize == 0 then
        setProgress(45 + math.floor((i / total) * 50), "Đang quét " .. i .. "/" .. total)
        task.wait()
    end
end

setProgress(97, "Hoàn thiện...")
task.wait(0.1)

local scanConn = Workspace.DescendantAdded:Connect(function(v)
    task.defer(function() optimize(v) end)
end)

-- GC ngầm
task.spawn(function()
    while gui.Parent do
        task.wait(20)
        pcall(function() collectgarbage("collect") end)
    end
end)

-- Quét particle mới định kỳ (không đụng nhân vật)
task.spawn(function()
    while gui.Parent do
        task.wait(4)
        pcall(function()
            for _, v in ipairs(Workspace:GetDescendants()) do
                if (v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam")
                    or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles")) then
                    local parent = v.Parent
                    local skip = false
                    local cur = v
                    while cur do
                        if cur:IsA("Accessory") or cur:IsA("Tool") then
                            skip = true
                            break
                        end
                        if cur:IsA("Model") and cur:FindFirstChildOfClass("Humanoid") then
                            skip = true
                            break
                        end
                        cur = cur.Parent
                    end
                    if not skip then
                        v.Enabled = false
                    end
                end
            end
        end)
    end
end)

setProgress(100, "✅ Hoàn tất")
task.wait(0.5)

-- ==================== ẨN GUI ====================
title.Text = "⚡ fix lag by kudo29001"
status.Text = ""
percentText.Text = ""
progressBg.Visible = false
progressFill.Visible = false

TweenService:Create(panel, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
    Size = UDim2.new(0, 210, 0, 40),
    Position = UDim2.new(0, 15, 0, 15)
}):Play()
TweenService:Create(title, TweenInfo.new(0.4), {
    Size = UDim2.new(1, -20, 1, -10),
    Position = UDim2.new(0, 10, 0, 5),
    TextSize = 12
}):Play()

task.wait(4)

pcall(function()
    TweenService:Create(panel, TweenInfo.new(0.5), {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 15, 0, 0)
    }):Play()
    TweenService:Create(title, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(panelStroke, TweenInfo.new(0.5), {Transparency = 1}):Play()
    task.wait(0.6)
    if scanConn then scanConn:Disconnect() end
    gui:Destroy()
end)

print("✅ fix lag by kudo29001 - loaded")