local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Terrain = Workspace:FindFirstChildOfClass("Terrain")
local Camera = Workspace.CurrentCamera
local Stats = game:GetService("Stats")

local uiParent
pcall(function()
    if gethui then uiParent = gethui() end
end)
if not uiParent then uiParent = playerGui end

pcall(function()
    for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do
        if v.Name == "KudoPopup" or v.Name == "KudoStats" or v.Name == "KudoToggle" then v:Destroy() end
    end
end)
pcall(function()
    for _, v in pairs(playerGui:GetChildren()) do
        if v.Name == "KudoPopup" or v.Name == "KudoStats" or v.Name == "KudoToggle" then v:Destroy() end
    end
end)

-- ==================== POPUP ====================
local popupGui = Instance.new("ScreenGui")
popupGui.Name = "KudoPopup"
popupGui.ResetOnSpawn = false
popupGui.IgnoreGuiInset = true
popupGui.DisplayOrder = 2147483647
popupGui.Parent = uiParent

local popup = Instance.new("Frame")
popup.Size = UDim2.new(0, 340, 0, 96)
popup.Position = UDim2.new(1, 360, 0.42, -48)
popup.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
popup.BorderSizePixel = 0
popup.Parent = popupGui
Instance.new("UICorner", popup).CornerRadius = UDim.new(0, 18)

local border = Instance.new("UIStroke")
border.Color = Color3.fromRGB(255, 60, 60)
border.Thickness = 2
border.Transparency = 0
border.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
border.Parent = popup

task.spawn(function()
    local hue = 0
    while border.Parent do
        hue = (hue + 0.008) % 1
        border.Color = Color3.fromHSV(hue, 0.9, 1)
        task.wait(0.03)
    end
end)

local bgGradient = Instance.new("UIGradient")
bgGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 12, 20)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(14, 14, 22)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 12))
})
bgGradient.Rotation = 135
bgGradient.Parent = popup

local accentBar = Instance.new("Frame")
accentBar.Size = UDim2.new(0, 5, 1, -30)
accentBar.Position = UDim2.new(0, 0, 0, 15)
accentBar.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
accentBar.BorderSizePixel = 0
accentBar.Parent = popup
Instance.new("UICorner", accentBar).CornerRadius = UDim.new(0, 3)

local accentGradient = Instance.new("UIGradient")
accentGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 60, 60)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 170, 100)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 60, 60))
})
accentGradient.Rotation = 90
accentGradient.Parent = accentBar

local iconWrap = Instance.new("Frame")
iconWrap.Size = UDim2.new(0, 56, 0, 56)
iconWrap.Position = UDim2.new(0, 24, 0.5, -28)
iconWrap.BackgroundColor3 = Color3.fromRGB(32, 14, 20)
iconWrap.BorderSizePixel = 0
iconWrap.Parent = popup
Instance.new("UICorner", iconWrap).CornerRadius = UDim.new(1, 0)

local iconGradient = Instance.new("UIGradient")
iconGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 20, 32)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(28, 14, 20))
})
iconGradient.Rotation = 45
iconGradient.Parent = iconWrap

local iconStroke = Instance.new("UIStroke")
iconStroke.Color = Color3.fromRGB(255, 80, 80)
iconStroke.Thickness = 1.5
iconStroke.Transparency = 0.2
iconStroke.Parent = iconWrap

local glow = Instance.new("ImageLabel")
glow.Size = UDim2.new(1, 40, 1, 40)
glow.Position = UDim2.new(0, -20, 0, -20)
glow.BackgroundTransparency = 1
glow.Image = "rbxassetid://5028857472"
glow.ImageColor3 = Color3.fromRGB(255, 80, 80)
glow.ImageTransparency = 0.75
glow.ZIndex = 0
glow.Parent = iconWrap

task.spawn(function()
    while glow.Parent do
        TweenService:Create(glow, TweenInfo.new(1.5), {ImageTransparency = 0.6}):Play()
        task.wait(1.5)
        TweenService:Create(glow, TweenInfo.new(1.5), {ImageTransparency = 0.85}):Play()
        task.wait(1.5)
    end
end)

