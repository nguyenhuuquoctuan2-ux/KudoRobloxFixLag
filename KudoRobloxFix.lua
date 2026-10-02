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

-- ==================== POPUP SÁNG TẠO ====================
local popupGui = Instance.new("ScreenGui")
popupGui.Name = "KudoPopup"
popupGui.ResetOnSpawn = false
popupGui.IgnoreGuiInset = true
popupGui.DisplayOrder = 2147483647
popupGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
popupGui.Parent = uiParent

-- Container chính
local popup = Instance.new("Frame")
popup.Size = UDim2.new(0, 280, 0, 76)
popup.Position = UDim2.new(1, 20, 0.35, -38)
popup.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
popup.BackgroundTransparency = 0.05
popup.BorderSizePixel = 0
popup.ZIndex = 1000
popup.ClipsDescendants = false
popup.Parent = popupGui
Instance.new("UICorner", popup).CornerRadius = UDim.new(0, 14)

-- Viền RGB chạy
local borderStroke = Instance.new("UIStroke")
borderStroke.Color = Color3.fromRGB(255, 60, 60)
borderStroke.Thickness = 1.8
borderStroke.Transparency = 0
borderStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
borderStroke.Parent = popup

-- Gradient overlay nền (tạo cảm giác sáng tạo)
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 20, 20)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(16, 16, 22))
})
gradient.Rotation = 45
gradient.Parent = popup

-- Vạch accent gradient bên trái
local accentBar = Instance.new("Frame")
accentBar.Size = UDim2.new(0, 4, 1, -20)
accentBar.Position = UDim2.new(0, 0, 0, 10)
accentBar.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
accentBar.BorderSizePixel = 0
accentBar.ZIndex = 1001
accentBar.Parent = popup
Instance.new("UICorner", accentBar).CornerRadius = UDim.new(0, 3)

local accentGradient = Instance.new("UIGradient")
accentGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 60, 60)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 130, 100)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 40, 80))
})
accentGradient.Rotation = 90
accentGradient.Parent = accentBar

-- Icon tròn với glow
local iconWrap = Instance.new("Frame")
iconWrap.Size = UDim2.new(0, 44, 0, 44)
iconWrap.Position = UDim2.new(0, 18, 0.5, -22)
iconWrap.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
iconWrap.BorderSizePixel = 0
iconWrap.ZIndex = 1001
iconWrap.Parent = popup
Instance.new("UICorner", iconWrap).CornerRadius = UDim.new(1, 0)

local iconStroke = Instance.new("UIStroke")
iconStroke.Color = Color3.fromRGB(255, 60, 60)
iconStroke.Thickness = 1.5
iconStroke.Transparency = 0.15
iconStroke.Parent = iconWrap

-- Glow nền icon (dùng gradient)
local iconGradient = Instance.new("UIGradient")
iconGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 20, 30)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(24, 24, 32))
})
iconGradient.Rotation = 60
iconGradient.Parent = iconWrap

local gearLabel = Instance.new("TextLabel")
gearLabel.Size = UDim2.new(1, 0, 1, 0)
gearLabel.BackgroundTransparency = 1
gearLabel.Text = "⚙"
gearLabel.Font = Enum.Font.GothamBold
gearLabel.TextSize = 26
gearLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
gearLabel.ZIndex = 1002
gearLabel.Parent = iconWrap

task.spawn(function()
    local rot = 0
    while gearLabel.Parent do
        rot = (rot + 4) % 360
        gearLabel.Rotation = rot
        task.wait(0.03)
    end
end)

-- Viền ring xoay quanh icon
local ring = Instance.new("Frame")
ring.Size = UDim2.new(0, 52, 0, 52)
ring.Position = UDim2.new(0, -4, 0, -4)
ring.BackgroundTransparency = 1
ring.ZIndex = 1000
ring.Parent = iconWrap
Instance.new("UICorner", ring).CornerRadius = UDim.new(1, 0)

local ringStroke = Instance.new("UIStroke")
ringStroke.Color = Color3.fromRGB(255, 60, 60)
ringStroke.Thickness = 1
ringStroke.Transparency = 0.6
ringStroke.Parent = ring

-- Hai chấm sáng chạy quanh ring (dùng Frame nhỏ)
local dot1 = Instance.new("Frame")
dot1.Size = UDim2.new(0, 5, 0, 5)
dot1.Position = UDim2.new(0.5, -2.5, 0, -2.5)
dot1.AnchorPoint = Vector2.new(0.5, 0.5)
dot1.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
dot1.BorderSizePixel = 0
dot1.ZIndex = 1003
dot1.Parent = ring
Instance.new("UICorner", dot1).CornerRadius = UDim.new(1, 0)

task.spawn(function()
    local angle = 0
    while ring.Parent do
        angle = (angle + 0.06) % (math.pi * 2)
        local cx = 0.5 + math.cos(angle) * 0.5
        local cy = 0.5 + math.sin(angle) * 0.5
        dot1.Position = UDim2.new(cx, -2.5, cy, -2.5)
        task.wait(0.02)
    end
end)

