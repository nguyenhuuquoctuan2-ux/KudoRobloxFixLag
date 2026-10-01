local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local RunService = game:GetService("RunService")
local Terrain = Workspace:FindFirstChildOfClass("Terrain")
local Camera = Workspace.CurrentCamera

local sg = Instance.new("ScreenGui")
sg.Name = "FixLag"
sg.ResetOnSpawn = false
sg.IgnoreGuiInset = true
sg.Parent = playerGui

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 0, 0, 0)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
main.BackgroundTransparency = 0.05
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Parent = sg
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 14)

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(0, 220, 100)
mainStroke.Thickness = 1.5
mainStroke.Transparency = 1
mainStroke.Parent = main

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -20, 0, 26)
titleLabel.Position = UDim2.new(0, 10, 0, 22)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "⚡ FIX LAG"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 17
titleLabel.TextColor3 = Color3.fromRGB(0, 255, 120)
titleLabel.TextXAlignment = Enum.TextXAlignment.Center
titleLabel.TextTransparency = 1
titleLabel.Parent = main

local subLabel = Instance.new("TextLabel")
subLabel.Size = UDim2.new(1, -20, 0, 16)
subLabel.Position = UDim2.new(0, 10, 0, 50)
subLabel.BackgroundTransparency = 1
subLabel.Text = "by kudo29001"
subLabel.Font = Enum.Font.Gotham
subLabel.TextSize = 10
subLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
subLabel.TextXAlignment = Enum.TextXAlignment.Center
subLabel.TextTransparency = 1
subLabel.Parent = main

local percentLabel = Instance.new("TextLabel")
percentLabel.Size = UDim2.new(1, -20, 0, 20)
percentLabel.Position = UDim2.new(0, 10, 0, 78)
percentLabel.BackgroundTransparency = 1
percentLabel.Text = "0%"
percentLabel.Font = Enum.Font.GothamBold
percentLabel.TextSize = 15
percentLabel.TextColor3 = Color3.fromRGB(0, 255, 120)
percentLabel.TextXAlignment = Enum.TextXAlignment.Center
percentLabel.TextTransparency = 1
percentLabel.Parent = main

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -30, 0, 16)
statusLabel.Position = UDim2.new(0, 15, 0, 102)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Đang khởi tạo..."
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 10
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
statusLabel.TextXAlignment = Enum.TextXAlignment.Center
statusLabel.TextTransparency = 1
statusLabel.Parent = main

local progressBg = Instance.new("Frame")
progressBg.Size = UDim2.new(1, -50, 0, 7)
progressBg.Position = UDim2.new(0, 25, 0, 130)
progressBg.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
progressBg.BorderSizePixel = 0
progressBg.BackgroundTransparency = 1
progressBg.Parent = main
Instance.new("UICorner", progressBg).CornerRadius = UDim.new(0, 4)

local progressFill = Instance.new("Frame")
progressFill.Size = UDim2.new(0, 0, 1, 0)
progressFill.BackgroundColor3 = Color3.fromRGB(0, 220, 100)
progressFill.BorderSizePixel = 0
progressFill.Parent = progressBg
Instance.new("UICorner", progressFill).CornerRadius = UDim.new(0, 4)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 22, 0, 22)
closeBtn.Position = UDim2.new(1, -30, 0, 8)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
closeBtn.Text = "✕"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 12
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.BorderSizePixel = 0
closeBtn.BackgroundTransparency = 1
closeBtn.TextTransparency = 1
closeBtn.Parent = main
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

local fpsLabel = Instance.new("TextLabel")
fpsLabel.Name = "FPS"
fpsLabel.Size = UDim2.new(0, 110, 0, 24)
fpsLabel.Position = UDim2.new(1, -120, 1, -32)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Text = "FPS: --"
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.TextSize = 13
fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 120)
fpsLabel.TextXAlignment = Enum.TextXAlignment.Right
fpsLabel.Parent = sg

local done = false

