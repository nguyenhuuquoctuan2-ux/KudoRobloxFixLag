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

-- ==================== POPUP ====================
local popupGui = Instance.new("ScreenGui")
popupGui.Name = "KudoPopup"
popupGui.ResetOnSpawn = false
popupGui.IgnoreGuiInset = true
popupGui.DisplayOrder = 2147483647
popupGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
popupGui.Parent = uiParent

local popup = Instance.new("Frame")
popup.Size = UDim2.new(0, 260, 0, 62)
popup.Position = UDim2.new(1, 20, 0.35, -31)
popup.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
popup.BackgroundTransparency = 0.05
popup.BorderSizePixel = 0
popup.ZIndex = 1000
popup.Parent = popupGui
Instance.new("UICorner", popup).CornerRadius = UDim.new(0, 12)

local borderTop = Instance.new("Frame")
borderTop.Size = UDim2.new(1, 4, 0, 2)
borderTop.Position = UDim2.new(0, -2, 0, -2)
borderTop.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
borderTop.BorderSizePixel = 0
borderTop.ZIndex = 999
borderTop.Parent = popup

local borderBottom = Instance.new("Frame")
borderBottom.Size = UDim2.new(1, 4, 0, 2)
borderBottom.Position = UDim2.new(0, -2, 1, 0)
borderBottom.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
borderBottom.BorderSizePixel = 0
borderBottom.ZIndex = 999
borderBottom.Parent = popup

local borderLeft = Instance.new("Frame")
borderLeft.Size = UDim2.new(0, 2, 1, 4)
borderLeft.Position = UDim2.new(0, -2, 0, -2)
borderLeft.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
borderLeft.BorderSizePixel = 0
borderLeft.ZIndex = 999
borderLeft.Parent = popup

local borderRight = Instance.new("Frame")
borderRight.Size = UDim2.new(0, 2, 1, 4)
borderRight.Position = UDim2.new(1, 0, 0, -2)
borderRight.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
borderRight.BorderSizePixel = 0
borderRight.ZIndex = 999
borderRight.Parent = popup

local rgbRun = true
task.spawn(function()
    local hue = 0
    while rgbRun do
        hue = (hue + 0.02) % 1
        local c = Color3.fromHSV(hue, 1, 1)
        borderTop.BackgroundColor3 = c
        borderBottom.BackgroundColor3 = c
        borderLeft.BackgroundColor3 = c
        borderRight.BackgroundColor3 = c
        task.wait(0.05)
    end
end)

local accentBar = Instance.new("Frame")
accentBar.Size = UDim2.new(0, 3, 1, -16)
accentBar.Position = UDim2.new(0, 2, 0, 8)
accentBar.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
accentBar.BorderSizePixel = 0
accentBar.ZIndex = 1001
accentBar.Parent = popup
Instance.new("UICorner", accentBar).CornerRadius = UDim.new(0, 2)

local gearLabel = Instance.new("TextLabel")
gearLabel.Size = UDim2.new(0, 36, 0, 36)
gearLabel.Position = UDim2.new(0, 14, 0.5, -18)
gearLabel.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
gearLabel.Text = "⚙"
gearLabel.Font = Enum.Font.GothamBold
gearLabel.TextSize = 22
gearLabel.TextColor3 = Color3.fromRGB(255, 70, 70)
gearLabel.ZIndex = 1001
gearLabel.Parent = popup
Instance.new("UICorner", gearLabel).CornerRadius = UDim.new(0, 8)

local gearRun = true
task.spawn(function()
    while gearRun do
        for i = 0, 360, 30 do
            if not gearRun then break end
            gearLabel.Rotation = i
            task.wait(0.06)
        end
    end
end)

local popupTitle = Instance.new("TextLabel")
popupTitle.Size = UDim2.new(1, -75, 0, 18)
popupTitle.Position = UDim2.new(0, 60, 0, 12)
popupTitle.BackgroundTransparency = 1
popupTitle.Text = "fix lag v1.0 ✓"
popupTitle.Font = Enum.Font.GothamBold
popupTitle.TextSize = 13
popupTitle.TextColor3 = Color3.fromRGB(255, 70, 70)
popupTitle.TextXAlignment = Enum.TextXAlignment.Left
popupTitle.ZIndex = 1001
popupTitle.Parent = popup

