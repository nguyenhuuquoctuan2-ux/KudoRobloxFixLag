local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Terrain = Workspace:FindFirstChildOfClass("Terrain")
local Camera = Workspace.CurrentCamera
local Stats = game:GetService("Stats")

local uiParent
pcall(function()
    if gethui then uiParent = gethui() end
end)
if not uiParent then uiParent = playerGui end

-- ==================== POPUP HIỆN ĐẠI ====================
local popupGui = Instance.new("ScreenGui")
popupGui.Name = "KudoPopup"
popupGui.ResetOnSpawn = false
popupGui.IgnoreGuiInset = true
popupGui.DisplayOrder = 2147483647
popupGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
popupGui.Parent = uiParent

local popup = Instance.new("Frame")
popup.Size = UDim2.new(0, 300, 0, 80)
popup.Position = UDim2.new(1, 30, 0.4, -40)
popup.BackgroundColor3 = Color3.fromRGB(11, 11, 15)
popup.BackgroundTransparency = 0
popup.BorderSizePixel = 0
popup.ZIndex = 1000
popup.ClipsDescendants = false
popup.Parent = popupGui
Instance.new("UICorner", popup).CornerRadius = UDim.new(0, 16)

-- Gradient nền
local bgGradient = Instance.new("UIGradient")
bgGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(24, 14, 18)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(14, 14, 20)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(11, 11, 15))
})
bgGradient.Rotation = 120
bgGradient.Parent = popup

-- Viền RGB mảnh
local borderStroke = Instance.new("UIStroke")
borderStroke.Color = Color3.fromRGB(255, 60, 60)
borderStroke.Thickness = 1.2
borderStroke.Transparency = 0.15
borderStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
borderStroke.Parent = popup

-- Quầng sáng nền
local glow = Instance.new("ImageLabel")
glow.Size = UDim2.new(1, 60, 1, 60)
glow.Position = UDim2.new(0, -30, 0, -30)
glow.BackgroundTransparency = 1
glow.Image = "rbxassetid://5028857472"
glow.ImageColor3 = Color3.fromRGB(255, 60, 60)
glow.ImageTransparency = 0.85
glow.ZIndex = 998
glow.Parent = popup

-- Icon gear bên trái với hiệu ứng pulse
local iconBg = Instance.new("Frame")
iconBg.Size = UDim2.new(0, 48, 0, 48)
iconBg.Position = UDim2.new(0, 16, 0.5, -24)
iconBg.BackgroundColor3 = Color3.fromRGB(28, 18, 22)
iconBg.BorderSizePixel = 0
iconBg.ZIndex = 1001
iconBg.Parent = popup
Instance.new("UICorner", iconBg).CornerRadius = UDim.new(1, 0)

local iconGradient = Instance.new("UIGradient")
iconGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 20, 26)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 22, 30))
})
iconGradient.Rotation = 45
iconGradient.Parent = iconBg

local iconStroke = Instance.new("UIStroke")
iconStroke.Color = Color3.fromRGB(255, 80, 80)
iconStroke.Thickness = 1.2
iconStroke.Transparency = 0.3
iconStroke.Parent = iconBg

local gear = Instance.new("TextLabel")
gear.Size = UDim2.new(1, 0, 1, 0)
gear.BackgroundTransparency = 1
gear.Text = "⚙"
gear.Font = Enum.Font.GothamBold
gear.TextSize = 26
gear.TextColor3 = Color3.fromRGB(255, 100, 100)
gear.ZIndex = 1002
gear.Parent = iconBg

-- Vòng pulse tỏa ra từ icon
local pulseRing = Instance.new("Frame")
pulseRing.Size = UDim2.new(0, 48, 0, 48)
pulseRing.Position = UDim2.new(0, 0, 0, 0)
pulseRing.BackgroundTransparency = 1
pulseRing.ZIndex = 1000
pulseRing.Parent = iconBg
Instance.new("UICorner", pulseRing).CornerRadius = UDim.new(1, 0)

local pulseStroke = Instance.new("UIStroke")
pulseStroke.Color = Color3.fromRGB(255, 80, 80)
pulseStroke.Thickness = 1.5
pulseStroke.Transparency = 0.3
pulseStroke.Parent = pulseRing

-- Gear xoay liên tục
task.spawn(function()
    local rot = 0
    while gear.Parent do
        rot = (rot + 5) % 360
        gear.Rotation = rot
        task.wait(0.03)
    end
end)