local function setProgress(percent, text)
    percent = math.clamp(percent, 0, 100)
    progressFill.Size = UDim2.new(percent / 100, 0, 1, 0)
    percentLabel.Text = math.floor(percent) .. "%"
    if text then statusLabel.Text = text end
end

local function step(text, fn, percent)
    setProgress(percent, text)
    pcall(fn)
    task.wait(0.05)
end

-- ========== FFLAGS ==========
step("Áp dụng FastFlags...", function()
    setfflag("DFIntDebugFRMQualityLevelOverride", "1")
    setfflag("DFIntTextureQualityOverride", "0")
    setfflag("DFFlagTextureQualityOverrideEnabled", "True")
    setfflag("FFlagTextureQualityOverride", "True")
    setfflag("FIntDebugForceMSAASamples", "1")
    setfflag("FFlagDebugSkyGray", "True")
    setfflag("FFlagDisablePostFx", "True")
    setfflag("FFlagDisableTerrain", "True")
    setfflag("FFlagRenderFixFog", "True")
    setfflag("FFlagRenderShadowIntensity", "0")
    setfflag("FFlagRenderShadowIntensityOverride", "True")
    setfflag("FFlagRenderEnableShadowIntensityOverride", "True")
    setfflag("DFIntCSGLevelOfDetailSwitchingDistance", "0")
    setfflag("DFIntCSGLevelOfDetailSwitchingDistanceL12", "0")
    setfflag("DFIntCSGLevelOfDetailSwitchingDistanceL23", "0")
    setfflag("DFIntCSGLevelOfDetailSwitchingDistanceL34", "0")
    setfflag("FIntFRMMaxGrassDistance", "0")
    setfflag("FIntFRMMinGrassDistance", "0")
    setfflag("FIntGrassMovementReducedMotionFactor", "0")
    setfflag("DFFlagDisableTerrainTextures", "True")
    setfflag("DFFlagDebugRenderForceTechnologyVoxel", "True")
    setfflag("FFlagDebugPauseVoxelizer", "True")
    setfflag("DFFlagSkipHighResolutionEnvironment", "True")
    setfflag("DFFlagTextureCompositorEnable", "False")
    setfflag("DFFlagTextureCompositorEnabled", "False")
    setfflag("DFFlagForceTextureLOD", "True")
    setfflag("DFFlagDisableDPIScale", "True")
    setfflag("DFIntSolverSpringDamping", "0")
    setfflag("DFIntPhysicsSendRate", "1")
    setfflag("DFIntMaxSimultaneousPhysicsJobs", "1")
    setfflag("DFIntTaskSchedulerTargetFps", "240")
    setfflag("FFlagTaskSchedulerUseTaskQueue", "True")
    setfflag("DFIntConnectionMTUSize", "1400")
    setfflag("FFlagDisableDPIScale", "True")
    setfflag("DFFlagDisableGPUOcclusion", "False")
    setfflag("FFlagDebugGraphicsDisableDirect3D11", "True")
    setfflag("FFlagDebugGraphicsPreferOpenGL", "True")
    setfflag("FFlagDebugGraphicsPreferVulkan", "True")
    setfflag("FFlagDisableRenderMeshes", "True")
    setfflag("FFlagRenderDisableWireframe", "True")
    setfflag("FFlagDisableParticleMesh", "True")
    setfflag("DFFlagDisableRenderShadowMap", "True")
    setfflag("FFlagDisableAtmosphere", "True")
    setfflag("FFlagDisableSky", "True")
    setfflag("FFlagDisableSkybox", "True")
    setfflag("FFlagDisableFog", "True")
    setfflag("FFlagDisableWater", "True")
    setfflag("FFlagDisableTerrainDecoration", "True")
    setfflag("DFFlagSkipRenderMesh", "True")
    setfflag("FFlagDisableParticleEffects", "True")
    setfflag("FFlagDisableTrails", "True")
    setfflag("FFlagDisableBeams", "True")
    setfflag("FFlagDisableBillboards", "True")
    setfflag("FFlagDisableDecals", "True")
    setfflag("FFlagDisableTextures", "True")
    setfflag("FFlagDisableSurfaceAppearance", "True")
    setfflag("FFlagDisableMaterialTextures", "True")
    setfflag("FFlagDisableReflections", "True")
    setfflag("FFlagDisableGlassRefraction", "True")
    setfflag("DFFlagDisableSSAO", "True")
    setfflag("FFlagDisableSSAO", "True")
    setfflag("FFlagDisableAntiAliasing", "True")
    setfflag("FFlagDisableVSync", "True")
    setfflag("FFlagDisableMotionBlur", "True")
    setfflag("FFlagDisableDepthOfField", "True")
    setfflag("FFlagDisableBloom", "True")
    setfflag("FFlagDisableSunRays", "True")
    setfflag("FFlagDisableColorCorrection", "True")
    setfflag("FFlagDisableAtmosphericScattering", "True")
    setfflag("FFlagRenderSkipTerrain", "True")
    setfflag("DFFlagRenderSkipMaterialTextures", "True")
    setfflag("FFlagRenderSkipLighting", "True")
    setfflag("FFlagRenderSkipSpecular", "True")
    setfflag("FFlagRenderSkipNormal", "True")
    setfflag("FFlagRenderSkipRoughness", "True")
    setfflag("FFlagRenderSkipMetalness", "True")
    setfflag("FFlagRenderSkipEmissive", "True")
    setfflag("DFIntFrameBufferPoolSize", "1")
    setfflag("DFIntRenderMeshMaxBones", "1")
    setfflag("DFIntDebugEngineOptimizationLevel", "3")
    setfflag("DFFlagGCEnableIncremental", "True")
    setfflag("DFIntGCIncrementalPause", "1")
    setfflag("DFIntGCIncrementalStepMul", "500")
    setfflag("DFIntMinFrameRate", "30")
    setfflag("DFIntMaxFrameRate", "240")
    setfflag("DFIntFrameRateCap", "240")
    setfflag("FFlagDisableAnimationBlending", "True")
    setfflag("FFlagDisableFacialAnimation", "True")
    setfflag("FFlagDisableAllAnimations", "True")
    setfflag("DFFlagSkipAnimationBlending", "True")
    setfflag("FFlagDisableIKControl", "True")
    setfflag("FFlagDisableHikeAnimation", "True")
    setfflag("FFlagDisableShadows", "True")
    setfflag("FFlagDisableDynamicLighting", "True")
    setfflag("FFlagDisablePointLightShadows", "True")
    setfflag("FFlagDisableSpotLightShadows", "True")
    setfflag("FFlagDisableSurfaceLightShadows", "True")
    setfflag("FFlagDisableSpriteSheet", "True")
    setfflag("FFlagDisableRagdoll", "True")
    setfflag("FFlagDisableLODTransitions", "True")
    setfflag("DFFlagSkipLODTransitions", "True")
    setfflag("FFlagForceLOD0", "True")
    setfflag("DFIntLODBias", "4")
    setfflag("DFIntPhysicsTickerMaxTime", "1")
    setfflag("DFIntPhysicsStepPerFrame", "1")
    setfflag("FFlagDisableRaycastFiltering", "True")
    setfflag("DFFlagSkipRaycastFiltering", "True")
    setfflag("DFIntMaximumCollisionIterations", "1")
    setfflag("DFIntSolverConvergenceIterations", "1")
    setfflag("FFlagDisableRenderingShadows", "True")
    setfflag("FFlagDisableRenderingWater", "True")
    setfflag("FFlagDisableRenderingTerrain", "True")
    setfflag("FFlagDisableRenderingDecals", "True")
    setfflag("FFlagDisableRenderingTextures", "True")
    setfflag("FFlagDisableRenderingParticles", "True")
    setfflag("FFlagDisableRenderingBeams", "True")
    setfflag("FFlagDisableRenderingTrails", "True")
end, 12)