local popupSub = Instance.new("TextLabel")
popupSub.Size = UDim2.new(1, -75, 0, 14)
popupSub.Position = UDim2.new(0, 60, 0, 32)
popupSub.BackgroundTransparency = 1
popupSub.Text = "by kudo29001⚡"
popupSub.Font = Enum.Font.Gotham
popupSub.TextSize = 10
popupSub.TextColor3 = Color3.fromRGB(180, 180, 190)
popupSub.TextXAlignment = Enum.TextXAlignment.Left
popupSub.ZIndex = 1001
popupSub.Parent = popup

TweenService:Create(popup, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Position = UDim2.new(1, -280, 0.35, -31)
}):Play()

task.delay(3.5, function()
    pcall(function()
        rgbRun = false
        gearRun = false
        local out = TweenService:Create(popup, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(1, 20, 0.35, -31),
            BackgroundTransparency = 1
        })
        out:Play()
        TweenService:Create(popupTitle, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
        TweenService:Create(popupSub, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
        TweenService:Create(gearLabel, TweenInfo.new(0.4), {TextTransparency = 1, BackgroundTransparency = 1}):Play()
        TweenService:Create(accentBar, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
        for _, b in ipairs({borderTop, borderBottom, borderLeft, borderRight}) do
            TweenService:Create(b, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
        end
        out.Completed:Wait()
        popupGui:Destroy()
    end)
end)

-- ==================== FFLAG — TỐI ƯU NETWORK + GRAPHICS ====================
pcall(function()
    -- FPS unlimited
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

    -- ===== NETWORK TỐI ƯU (giảm ping spike) =====
    setfflag("DFIntConnectionMTUSize", "1400")
    setfflag("DFIntS2PhysicsSenderRate", "1")
    setfflag("DFIntClientPhysicsSendRate", "1")
    setfflag("DFIntPhysicsSenderRate", "1")
    setfflag("DFIntNetworkClusterPacketCache", "0")
    setfflag("FFlagEnableNetworkClusterPacketCache", "False")
    setfflag("DFIntNetworkPacketBufferSize", "2048")
    setfflag("DFIntNetworkReceiveBufferSize", "2048")
    setfflag("DFIntNetworkSendBufferSize", "2048")
    setfflag("DFFlagEnableNetworkPingOptimization", "True")
    setfflag("DFFlagEnableNetworkPacketCoalescing", "True")
    setfflag("FFlagEnableNetworkPacketCoalescing", "True")
    setfflag("DFIntNetworkPacketCoalescingWindow", "1")
    setfflag("FFlagEnableNetworkPrioritySystem", "True")
    setfflag("DFIntNetworkPriorityBoost", "1")
    setfflag("DFFlagEnableNetworkCompression", "True")
    setfflag("FFlagEnableNetworkCompression", "True")
    setfflag("DFFlagEnableNetworkEncryptionOptimization", "True")
    setfflag("DFIntDataPingUpdateInterval", "5")
    setfflag("DFIntNetworkTimeout", "30")
    setfflag("DFIntNetworkRetryCount", "3")
    setfflag("DFIntReplicationDataCompressionLevel", "1")
    setfflag("DFFlagEnableReplicationCompression", "True")
    setfflag("DFIntReplicationRate", "30")
    setfflag("DFIntReplicationQueueSize", "512")
    setfflag("DFFlagPrioritizeReplication", "True")

    -- ===== GRAPHICS =====
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

    -- ===== PHYSICS =====
    setfflag("DFIntSolverSpringDamping", "0")
    setfflag("DFIntPhysicsSendRate", "1")
    setfflag("DFIntMaxSimultaneousPhysicsJobs", "1")
    setfflag("DFIntPhysicsStepPerFrame", "1")
    setfflag("DFIntMaximumCollisionIterations", "1")
    setfflag("DFIntSolverConvergenceIterations", "1")

    -- ===== RENDER =====
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
    setfflag("FFlagDisableDecals", "True")
    setfflag("FFlagDisableReflections", "True")
    setfflag("FFlagDisableGlassRefraction", "True")
    setfflag("DFFlagSkipRenderMesh", "True")
    setfflag("FFlagDisableMultiSample", "True")
    setfflag("FFlagDisableHDR", "True")
    setfflag("FFlagDisableToneMapping", "True")

    -- ===== ANIMATION =====
    setfflag("FFlagDisableAnimationBlending", "True")
    setfflag("DFFlagSkipAnimationBlending", "True")
    setfflag("FFlagDisableFacialAnimation", "True")

    -- ===== GC (chạy nền, không block) =====
    setfflag("DFFlagGCEnableIncremental", "True")
    setfflag("DFIntGCIncrementalPause", "8")
    setfflag("DFIntGCIncrementalStepMul", "5000")
    setfflag("DFIntGCIncrementalStepSizeKb", "128")

    -- ===== ASSET DOWNLOAD =====
    setfflag("DFIntAssetRequestBatchSize", "8")
    setfflag("DFIntMaxAssetDownloadConcurrency", "4")
    setfflag("DFFlagThrottleAssetDownloads", "False")
    setfflag("DFIntAssetDownloadThrottleMs", "0")
    setfflag("FFlagPrioritizeCriticalAssets", "True")

    -- ===== MISC =====
    setfflag("FFlagDebugGraphicsDisableDirect3D11", "True")
    setfflag("FFlagDebugGraphicsPreferOpenGL", "True")
    setfflag("FFlagDisableCharacterEmotes", "True")
    setfflag("FFlagDisableDefaultLoadingScreen", "True")
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
        Workspace.StreamingTargetRadius = 80
        Workspace.StreamingMinRadius = 40
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
    Sound = true, Animation = true, SurfaceAppearance = true,
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

-- ==================== BULK XỬ LÝ ====================
local descendants = Workspace:GetDescendants()
local total = #descendants

for i = 1, total do
    handleObject(descendants[i])
    if i % 400 == 0 then task.wait() end
end

-- ==================== QUEUE XỬ LÝ OBJECT MỚI ====================
local pendingQueue = {}
local processing = false

local function processQueue()
    if processing then return end
    processing = true
    task.spawn(function()
        while #pendingQueue > 0 do
            local obj = table.remove(pendingQueue, 1)
            if obj and obj.Parent then
                pcall(function() handleObject(obj) end)
            end
            if #pendingQueue % 50 == 0 then
                task.wait()
            end
        end
        processing = false
    end)
end

Workspace.DescendantAdded:Connect(function(v)
    table.insert(pendingQueue, v)
    processQueue()
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

local frames = 0
local lastTime = tick()
local pingHistory = {}
local pingIndex = 1

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
        if currentFPS < 25 then
            fpsColor = Color3.fromRGB(255, 60, 60)
        elseif currentFPS < 40 then
            fpsColor = Color3.fromRGB(255, 200, 60)
        elseif currentFPS <= 240 then
            fpsColor = Color3.fromRGB(0, 255, 120)
        else
            local hue = (tick() % 1)
            fpsColor = Color3.fromHSV(hue, 1, 1)
        end
        fpsValue.TextColor3 = fpsColor

        -- Ping đo trung bình 5 mẫu để hiển thị mượt
        local ping = 0
        pcall(function()
            ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        end)
        
        pingHistory[pingIndex] = ping
        pingIndex = pingIndex + 1
        if pingIndex > 5 then pingIndex = 1 end
        
        local sum = 0
        local count = 0
        for _, p in pairs(pingHistory) do
            sum = sum + p
            count = count + 1
        end
        local avgPing = math.floor(sum / count)

        pingValue.Text = avgPing .. "ms"

        local pingColor
        if avgPing <= 27 then
            pingColor = Color3.fromRGB(0, 255, 120)
        elseif avgPing <= 110 then
            pingColor = Color3.fromRGB(255, 200, 60)
        else
            pingColor = Color3.fromRGB(255, 60, 60)
        end
        pingValue.TextColor3 = pingColor
    end
end)

print("✅ fix lag v1.0 by kudo29001")