local icon = Instance.new("TextLabel")
icon.Size = UDim2.new(1, 0, 1, 0)
icon.BackgroundTransparency = 1
icon.Text = "⚙"
icon.Font = Enum.Font.GothamBold
icon.TextSize = 30
icon.TextColor3 = Color3.fromRGB(255, 110, 110)
icon.ZIndex = 2
icon.Parent = iconWrap

task.spawn(function()
    local r = 0
    while icon.Parent do
        r = (r + 7) % 360
        icon.Rotation = r
        task.wait(0.03)
    end
end)

task.spawn(function()
    while iconWrap.Parent do
        local ring = Instance.new("Frame")
        ring.Size = UDim2.new(0, 56, 0, 56)
        ring.Position = UDim2.new(0, 0, 0, 0)
        ring.BackgroundTransparency = 1
        ring.ZIndex = 1
        ring.Parent = iconWrap
        Instance.new("UICorner", ring).CornerRadius = UDim.new(1, 0)
        
        local ringStroke = Instance.new("UIStroke")
        ringStroke.Color = Color3.fromRGB(255, 80, 80)
        ringStroke.Thickness = 2
        ringStroke.Transparency = 0.2
        ringStroke.Parent = ring
        
        TweenService:Create(ring, TweenInfo.new(1.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 100, 0, 100),
            Position = UDim2.new(0, -22, 0, -22)
        }):Play()
        TweenService:Create(ringStroke, TweenInfo.new(1.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Transparency = 1,
            Thickness = 0.5
        }):Play()
        
        task.delay(1.6, function()
            pcall(function() ring:Destroy() end)
        end)
        
        task.wait(0.8)
    end
end)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -110, 0, 28)
title.Position = UDim2.new(0, 96, 0, 22)
title.BackgroundTransparency = 1
title.Text = "fix lag v1.0"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255, 100, 100)
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 2
title.Parent = popup

local check = Instance.new("TextLabel")
check.Size = UDim2.new(0, 30, 0, 28)
check.Position = UDim2.new(1, -40, 0, 22)
check.BackgroundTransparency = 1
check.Text = "✓"
check.Font = Enum.Font.GothamBold
check.TextSize = 20
check.TextColor3 = Color3.fromRGB(80, 255, 130)
check.ZIndex = 2
check.Parent = popup

local sub = Instance.new("TextLabel")
sub.Size = UDim2.new(1, -110, 0, 20)
sub.Position = UDim2.new(0, 96, 0, 52)
sub.BackgroundTransparency = 1
sub.Text = "by kudo29001 ⚡"
sub.Font = Enum.Font.Gotham
sub.TextSize = 12
sub.TextColor3 = Color3.fromRGB(150, 150, 165)
sub.TextXAlignment = Enum.TextXAlignment.Left
sub.ZIndex = 2
sub.Parent = popup

local progressBar = Instance.new("Frame")
progressBar.Size = UDim2.new(0, 0, 0, 3)
progressBar.Position = UDim2.new(0, 24, 1, -3)
progressBar.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
progressBar.BorderSizePixel = 0
progressBar.ZIndex = 3
progressBar.Parent = popup
Instance.new("UICorner", progressBar).CornerRadius = UDim.new(1, 0)

local progressGradient = Instance.new("UIGradient")
progressGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 60, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 170, 80))
})
progressGradient.Parent = progressBar

popup.BackgroundTransparency = 1
iconWrap.BackgroundTransparency = 1
icon.TextTransparency = 1
title.TextTransparency = 1
check.TextTransparency = 1
sub.TextTransparency = 1
border.Transparency = 1
accentBar.BackgroundTransparency = 1
progressBar.BackgroundTransparency = 1

TweenService:Create(popup, TweenInfo.new(0.65, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Position = UDim2.new(1, -360, 0.42, -48),
    BackgroundTransparency = 0
}):Play()
TweenService:Create(border, TweenInfo.new(0.4), {Transparency = 0}):Play()
TweenService:Create(iconWrap, TweenInfo.new(0.4), {BackgroundTransparency = 0}):Play()
TweenService:Create(accentBar, TweenInfo.new(0.4), {BackgroundTransparency = 0}):Play()