step("Hạ graphics...", function()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01
    settings().Rendering.AnimationWeightedBlendFix = Enum.AnimationWeightedBlendFix.Disabled
    settings().Rendering.EagerBulkExecution = true
    settings().Rendering.EditQualityLevel = Enum.QualityLevel.Level01
end, 22)

step("Tối ưu Camera...", function()
    if Camera then
        Camera.FieldOfView = 70
        Camera.CameraType = Enum.CameraType.Custom
    end
    pcall(function() workspace.StreamingEnabled = true end)
    pcall(function() workspace.StreamingTargetRadius = 128 end)
    pcall(function() workspace.StreamingMinRadius = 64 end)
end, 30)

step("Tắt Terrain...", function()
    if Terrain then
        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveSpeed = 0
        Terrain.WaterReflectance = 0
        Terrain.WaterTransparency = 1
        Terrain.Decoration = false
        pcall(function() Terrain:Clear() end)
    end
end, 38)

step("Tắt PostFX & Lighting...", function()
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
    Lighting.GeographicLatitude = 0
    Lighting.ExposureCompensation = 0
    Lighting.ShadowSoftness = 0
end, 48)

step("Tắt âm thanh...", function()
    SoundService.AmbientReverb = Enum.ReverbType.NoReverb
    SoundService.DistanceFactor = 0
    SoundService.DopplerScale = 0
    SoundService.RespectFilteringEnabled = false
    pcall(function() SoundService.VolumetricAudio = Enum.VolumetricAudio.Disabled end)
    for _, v in ipairs(game:GetDescendants()) do
        if v:IsA("Sound") then
            v.Volume = 0
            v.Playing = false
            v.Looped = false
        end
    end
end, 56)