-- Nội dung text
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -90, 0, 20)
titleLabel.Position = UDim2.new(0, 74, 0, 16)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "fix lag v1.0"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 15
titleLabel.TextColor3 = Color3.fromRGB(255, 90, 90)
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.ZIndex = 1001
titleLabel.Parent = popup

-- Dấu check ở cuối title, tách riêng để đổi màu
local checkLabel = Instance.new("TextLabel")
checkLabel.Size = UDim2.new(0, 20, 0, 20)
checkLabel.Position = UDim2.new(1, -32, 0, 16)
checkLabel.BackgroundTransparency = 1
checkLabel.Text = "✓"
checkLabel.Font = Enum.Font.GothamBold
checkLabel.TextSize = 15
checkLabel.TextColor3 = Color3.fromRGB(0, 255, 120)
checkLabel.ZIndex = 1001
checkLabel.Parent = popup

-- Subtitle nhỏ
local subLabel = Instance.new("TextLabel")
subLabel.Size = UDim2.new(1, -90, 0, 16)
subLabel.Position = UDim2.new(0, 74, 0, 38)
subLabel.BackgroundTransparency = 1
subLabel.Text = "by kudo29001 ⚡"
subLabel.Font = Enum.Font.Gotham
subLabel.TextSize = 11
subLabel.TextColor3 = Color3.fromRGB(170, 170, 180)
subLabel.TextXAlignment = Enum.TextXAlignment.Left
subLabel.ZIndex = 1001
subLabel.Parent = popup

-- Thanh progress mảnh dưới đáy
local progressBg = Instance.new("Frame")
progressBg.Size = UDim2.new(1, -24, 0, 2)
progressBg.Position = UDim2.new(0, 12, 1, -8)
progressBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
progressBg.BorderSizePixel = 0
progressBg.ZIndex = 1001
progressBg.Parent = popup
Instance.new("UICorner", progressBg).CornerRadius = UDim.new(1, 0)

local progressFill = Instance.new("Frame")
progressFill.Size = UDim2.new(0, 0, 1, 0)
progressFill.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
progressFill.BorderSizePixel = 0
progressFill.ZIndex = 1002
progressFill.Parent = progressBg
Instance.new("UICorner", progressFill).CornerRadius = UDim.new(1, 0)

local progressGradient = Instance.new("UIGradient")
progressGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 60, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 140, 100))
})
progressGradient.Parent = progressFill

-- Progress chạy trong 3.5s tương ứng popup
TweenService:Create(progressFill, TweenInfo.new(3.5, Enum.EasingStyle.Linear), {
    Size = UDim2.new(1, 0, 1, 0)
}):Play()

-- RGB border animation
task.spawn(function()
    local hue = 0
    while borderStroke.Parent do
        hue = (hue + 0.006) % 1
        borderStroke.Color = Color3.fromHSV(hue, 0.85, 1)
        task.wait(0.03)
    end
end)

-- Slide in
TweenService:Create(popup, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Position = UDim2.new(1, -300, 0.35, -38)
}):Play()

-- Slide out sau 3.5s
task.delay(3.5, function()
    pcall(function()
        local out = TweenService:Create(popup, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(1, 20, 0.35, -38),
            BackgroundTransparency = 1
        })
        out:Play()
        TweenService:Create(titleLabel, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
        TweenService:Create(checkLabel, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
        TweenService:Create(subLabel, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
        TweenService:Create(gearLabel, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
        TweenService:Create(iconWrap, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
        TweenService:Create(iconStroke, TweenInfo.new(0.4), {Transparency = 1}):Play()
        TweenService:Create(borderStroke, TweenInfo.new(0.4), {Transparency = 1}):Play()
        TweenService:Create(accentBar, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
        TweenService:Create(ringStroke, TweenInfo.new(0.4), {Transparency = 1}):Play()
        TweenService:Create(progressBg, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
        TweenService:Create(progressFill, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
        TweenService:Create(dot1, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
        out.Completed:Wait()
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

-- KHÔNG xoá Sound
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
closeBtn.Position = UDim2.new(1, -22, 0, 4)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
closeBtn.Text = "✕"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 10
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.BorderSizePixel = 0
closeBtn.ZIndex = 1002
closeBtn.Parent = box
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 4)

closeBtn.MouseButton1Click:Connect(function()
    pcall(function()
        statsGui:Destroy()
    end)
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

        local fpsColor
        if currentFPS < 40 then
            fpsColor = Color3.fromRGB(255, 60, 60)
        else
            fpsColor = Color3.fromRGB(0, 255, 120)
        end
        fpsValue.TextColor3 = fpsColor

        local ping = 0
        pcall(function()
            ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        end)
        pingValue.Text = ping .. "ms"

        local pingColor
        if ping <= 100 then
            pingColor = Color3.fromRGB(0, 255, 120)
        else
            pingColor = Color3.fromRGB(255, 60, 60)
        end
        pingValue.TextColor3 = pingColor
    end
end)

print("✅ fix lag v1.0 by kudo29001")