task.wait(0.25)
TweenService:Create(icon, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
TweenService:Create(title, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
task.wait(0.1)
TweenService:Create(check, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
TweenService:Create(sub, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
task.wait(0.1)
TweenService:Create(progressBar, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
TweenService:Create(progressBar, TweenInfo.new(3, Enum.EasingStyle.Linear), {
    Size = UDim2.new(1, -48, 0, 3)
}):Play()

task.delay(3.5, function()
    pcall(function()
        TweenService:Create(sub, TweenInfo.new(0.2), {TextTransparency = 1}):Play()
        TweenService:Create(check, TweenInfo.new(0.2), {TextTransparency = 1}):Play()
        TweenService:Create(progressBar, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        task.wait(0.1)
        TweenService:Create(title, TweenInfo.new(0.2), {TextTransparency = 1}):Play()
        TweenService:Create(icon, TweenInfo.new(0.2), {TextTransparency = 1}):Play()
        task.wait(0.1)
        TweenService:Create(iconWrap, TweenInfo.new(0.25), {BackgroundTransparency = 1}):Play()
        TweenService:Create(accentBar, TweenInfo.new(0.25), {BackgroundTransparency = 1}):Play()
        TweenService:Create(border, TweenInfo.new(0.25), {Transparency = 1}):Play()
        task.wait(0.1)
        TweenService:Create(popup, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(1, 360, 0.42, -48),
            BackgroundTransparency = 1
        }):Play()
        task.wait(0.5)
        popupGui:Destroy()
    end)
end)

-- ==================== FFLAG ====================
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
    setfflag("FFlagDisableTextures", "True")
    setfflag("DFFlagRenderSkipMaterialTextures", "True")
    setfflag("FFlagDisableSurfaceAppearance", "True")
    setfflag("FFlagDisableMaterialTextures", "True")
    setfflag("DFFlagForceTextureLOD", "True")
    setfflag("DFFlagTextureCompositorEnable", "False")
    setfflag("DFFlagTextureCompositorEnabled", "False")
    setfflag("FFlagDisableNormalMap", "True")
    setfflag("FFlagDisableRoughnessMap", "True")
    setfflag("FFlagDisableMetalnessMap", "True")
    setfflag("FFlagDisableEmissiveMap", "True")
    setfflag("FFlagDisableReflectionMap", "True")
    setfflag("DFFlagDisableTextureAnisotropy", "True")
    setfflag("DFIntTextureAnisotropy", "1")

    setfflag("DFFlagDisableSSAO", "True")
    setfflag("FFlagDisableSSAO", "True")
    setfflag("FFlagDisablePostFx", "True")
    setfflag("FFlagDisableBloom", "True")
    setfflag("FFlagDisableDepthOfField", "True")
    setfflag("FFlagDisableSunRays", "True")
    setfflag("FFlagDisableColorCorrection", "True")
    setfflag("FFlagDisableAntiAliasing", "True")
    setfflag("FFlagDisableMotionBlur", "True")
    setfflag("FFlagDisableAtmosphericScattering", "True")

    setfflag("FFlagRenderShadowIntensity", "0")
    setfflag("FFlagRenderShadowIntensityOverride", "True")
    setfflag("DFFlagDisableRenderShadowMap", "True")
    setfflag("FFlagDisableShadows", "True")
    setfflag("FFlagDisableDynamicLighting", "True")
    setfflag("FFlagDisablePointLightShadows", "True")
    setfflag("FFlagDisableSpotLightShadows", "True")
    setfflag("FFlagDisableSurfaceLightShadows", "True")

    setfflag("FFlagDebugSkyGray", "True")
    setfflag("FFlagDisableAtmosphere", "True")
    setfflag("FFlagDisableSky", "True")
    setfflag("FFlagDisableFog", "True")
    setfflag("FFlagDisableTerrainDecoration", "True")
    setfflag("FIntFRMMaxGrassDistance", "0")
    setfflag("FIntFRMMinGrassDistance", "0")
    setfflag("FIntGrassMovementReducedMotionFactor", "0")

    setfflag("DFIntCSGLevelOfDetailSwitchingDistance", "0")
    setfflag("DFIntCSGLevelOfDetailSwitchingDistanceL12", "0")
    setfflag("DFIntCSGLevelOfDetailSwitchingDistanceL23", "0")
    setfflag("DFIntCSGLevelOfDetailSwitchingDistanceL34", "0")
    setfflag("FFlagDisableLODTransitions", "True")
    setfflag("FFlagForceLOD0", "True")
    setfflag("DFIntLODBias", "8")
    setfflag("DFFlagForceLODLevel", "0")
    setfflag("DFIntRenderFidelity", "0")

    setfflag("DFFlagDebugRenderForceTechnologyVoxel", "True")
    setfflag("FFlagDebugPauseVoxelizer", "True")
    setfflag("DFFlagSkipHighResolutionEnvironment", "True")
    setfflag("FFlagRenderDisableForwardLights", "True")

    setfflag("DFIntSolverSpringDamping", "0")
    setfflag("DFIntPhysicsSendRate", "1")
    setfflag("DFIntMaxSimultaneousPhysicsJobs", "1")
    setfflag("DFIntPhysicsStepPerFrame", "1")
    setfflag("DFIntMaximumCollisionIterations", "1")
    setfflag("DFIntSolverConvergenceIterations", "1")
    setfflag("FFlagDisableRaycastFiltering", "True")
    setfflag("DFFlagSkipRaycastFiltering", "True")

    setfflag("DFIntFrameBufferPoolSize", "1")
    setfflag("DFIntRenderMeshMaxBones", "1")
    setfflag("DFIntDebugEngineOptimizationLevel", "3")
    setfflag("DFFlagDisableRenderMeshes", "True")
    setfflag("FFlagDisableRenderMeshes", "True")
    setfflag("FFlagRenderDisableWireframe", "True")
    setfflag("FFlagDisableParticleMesh", "True")
    setfflag("FFlagDisableParticleEffects", "True")
    setfflag("FFlagDisableTrails", "True")
    setfflag("FFlagDisableBeams", "True")
    setfflag("FFlagDisableBillboards", "True")
    setfflag("FFlagDisableDecals", "True")
    setfflag("FFlagDisableReflections", "True")
    setfflag("FFlagDisableGlassRefraction", "True")
    setfflag("DFFlagSkipRenderMesh", "True")
    setfflag("FFlagDisableMultiSample", "True")
    setfflag("FFlagDisableHDR", "True")
    setfflag("FFlagDisableToneMapping", "True")

    setfflag("FFlagDisableAnimationBlending", "True")
    setfflag("DFFlagSkipAnimationBlending", "True")
    setfflag("FFlagDisableFacialAnimation", "True")

    setfflag("DFFlagGCEnableIncremental", "True")
    setfflag("DFIntGCIncrementalPause", "2")
    setfflag("DFIntGCIncrementalStepMul", "3000")
    setfflag("DFIntGCIncrementalStepSizeKb", "64")

    setfflag("DFIntConnectionMTUSize", "1400")
    setfflag("DFIntS2PhysicsSenderRate", "1")

    setfflag("FFlagDebugGraphicsDisableDirect3D11", "True")
    setfflag("FFlagDebugGraphicsPreferOpenGL", "True")

    setfflag("DFIntNumberOfRenderPasses", "1")
    setfflag("DFIntMaxConcurrentRenderPasses", "1")
    setfflag("DFIntRenderPassSortMode", "0")

    setfflag("DFIntAssetRequestBatchSize", "1")
    setfflag("DFIntMaxAssetDownloadConcurrency", "1")
    setfflag("DFFlagThrottleAssetDownloads", "True")
    setfflag("DFIntAssetDownloadThrottleMs", "50")

    setfflag("DFIntMaxPartCacheSize", "1")
    setfflag("DFIntPartCacheLimit", "1")

    setfflag("DFIntTerrainLODBias", "8")
    setfflag("FFlagDisableTerrainLODTransitions", "True")
end)

-- ==================== ENGINE CONFIG ====================
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
        Workspace.StreamingEnabled = true
        Workspace.StreamingTargetRadius = 96
        Workspace.StreamingMinRadius = 48
        Workspace.StreamOutBehavior = Enum.StreamOutBehavior.Opportunistic
    end)
end)

pcall(function()
    for _, v in ipairs(Lighting:GetChildren()) do
        if v:IsA("PostEffect") or v:IsA("Sky") or v:IsA("Atmosphere") 
            or v:IsA("Clouds") or v:IsA("Skybox") then
            v:Destroy()
        end
    end
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 1e9
    Lighting.FogStart = 1e9
    Lighting.FogColor = Color3.fromRGB(180, 180, 180)
    Lighting.Brightness = 2
    Lighting.EnvironmentDiffuseScale = 0
    Lighting.EnvironmentSpecularScale = 0
    Lighting.OutdoorAmbient = Color3.fromRGB(180, 180, 180)
    Lighting.Ambient = Color3.fromRGB(180, 180, 180)
    Lighting.ClockTime = 14
    Lighting.ExposureCompensation = 0
    Lighting.ShadowSoftness = 0
end)

Lighting.DescendantAdded:Connect(function(v)
    task.defer(function()
        pcall(function()
            if v:IsA("Sky") or v:IsA("Atmosphere") or v:IsA("Clouds") 
                or v:IsA("Skybox") or v:IsA("BloomEffect") or v:IsA("BlurEffect")
                or v:IsA("SunRaysEffect") or v:IsA("DepthOfFieldEffect")
                or v:IsA("ColorCorrectionEffect") then
                v:Destroy()
            end
        end)
    end)
end)

pcall(function()
    if Terrain then
        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveSpeed = 0
        Terrain.WaterReflectance = 0
        Terrain.WaterTransparency = 0
        Terrain.WaterColor = Color3.fromRGB(70, 140, 230)
        Terrain.Decoration = false
    end
end)

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

local function potatoPart(part)
    pcall(function()
        if part.Material ~= Enum.Material.SmoothPlastic 
            and part.Material ~= Enum.Material.Plastic then
            part.Material = Enum.Material.SmoothPlastic
        end
        part.Reflectance = 0
        part.CastShadow = false
    end)
end

local killTypes = {
    ParticleEmitter = true, Trail = true, Smoke = true, Fire = true,
    Sparkles = true, Beam = true, Highlight = true, SelectionBox = true,
    BoxHandleAdornment = true, PointLight = true, SpotLight = true,
    SurfaceLight = true, ForceField = true, Explosion = true,
    Animation = true, SurfaceAppearance = true,
    Decal = true, Texture = true, SpecialMesh = true,
}

local function handleObject(v)
    if isName(v) then return end
    if isChar(v) then return end
    
    local cn = v.ClassName
    if killTypes[cn] then
        pcall(function() v:Destroy() end)
    elseif cn == "Part" or cn == "MeshPart" or cn == "UnionOperation" or cn == "WedgePart"
        or cn == "TrussPart" or cn == "CornerWedgePart" or cn == "SpawnLocation" then
        potatoPart(v)
    end
end

local descendants = Workspace:GetDescendants()
for i = 1, #descendants do
    handleObject(descendants[i])
    if i % 800 == 0 then task.wait() end
end

Workspace.DescendantAdded:Connect(function(v)
    task.defer(function()
        pcall(function() handleObject(v) end)
    end)
end)

local CULL_DIST_SQ = 80 * 80
local culled = {}
local cullIndex = 1
local cullList = {}

task.spawn(function()
    while uiParent.Parent do
        task.wait(5)
        local list = {}
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") and not isChar(v) then
                list[#list + 1] = v
            end
        end
        cullList = list
        cullIndex = 1
    end
end)

task.spawn(function()
    while uiParent.Parent do
        task.wait(0.1)
        pcall(function()
            if not Camera then return end
            local camPos = Camera.CFrame.Position
            local list = cullList
            local n = #list
            if n == 0 then return end
            
            local startIdx = cullIndex
            local chunk = math.ceil(n / 5)
            local endIdx = math.min(startIdx + chunk, n)
            
            for i = startIdx, endIdx do
                local v = list[i]
                if v and v.Parent then
                    local pos = v.Position
                    if pos.Y < camPos.Y - 3 then
                        if culled[v] then
                            culled[v] = false
                            pcall(function() v.LocalTransparencyModifier = 0 end)
                        end
                    else
                        local dx = pos.X - camPos.X
                        local dy = pos.Y - camPos.Y
                        local dz = pos.Z - camPos.Z
                        local distSq = dx*dx + dy*dy + dz*dz
                        local shouldHide = distSq > CULL_DIST_SQ

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
            
            cullIndex = endIdx + 1
            if cullIndex > n then cullIndex = 1 end
        end)
    end
end)

task.spawn(function()
    while uiParent.Parent do
        task.wait(30)
        pcall(function()
            if RunService:IsRunning() then
                collectgarbage("collect")
            end
        end)
    end
end)

-- ==================== UI FPS + PING + TIME + CREDIT ====================
local statsGui = Instance.new("ScreenGui")
statsGui.Name = "KudoStats"
statsGui.ResetOnSpawn = false
statsGui.IgnoreGuiInset = true
statsGui.DisplayOrder = 2147483647
statsGui.Parent = uiParent

local box = Instance.new("Frame")
box.Size = UDim2.new(0, 150, 0, 92)
box.Position = UDim2.new(1, -160, 1, -102)
box.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
box.BackgroundTransparency = 0.35
box.BorderSizePixel = 0
box.Active = true
box.Parent = statsGui
Instance.new("UICorner", box).CornerRadius = UDim.new(0, 10)

local boxStroke = Instance.new("UIStroke")
boxStroke.Color = Color3.fromRGB(255, 60, 60)
boxStroke.Thickness = 1
boxStroke.Transparency = 0.6
boxStroke.Parent = box

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 16)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
header.BackgroundTransparency = 0.7
header.BorderSizePixel = 0
header.Parent = box
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 10)

local dragHint = Instance.new("Frame")
dragHint.Size = UDim2.new(0, 24, 0, 2)
dragHint.Position = UDim2.new(0.5, -12, 0.5, -1)
dragHint.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
dragHint.BackgroundTransparency = 0.2
dragHint.BorderSizePixel = 0
dragHint.Parent = header
Instance.new("UICorner", dragHint).CornerRadius = UDim.new(1, 0)

local fpsTitle = Instance.new("TextLabel")
fpsTitle.Size = UDim2.new(0, 40, 0, 16)
fpsTitle.Position = UDim2.new(0, 10, 0, 20)
fpsTitle.BackgroundTransparency = 1
fpsTitle.Text = "FPS"
fpsTitle.Font = Enum.Font.GothamBold
fpsTitle.TextSize = 10
fpsTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
fpsTitle.TextXAlignment = Enum.TextXAlignment.Left
fpsTitle.Parent = box

local fpsValue = Instance.new("TextLabel")
fpsValue.Size = UDim2.new(0, 70, 0, 16)
fpsValue.Position = UDim2.new(1, -80, 0, 20)
fpsValue.BackgroundTransparency = 1
fpsValue.Text = "--"
fpsValue.Font = Enum.Font.GothamBold
fpsValue.TextSize = 12
fpsValue.TextColor3 = Color3.fromRGB(0, 255, 120)
fpsValue.TextXAlignment = Enum.TextXAlignment.Right
fpsValue.Parent = box

local pingTitle = Instance.new("TextLabel")
pingTitle.Size = UDim2.new(0, 40, 0, 16)
pingTitle.Position = UDim2.new(0, 10, 0, 38)
pingTitle.BackgroundTransparency = 1
pingTitle.Text = "PING"
pingTitle.Font = Enum.Font.GothamBold
pingTitle.TextSize = 10
pingTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
pingTitle.TextXAlignment = Enum.TextXAlignment.Left
pingTitle.Parent = box

local pingValue = Instance.new("TextLabel")
pingValue.Size = UDim2.new(0, 70, 0, 16)
pingValue.Position = UDim2.new(1, -80, 0, 38)
pingValue.BackgroundTransparency = 1
pingValue.Text = "--"
pingValue.Font = Enum.Font.GothamBold
pingValue.TextSize = 12
pingValue.TextColor3 = Color3.fromRGB(0, 255, 120)
pingValue.TextXAlignment = Enum.TextXAlignment.Right
pingValue.Parent = box

local timeTitle = Instance.new("TextLabel")
timeTitle.Size = UDim2.new(0, 40, 0, 16)
timeTitle.Position = UDim2.new(0, 10, 0, 56)
timeTitle.BackgroundTransparency = 1
timeTitle.Text = "TIME"
timeTitle.Font = Enum.Font.GothamBold
timeTitle.TextSize = 10
timeTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
timeTitle.TextXAlignment = Enum.TextXAlignment.Left
timeTitle.Parent = box

local timeValue = Instance.new("TextLabel")
timeValue.Size = UDim2.new(0, 70, 0, 16)
timeValue.Position = UDim2.new(1, -80, 0, 56)
timeValue.BackgroundTransparency = 1
timeValue.Text = "00:00"
timeValue.Font = Enum.Font.GothamBold
timeValue.TextSize = 12
timeValue.TextColor3 = Color3.fromRGB(255, 100, 100)
timeValue.TextXAlignment = Enum.TextXAlignment.Right
timeValue.Parent = box

local creditLabel = Instance.new("TextLabel")
creditLabel.Size = UDim2.new(1, -10, 0, 12)
creditLabel.Position = UDim2.new(0, 5, 1, -14)
creditLabel.BackgroundTransparency = 1
creditLabel.Text = "@script by kudo29001"
creditLabel.Font = Enum.Font.GothamBold
creditLabel.TextSize = 10
creditLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
creditLabel.TextTransparency = 0.3
creditLabel.TextXAlignment = Enum.TextXAlignment.Center
creditLabel.Parent = box

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 22, 0, 22)
closeBtn.Position = UDim2.new(1, -26, 0, -3)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.Text = "x"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 13
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.BorderSizePixel = 0
closeBtn.ZIndex = 10
closeBtn.Parent = box
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)

