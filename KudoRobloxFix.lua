-- FPS counter
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local fpsGui = Instance.new("ScreenGui")
fpsGui.Name = "KudoFPS"
fpsGui.ResetOnSpawn = false
fpsGui.Parent = playerGui

local fpsLabel = Instance.new("TextLabel")
fpsLabel.Size = UDim2.new(0, 120, 0, 24)
fpsLabel.Position = UDim2.new(1, -130, 1, -30)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Text = "FPS: --"
fpsLabel.Font = Enum.Font.Times
fpsLabel.TextSize = 16
fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 120)
fpsLabel.TextXAlignment = Enum.TextXAlignment.Right
fpsLabel.Parent = fpsGui

local frames = 0
game:GetService("RunService").RenderStepped:Connect(function()
    frames = frames + 1
end)

task.spawn(function()
    while fpsGui.Parent do
        task.wait(0.5)
        local fps = math.floor(frames * 2 + 0.5)
        frames = 0
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

-- Fix lag
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local Terrain = Workspace:FindFirstChildOfClass("Terrain")
local Camera = Workspace.CurrentCamera

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
    Lighting.ClockTime = 14
end)

pcall(function()
    if Terrain then
        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveSpeed = 0
        Terrain.WaterReflectance = 0
        Terrain.WaterTransparency = 1
        Terrain.Decoration = false
    end
end)

pcall(function()
    if Camera then
        Camera.FieldOfView = 70
    end
end)

pcall(function()
    local SoundService = game:GetService("SoundService")
    SoundService.AmbientReverb = Enum.ReverbType.NoReverb
    SoundService.DistanceFactor = 0
    SoundService.DopplerScale = 0
end)

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

-- Quét vật thể
task.spawn(function()
    local protectedTypes = {
        BillboardGui = true,
        TextLabel = true,
        TextButton = true,
        Humanoid = true,
        Accessory = true,
        Sound = true,
        Animator = true,
        Animation = true,
    }

    local function optimize(v)
        local cn = v.ClassName
        if protectedTypes[cn] then return end

        pcall(function()
            if v:IsA("BasePart") then
                v.Reflectance = 0
                v.CastShadow = false
            elseif cn == "Decal" or cn == "Texture" then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke")
                or v:IsA("Fire") or v:IsA("Sparkles") or v:IsA("Beam") then
                v.Enabled = false
            elseif cn == "SurfaceAppearance" then
                v:Destroy()
            elseif cn == "SpecialMesh" then
                if v.MeshType == Enum.MeshType.FileMesh or v.MeshType == Enum.MeshType.Head then
                    v.TextureId = ""
                end
            elseif cn == "MeshPart" then
                v.TextureID = ""
                v.RenderFidelity = Enum.RenderFidelity.Performance
                v.CastShadow = false
            elseif v:IsA("Highlight") or v:IsA("SelectionBox") then
                v.Enabled = false
            elseif v:IsA("PointLight") or v:IsA("SpotLight") or v:IsA("SurfaceLight") then
                v:Destroy()
            end
        end)
    end

    for _, v in ipairs(Workspace:GetDescendants()) do
        optimize(v)
    end

    Workspace.DescendantAdded:Connect(function(v)
        task.defer(function() optimize(v) end)
    end)
end)

-- GC ngầm
task.spawn(function()
    while fpsGui.Parent do
        task.wait(20)
        pcall(function() collectgarbage("collect") end)
    end
end)

print("✅ Kudo Fix Lag loaded")