-- Pulse ring lan rộng + mờ dần liên tục
task.spawn(function()
    while pulseRing.Parent do
        local newRing = pulseRing:Clone()
        newRing.Size = UDim2.new(0, 48, 0, 48)
        newRing.Position = UDim2.new(0, 0, 0, 0)
        newRing.Parent = iconBg
        newRing.ZIndex = 999
        
        TweenService:Create(newRing, TweenInfo.new(1.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 90, 0, 90),
            Position = UDim2.new(0, -21, 0, -21)
        }):Play()
        TweenService:Create(newRing.pulseStroke, TweenInfo.new(1.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Transparency = 1,
            Thickness = 0.3
        }):Play()
        
        task.delay(1.6, function()
            if newRing then newRing:Destroy() end
        end)
        
        task.wait(0.8)
    end
end)

-- Khối text bên phải
local textWrap = Instance.new("Frame")
textWrap.Size = UDim2.new(1, -80, 1, -8)
textWrap.Position = UDim2.new(0, 74, 0, 4)
textWrap.BackgroundTransparency = 1
textWrap.ZIndex = 1001
textWrap.Parent = popup

-- Dòng trên: fix lag v1.0 ✓
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 22)
titleLabel.Position = UDim2.new(0, 0, 0, 14)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "fix lag v1.0"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 16
titleLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.ZIndex = 1001
titleLabel.Parent = textWrap

local checkLabel = Instance.new("TextLabel")
checkLabel.Size = UDim2.new(0, 22, 0, 22)
checkLabel.Position = UDim2.new(1, -22, 0, 14)
checkLabel.BackgroundTransparency = 1
checkLabel.Text = "✓"
checkLabel.Font = Enum.Font.GothamBold
checkLabel.TextSize = 16
checkLabel.TextColor3 = Color3.fromRGB(80, 255, 130)
checkLabel.ZIndex = 1001
checkLabel.Parent = textWrap

-- Dòng dưới: by kudo29001 ⚡
local subLabel = Instance.new("TextLabel")
subLabel.Size = UDim2.new(1, 0, 0, 16)
subLabel.Position = UDim2.new(0, 0, 0, 38)
subLabel.BackgroundTransparency = 1
subLabel.Text = "by kudo29001 ⚡"
subLabel.Font = Enum.Font.Gotham
subLabel.TextSize = 11
subLabel.TextColor3 = Color3.fromRGB(150, 150, 165)
subLabel.TextXAlignment = Enum.TextXAlignment.Left
subLabel.ZIndex = 1001
subLabel.Parent = textWrap

-- Dòng phân cách mảnh
local divider = Instance.new("Frame")
divider.Size = UDim2.new(1, -32, 0, 1)
divider.Position = UDim2.new(0, 16, 1, -1)
divider.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
divider.BackgroundTransparency = 0.7
divider.BorderSizePixel = 0
divider.ZIndex = 1001
divider.Parent = popup

-- Thanh progress chạy dưới đáy (linear 3.5s)
local progressBar = Instance.new("Frame")
progressBar.Size = UDim2.new(0, 0, 0, 2)
progressBar.Position = UDim2.new(0, 16, 1, -2)
progressBar.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
progressBar.BorderSizePixel = 0
progressBar.ZIndex = 1002
progressBar.Parent = popup
Instance.new("UICorner", progressBar).CornerRadius = UDim.new(1, 0)

local progressGradient = Instance.new("UIGradient")
progressGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 60, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 150, 80))
})
progressGradient.Parent = progressBar

-- RGB border animation
task.spawn(function()
    local hue = 0
    while borderStroke.Parent do
        hue = (hue + 0.005) % 1
        borderStroke.Color = Color3.fromHSV(hue, 0.85, 1)
        task.wait(0.04)
    end
end)

-- ==================== ANIMATION MỞ ====================
popup.Position = UDim2.new(1, 30, 0.4, -40)
popup.BackgroundTransparency = 1
titleLabel.TextTransparency = 1
checkLabel.TextTransparency = 1
subLabel.TextTransparency = 1
gear.TextTransparency = 1
iconBg.BackgroundTransparency = 1
borderStroke.Transparency = 1
divider.BackgroundTransparency = 1
progressBar.BackgroundTransparency = 1