local hideBtn = Instance.new("TextButton")
hideBtn.Size = UDim2.new(0, 22, 0, 22)
hideBtn.Position = UDim2.new(1, -52, 0, -3)
hideBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 50)
hideBtn.Text = "-"
hideBtn.Font = Enum.Font.GothamBold
hideBtn.TextSize = 15
hideBtn.TextColor3 = Color3.new(1, 1, 1)
hideBtn.BorderSizePixel = 0
hideBtn.ZIndex = 10
hideBtn.Parent = box
Instance.new("UICorner", hideBtn).CornerRadius = UDim.new(1, 0)

-- ===== HÌNH CHỮ V Ở GÓC DƯỚI TRÁI, XOAY KHỚP GÓC =====
local resizeBtn = Instance.new("TextButton")
resizeBtn.Size = UDim2.new(0, 22, 0, 22)
resizeBtn.Position = UDim2.new(0, -2, 1, -2)  -- Góc dưới TRÁI
resizeBtn.BackgroundTransparency = 1
resizeBtn.Text = ""
resizeBtn.BorderSizePixel = 0
resizeBtn.ZIndex = 9
resizeBtn.Parent = box

-- Đường chéo trái của chữ V (xoay -45°)
local vLeft = Instance.new("Frame")
vLeft.Size = UDim2.new(0, 2, 0, 12)
vLeft.Position = UDim2.new(0, 6, 0, 10)
vLeft.AnchorPoint = Vector2.new(0.5, 0.5)
vLeft.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
vLeft.BackgroundTransparency = 0.3
vLeft.BorderSizePixel = 0
vLeft.Rotation = -45
vLeft.ZIndex = 10
vLeft.Parent = resizeBtn
Instance.new("UICorner", vLeft).CornerRadius = UDim.new(1, 0)