local potatoMaterials = {
    [Enum.Material.Grass]=true,[Enum.Material.LeafyGrass]=true,[Enum.Material.Wood]=true,
    [Enum.Material.WoodPlanks]=true,[Enum.Material.Rock]=true,[Enum.Material.Slate]=true,
    [Enum.Material.Sand]=true,[Enum.Material.Mud]=true,[Enum.Material.Snow]=true,
    [Enum.Material.Ice]=true,[Enum.Material.Glacier]=true,[Enum.Material.CorrodedMetal]=true,
    [Enum.Material.DiamondPlate]=true,[Enum.Material.Foil]=true,[Enum.Material.Marble]=true,
    [Enum.Material.Granite]=true,[Enum.Material.Brick]=true,[Enum.Material.Cobblestone]=true,
    [Enum.Material.Concrete]=true,[Enum.Material.Fabric]=true,[Enum.Material.Pebble]=true,
    [Enum.Material.Limestone]=true,[Enum.Material.Pavement]=true,[Enum.Material.Asphalt]=true,
    [Enum.Material.Basalt]=true,[Enum.Material.CrackedLava]=true,[Enum.Material.Neon]=true,
    [Enum.Material.Glass]=true,[Enum.Material.ForceField]=true,[Enum.Material.Metal]=true,
    [Enum.Material.Cardboard]=true,[Enum.Material.Carpet]=true,[Enum.Material.CeramicTiles]=true,
    [Enum.Material.ClayRoofTiles]=true,[Enum.Material.RoofShingles]=true,[Enum.Material.Leather]=true,
    [Enum.Material.Plaster]=true,[Enum.Material.Rubber]=true,
}

local function isCharacterDescendant(v)
    local current = v
    while current do
        if current:IsA("Model") then
            local hum = current:FindFirstChildOfClass("Humanoid")
            if hum then return true end
        end
        if current:IsA("Accessory") then return true end
        if current:IsA("Tool") then return true end
        current = current.Parent
    end
    return false
end

local function isClothingOrName(v)
    if v:IsA("Decal") or v:IsA("Texture") then return true end
    if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") then return true end
    if v:IsA("BillboardGui") then return true end
    if v:IsA("TextLabel") or v:IsA("TextButton") then return true end
    if v:IsA("Accessory") then return true end
    if v:IsA("CharacterMesh") then return true end
    if v:IsA("BodyColors") then return true end
    if v:IsA("Humanoid") then return true end
    if v:IsA("SurfaceAppearance") then
        local parent = v.Parent
        if parent and isCharacterDescendant(parent) then return true end
    end
    if v:IsA("MeshPart") or v:IsA("SpecialMesh") or v:IsA("BasePart") then
        if isCharacterDescendant(v) then return true end
    end
    return false
