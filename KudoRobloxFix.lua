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

-- ==================== POPUP ====================
local popupGui = Instance.new("ScreenGui")
popupGui.Name = "KudoPopup"
popupGui.ResetOnSpawn = false
popupGui.IgnoreGuiInset = true
popupGui.DisplayOrder = 2147483647
popupGui.Parent = uiParent

local popup = Instance.new("Frame")
popup.Size = UDim2.new(0, 260, 0, 60)
popup.Position = UDim2.new(1, -280, 0.4, -30)
popup.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
popup.BorderSizePixel = 0
popup.Parent = popupGui
Instance.new("UICorner", popup).CornerRadius = UDim.new(0, 12)

local border = Instance.new("UIStroke")
border.Color = Color3.fromRGB(255, 60, 60)
border.Thickness = 1.5
border.Transparency = 0.2
border.Parent = popup

local icon = Instance.new("TextLabel")
icon.Size = UDim2.new(0, 30, 0, 30)
icon.Position = UDim2.new(0, 14, 0.5, -15)
icon.BackgroundTransparency = 1
icon.Text = "⚙"
icon.Font = Enum.Font.GothamBold
icon.TextSize = 20
icon.TextColor3 = Color3.fromRGB(255, 80, 80)
icon.Parent = popup

task.spawn(function()
    local r = 0
    while icon.Parent do
        r = (r + 6) % 360
        icon.Rotation = r
        task.wait(0.03)
    end
end)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 0, 20)
title.Position = UDim2.new(0, 52, 0, 12)
title.BackgroundTransparency = 1
title.Text = "fix lag v1.0 ✓"
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextColor3 = Color3.fromRGB(255, 90, 90)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = popup

local sub = Instance.new("TextLabel")
sub.Size = UDim2.new(1, -60, 0, 16)
sub.Position = UDim2.new(0, 52, 0, 32)
sub.BackgroundTransparency = 1
sub.Text = "by kudo29001 ⚡"
sub.Font = Enum.Font.Gotham
sub.TextSize = 10
sub.TextColor3 = Color3.fromRGB(160, 160, 170)
sub.TextXAlignment = Enum.TextXAlignment.Left
sub.Parent = popup

TweenService:Create(popup, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Position = UDim2.new(1, -280, 0.4, -30)
}):Play()

task.delay(3.5, function()
    pcall(function()
        TweenService:Create(popup, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(1, -20, 0.4, -30),
            BackgroundTransparency = 1
        }):Play()
        TweenService:Create(title, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
        TweenService:Create(sub, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
        TweenService:Create(icon, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
        TweenService:Create(border, TweenInfo.new(0.3), {Transparency = 1}):Play()
        task.wait(0.4)
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

-- ==================== UI FPS + PING (KÉO + RESIZE) ====================
local statsGui = Instance.new("ScreenGui")
statsGui.Name = "KudoStats"
statsGui.ResetOnSpawn = false
statsGui.IgnoreGuiInset = true
statsGui.DisplayOrder = 2147483647
statsGui.Parent = uiParent

local box = Instance.new("Frame")
box.Size = UDim2.new(0, 100, 0, 46)
box.Position = UDim2.new(1, -110, 1, -56)
box.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
box.BackgroundTransparency = 0.4
box.BorderSizePixel = 0
box.Active = true
box.Draggable = true
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
pingValue.Parent = box

-- Nút X hình tròn
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 18, 0, 18)
closeBtn.Position = UDim2.new(1, -24, 0, 4)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
closeBtn.Text = "x"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 12
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.BorderSizePixel = 0
closeBtn.Parent = box
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)

closeBtn.MouseButton1Click:Connect(function()
    pcall(function() statsGui:Destroy() end)
end)

-- Kéo di chuyển bằng touch (mobile)
local dragging = false
local dragStart, startPos

box.InputBegan:Connect(function(input)
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

-- Resize bằng cách kéo góc dưới phải
local resizeHandle = Instance.new("TextButton")
resizeHandle.Size = UDim2.new(0, 12, 0, 12)
resizeHandle.Position = UDim2.new(1, -14, 1, -14)
resizeHandle.BackgroundTransparency = 1
resizeHandle.Text = ""
resizeHandle.Parent = box

local resizing = false
local resizeStart, resizeStartSize

resizeHandle.InputBegan:Connect(function(input)
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
        local newX = math.max(80, resizeStartSize.X.Offset + delta.X)
        local newY = math.max(40, resizeStartSize.Y.Offset + delta.Y)
        box.Size = UDim2.new(0, newX, 0, newY)
        -- Cập nhật vị trí các element theo size mới
        sep.Position = UDim2.new(0, 8, 0.5, 0)
        pingTitle.Position = UDim2.new(0, 6, 0.5, 0)
        pingValue.Position = UDim2.new(1, -62, 0.5, 0)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch 
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
        resizing = false
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