-- Đường chéo phải của chữ V (xoay 45°)
local vRight = Instance.new("Frame")
vRight.Size = UDim2.new(0, 2, 0, 12)
vRight.Position = UDim2.new(0, 14, 0, 10)
vRight.AnchorPoint = Vector2.new(0.5, 0.5)
vRight.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
vRight.BackgroundTransparency = 0.3
vRight.BorderSizePixel = 0
vRight.Rotation = 45
vRight.ZIndex = 10
vRight.Parent = resizeBtn
Instance.new("UICorner", vRight).CornerRadius = UDim.new(1, 0)

local showGui = Instance.new("ScreenGui")
showGui.Name = "KudoToggle"
showGui.ResetOnSpawn = false
showGui.IgnoreGuiInset = true
showGui.DisplayOrder = 2147483647
showGui.Parent = uiParent

local showBtn = Instance.new("TextButton")
showBtn.Size = UDim2.new(0, 44, 0, 44)
showBtn.Position = UDim2.new(1, -54, 1, -54)
showBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
showBtn.Text = "⚡"
showBtn.Font = Enum.Font.GothamBold
showBtn.TextSize = 22
showBtn.TextColor3 = Color3.new(1, 1, 1)
showBtn.BorderSizePixel = 0
showBtn.Visible = false
showBtn.Parent = showGui
Instance.new("UICorner", showBtn).CornerRadius = UDim.new(1, 0)