end

local function optimizeObject(v)
    if isClothingOrName(v) then return end
    if isCharacterDescendant(v) then
        if v:IsA("BasePart") then
            pcall(function()
                v.Reflectance = 0
                v.Massless = true
            end)
        end
        return
    end

    if v:IsA("BasePart") then
        pcall(function()
            if potatoMaterials[v.Material] then v.Material = Enum.Material.SmoothPlastic end
            v.Reflectance = 0
            v.CastShadow = false
            v.Massless = true
            v.CanTouch = false
            v.CanQuery = false
        end)
    elseif v:IsA("Decal") or v:IsA("Texture") then
        pcall(function() v.Transparency = 1 end)
    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke")
        or v:IsA("Fire") or v:IsA("Sparkles") or v:IsA("Beam") then
        pcall(function() v.Enabled = false; v:Destroy() end)
    elseif v:IsA("SurfaceAppearance") then
        pcall(function() v:Destroy() end)
    elseif v:IsA("SpecialMesh") then
        pcall(function()
            if v.MeshType == Enum.MeshType.FileMesh or v.MeshType == Enum.MeshType.Head then
                v.MeshType = Enum.MeshType.Brick
                v.TextureId = ""
                v.Scale = Vector3.new(1,1,1)
                v.Offset = Vector3.new(0,0,0)
            end
        end)
    elseif v:IsA("MeshPart") then
        pcall(function()
            v.TextureID = ""
            v.RenderFidelity = Enum.RenderFidelity.Performance
            v.CollisionFidelity = Enum.CollisionFidelity.Box
            v.CastShadow = false
            v.Massless = true
            v.CanTouch = false
            v.CanQuery = false
            v.DoubleSided = false
        end)
    elseif v:IsA("Sound") then
        pcall(function() v.Volume = 0; v.Playing = false; v:Destroy() end)
    elseif v:IsA("Animation") then
        pcall(function() v:Destroy() end)
    elseif v:IsA("AnimationController") or v:IsA("Animator") then
        pcall(function()
            for _, t in ipairs(v:GetPlayingAnimationTracks()) do
                t:Stop(); t:Destroy()
            end
        end)
    elseif v:IsA("Highlight") or v:IsA("SelectionBox") or v:IsA("BoxHandleAdornment")
        or v:IsA("BillboardGui") or v:IsA("SurfaceGui") then
        pcall(function() v.Enabled = false end)
    elseif v:IsA("Attachment") then
        pcall(function()
            for _, c in ipairs(v:GetChildren()) do
                if c:IsA("ParticleEmitter") or c:IsA("Trail") or c:IsA("Beam") or c:IsA("Light") then
                    c:Destroy()
                end
            end
        end)
    elseif v:IsA("PointLight") or v:IsA("SpotLight") or v:IsA("SurfaceLight") then
        pcall(function() v:Destroy() end)
    elseif v:IsA("ForceField") or v:IsA("Explosion") then
        pcall(function() v:Destroy() end)
    end
end

local allDescendants = Workspace:GetDescendants()
local total = #allDescendants

for i, v in ipairs(allDescendants) do
    optimizeObject(v)
    if i % 100 == 0 then
        local p = 60 + math.floor((i / total) * 30)
        setProgress(p, "Đang quét... " .. i .. "/" .. total)
        task.wait()
    end
end

step("Tối ưu Player...", function()
    pcall(function()
        for _, plr in ipairs(game.Players:GetPlayers()) do
            local char = plr.Character
            if char then
                for _, v in ipairs(char:GetDescendants()) do
                    optimizeObject(v)
                end
            end
        end
    end)
end, 96)

setProgress(97, "Dọn bộ nhớ...")
pcall(function()
    collectgarbage("collect")
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 200)
end)

local scanConn
scanConn = Workspace.DescendantAdded:Connect(function(v)
    task.defer(function() optimizeObject(v) end)
end)