task.spawn(function()
    -- Trượt vào với easing Back
    TweenService:Create(popup, TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -320, 0.4, -40),
        BackgroundTransparency = 0
    }):Play()
    TweenService:Create(borderStroke, TweenInfo.new(0.4), {Transparency = 0.15}):Play()
    TweenService:Create(iconBg, TweenInfo.new(0.35), {BackgroundTransparency = 0}):Play()

    task.wait(0.15)

    TweenService:Create(gear, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
    TweenService:Create(titleLabel, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
    TweenService:Create(checkLabel, TweenInfo.new(0.3), {TextTransparency = 0}):Play()

    task.wait(0.1)

    TweenService:Create(subLabel, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
    TweenService:Create(divider, TweenInfo.new(0.3), {BackgroundTransparency = 0.7}):Play()

    task.wait(0.15)

    TweenService:Create(progressBar, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
    TweenService:Create(progressBar, TweenInfo.new(3, Enum.EasingStyle.Linear), {
        Size = UDim2.new(1, -32, 0, 2)
    }):Play()
end)

-- ==================== ANIMATION TẮT ====================
task.delay(3.5, function()
    pcall(function()
        -- Fade text trước
        TweenService:Create(subLabel, TweenInfo.new(0.25), {TextTransparency = 1}):Play()
        TweenService:Create(divider, TweenInfo.new(0.25), {BackgroundTransparency = 1}):Play()
        TweenService:Create(checkLabel, TweenInfo.new(0.25), {TextTransparency = 1}):Play()
        TweenService:Create(progressBar, TweenInfo.new(0.25), {BackgroundTransparency = 1}):Play()

        task.wait(0.1)
        TweenService:Create(titleLabel, TweenInfo.new(0.25), {TextTransparency = 1}):Play()
        TweenService:Create(gear, TweenInfo.new(0.25), {TextTransparency = 1}):Play()

        task.wait(0.1)
        TweenService:Create(iconBg, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
        TweenService:Create(borderStroke, TweenInfo.new(0.3), {Transparency = 1}):Play()

        task.wait(0.1)
        TweenService:Create(popup, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(1, 30, 0.4, -40),
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

-- ==================== XOÁ BẦU TRỜI ====================
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

-- ==================== NƯỚC ====================
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

-- ==================== CACHE NHÂN VẬT ====================
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

-- ==================== CULLING ====================
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

-- ==================== GC ====================
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

-- ==================== UI FPS + PING ====================
local statsGui = Instance.new("ScreenGui")
statsGui.Name = "KudoStats"
statsGui.ResetOnSpawn = false
statsGui.IgnoreGuiInset = true
statsGui.DisplayOrder = 2147483647
statsGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
statsGui.Parent = uiParent

local box = Instance.new("Frame")
box.Size = UDim2.new(0, 100, 0, 46)
box.Position = UDim2.new(1, -110, 1, -56)
box.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
box.BackgroundTransparency = 0.45
box.BorderSizePixel = 0
box.ZIndex = 1000
box.Parent = statsGui
Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)

local boxStroke = Instance.new("UIStroke")
boxStroke.Color = Color3.fromRGB(255, 60, 60)
boxStroke.Thickness = 1
boxStroke.Transparency = 0.75
boxStroke.Parent = box

local sep = Instance.new("Frame")
sep.Size = UDim2.new(1, -16, 0, 1)
sep.Position = UDim2.new(0, 8, 0, 23)
sep.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
sep.BackgroundTransparency = 0.8
sep.BorderSizePixel = 0
sep.ZIndex = 1001
sep.Parent = box

local fpsTitle = Instance.new("TextLabel")
fpsTitle.Size = UDim2.new(0, 30, 0, 23)
fpsTitle.Position = UDim2.new(0, 6, 0, 0)
fpsTitle.BackgroundTransparency = 1
fpsTitle.Text = "FPS"
fpsTitle.Font = Enum.Font.GothamBold
fpsTitle.TextSize = 9
fpsTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
fpsTitle.TextXAlignment = Enum.TextXAlignment.Left
fpsTitle.ZIndex = 1001
fpsTitle.Parent = box

local fpsValue = Instance.new("TextLabel")
fpsValue.Size = UDim2.new(0, 56, 0, 23)
fpsValue.Position = UDim2.new(1, -62, 0, 0)
fpsValue.BackgroundTransparency = 1
fpsValue.Text = "--"
fpsValue.Font = Enum.Font.GothamBold
fpsValue.TextSize = 11
fpsValue.TextColor3 = Color3.fromRGB(0, 255, 120)
fpsValue.TextXAlignment = Enum.TextXAlignment.Right
fpsValue.ZIndex = 1001
fpsValue.Parent = box

local pingTitle = Instance.new("TextLabel")
pingTitle.Size = UDim2.new(0, 30, 0, 23)
pingTitle.Position = UDim2.new(0, 6, 0, 23)
pingTitle.BackgroundTransparency = 1
pingTitle.Text = "PING"
pingTitle.Font = Enum.Font.GothamBold
pingTitle.TextSize = 9
pingTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
pingTitle.TextXAlignment = Enum.TextXAlignment.Left
pingTitle.ZIndex = 1001
pingTitle.Parent = box

local pingValue = Instance.new("TextLabel")
pingValue.Size = UDim2.new(0, 56, 0, 23)
pingValue.Position = UDim2.new(1, -62, 0, 23)
pingValue.BackgroundTransparency = 1
pingValue.Text = "--"
pingValue.Font = Enum.Font.GothamBold
pingValue.TextSize = 11
pingValue.TextColor3 = Color3.fromRGB(0, 255, 120)
pingValue.TextXAlignment = Enum.TextXAlignment.Right
pingValue.ZIndex = 1001
pingValue.Parent = box

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 16, 0, 16)
closeBtn