local showStroke = Instance.new("UIStroke")
showStroke.Color = Color3.fromRGB(255, 100, 100)
showStroke.Thickness = 1.5
showStroke.Transparency = 0.3
showStroke.Parent = showBtn

hideBtn.MouseButton1Click:Connect(function()
    pcall(function()
        box.Visible = false
        showBtn.Visible = true
    end)
end)

showBtn.MouseButton1Click:Connect(function()
    pcall(function()
        box.Visible = true
        showBtn.Visible = false
    end)
end)

closeBtn.MouseButton1Click:Connect(function()
    pcall(function()
        statsGui:Destroy()
        showGui:Destroy()
    end)
end)

local dragging = false
local dragStart, startPos

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch 
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = box.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch 
        or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragStart
        box.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch 
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- ===== RESIZE + SCALE CHỮ V THEO =====
local resizing = false
local resizeStart, resizeStartSize

resizeBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch 
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
        resizing = true
        resizeStart = input.Position
        resizeStartSize = box.Size
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if resizing and (input.UserInputType == Enum.UserInputType.Touch 
        or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - resizeStart
        local newX = math.max(130, resizeStartSize.X.Offset + delta.X)
        local newY = math.max(90, resizeStartSize.Y.Offset + delta.Y)
        box.Size = UDim2.new(0, newX, 0, newY)

        -- Scale chữ V theo kích thước box
        local vScale = math.clamp(newX / 150, 1, 2.2)
        local vLength = math.floor(12 * vScale)
        vLeft.Size = UDim2.new(0, 2, 0, vLength)
        vRight.Size = UDim2.new(0, 2, 0, vLength)
        vLeft.Position = UDim2.new(0, 6, 0, 10)
        vRight.Position = UDim2.new(0, 6 + math.floor(8 * vScale), 0, 10)
        resizeBtn.Size = UDim2.new(0, math.floor(22 * vScale), 0, math.floor(22 * vScale))
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch 
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
        resizing = false
    end
end)