local charConn = game.Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function(char)
        task.defer(function()
            for _, v in ipairs(char:GetDescendants()) do
                optimizeObject(v)
            end
        end)
    end)
end)

task.spawn(function()
    while sg.Parent do
        task.wait(5)
        pcall(function() collectgarbage("collect") end)
    end
end)

task.spawn(function()
    while sg.Parent do
        task.wait(2)
        pcall(function()
            for _, v in ipairs(Workspace:GetDescendants()) do
                if (v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam")
                    or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles")
                    or v:IsA("PointLight") or v:IsA("SpotLight") or v:IsA("SurfaceLight")) then
                    if not isCharacterDescendant(v) then
                        v.Enabled = false
                    end
                end
            end
        end)
    end
end)

task.spawn(function()
    while sg.Parent do
        task.wait(1)
        pcall(function()
            if Camera then Camera.FieldOfView = 70 end
        end)
    end
end)

local frames = 0
task.spawn(function()
    RunService.RenderStepped:Connect(function()
        frames = frames + 1
    end)
    while sg.Parent do
        task.wait(0.5)
        local fps = math.floor(frames * 2 + 0.5)
        frames = 0
        local color
        if fps >= 50 then
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

setProgress(100, "✅ Hoàn tất")
task.wait(0.6)

TweenService:Create(mainStroke, TweenInfo.new(0.5), {Transparency = 0.35}):Play()
TweenService:Create(main, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 260, 0, 130)
}):Play()
TweenService:Create(titleLabel, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
TweenService:Create(subLabel, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
TweenService:Create(percentLabel, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
TweenService:Create(statusLabel, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
TweenService:Create(progressBg, TweenInfo.new(0.4), {BackgroundTransparency = 0}):Play()
TweenService:Create(closeBtn, TweenInfo.new(0.4), {BackgroundTransparency = 0, TextTransparency = 0}):Play()

task.wait(0.5)

titleLabel.Text = "⚡ fix lag by kudo29001"
statusLabel.Text = "Đã áp dụng"
percentLabel.Text = "100%"
progressFill.BackgroundColor3 = Color3.fromRGB(0, 255, 120)

task.wait(6)

done = true

pcall(function()
    TweenService:Create(main, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1
    }):Play()
    TweenService:Create(titleLabel, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
    TweenService:Create(subLabel, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
    TweenService:Create(percentLabel, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
    TweenService:Create(statusLabel, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
    TweenService:Create(progressBg, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
    TweenService:Create(progressFill, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
    TweenService:Create(closeBtn, TweenInfo.new(0.4), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
    TweenService:Create(mainStroke, TweenInfo.new(0.5), {Transparency = 1}):Play()
    task.wait(0.7)
    if scanConn then scanConn:Disconnect() end
    if charConn then charConn:Disconnect() end
    main:Destroy()
end)

closeBtn.MouseButton1Click:Connect(function()
    if done then return end
    done = true
    pcall(function()
        if scanConn then scanConn:Disconnect() end
        if charConn then charConn:Disconnect() end
        sg:Destroy()
    end)
end)

-- ===== KHỞI TẠO ANIMATION MỞ =====
TweenService:Create(main, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 300, 0, 190)
}):Play()
task.wait(0.15)
TweenService:Create(titleLabel, TweenInfo.new(0.35), {TextTransparency = 0}):Play()
TweenService:Create(subLabel, TweenInfo.new(0.35), {TextTransparency = 0}):Play()
task.wait(0.1)
TweenService:Create(percentLabel, TweenInfo.new(0.35), {TextTransparency = 0}):Play()
TweenService:Create(statusLabel, TweenInfo.new(0.35), {TextTransparency = 0}):Play()
task.wait(0.1)
TweenService:Create(progressBg, TweenInfo.new(0.35), {BackgroundTransparency = 0}):Play()
TweenService:Create(closeBtn, TweenInfo.new(0.35), {BackgroundTransparency = 0, TextTransparency = 0}):Play()

print("✅ fix lag by kudo29001")