local startTime = tick()

task.spawn(function()
    while statsGui.Parent do
        task.wait(1)
        local elapsed = math.floor(tick() - startTime)
        local mins = math.floor(elapsed / 60)
        local secs = elapsed % 60
        timeValue.Text = string.format("%02d:%02d", mins, secs)
    end
end)

local frames = 0
local lastTime = tick()

task.spawn(function()
    RunService.RenderStepped:Connect(function()
        frames = frames + 1
    end)
    while statsGui.Parent do
        task.wait(0.5)
        local now = tick()
        local dt = now - lastTime
        lastTime = now
        local currentFPS = math.floor(frames / dt + 0.5)
        frames = 0

        fpsValue.Text = tostring(currentFPS)
        if currentFPS < 40 then
            fpsValue.TextColor3 = Color3.fromRGB(255, 60, 60)
        else
            fpsValue.TextColor3 = Color3.fromRGB(0, 255, 120)
        end

        local ping = 0
        pcall(function()
            ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        end)
        pingValue.Text = ping .. "ms"
        if ping <= 100 then
            pingValue.TextColor3 = Color3.fromRGB(0, 255, 120)
        else
            pingValue.TextColor3 = Color3.fromRGB(255, 60, 60)
        end
    end
end)

print("✅ fix lag v1.0 by kudo29001")