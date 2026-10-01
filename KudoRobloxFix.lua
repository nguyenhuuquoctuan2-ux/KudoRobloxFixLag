local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Terrain = Workspace:FindFirstChildOfClass("Terrain")
local Camera = Workspace.CurrentCamera
local Stats = game:GetService("Stats")

-- ==================== POPUP ====================
local popupGui = Instance.new("ScreenGui")
popupGui.Name = "KudoPopup"
popupGui.ResetOnSpawn = false
popupGui.IgnoreGuiInset = true
popupGui.Parent = playerGui

local popup = Instance.new("Frame")
popup.Size = UDim2.new(0, 240, 0, 60)
popup.Position = UDim2.new(1, 20, 0.35, -30)
popup.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
popup.BackgroundTransparency = 0.1
popup.BorderSizePixel = 0
popup.Parent = popupGui
Instance.new("UICorner", popup).CornerRadius = UDim.new(0, 10)

local popupStroke = Instance.new("UIStroke")
popupStroke.Color = Color3.fromRGB(255, 60, 60)
popupStroke.Thickness = 1
popupStroke.Transparency = 0.4
popupStroke.Parent = popup

local popupLabel = Instance.new("TextLabel")
popupLabel.Size = UDim2.new(1, -20, 1, -12)
popupLabel.Position = UDim2.new(0, 10, 0, 6)
popupLabel.BackgroundTransparency = 1
popupLabel.Text = "fix lag đang hoạt động ✓\nmade by kudo29001⚡"
popupLabel.Font = Enum.Font.GothamBold
popupLabel.TextSize = 12
popupLabel.TextColor3 = Color3.fromRGB(255, 70, 70)
popupLabel.TextXAlignment = Enum.TextXAlignment.Center
popupLabel.TextYAlignment = Enum.TextYAlignment.Center
popupLabel.TextWrapped = true
popupLabel.Parent = popup

TweenService:Create(popup, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Position = UDim2.new(1, -260, 0.35, -30)
}):Play()

task.delay(6, function()
    pcall(function()
        local out = TweenService:Create(popup, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(1, 20, 0.35, -30),
            BackgroundTransparency = 1
        })
        out:Play()
        TweenService:Create(popupLabel, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
        TweenService:Create(popupStroke, TweenInfo.new(0.4), {Transparency = 1}):Play()
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
    setfflag("FFlagDisableSkybox", "True")
    setfflag("FFlagDisableFog", "True")
    setfflag("FFlagDisableWater", "True")
    setfflag("FFlagDisableTerrain", "True")
    setfflag("DFFlagDisableTerrainTextures", "True")
    setfflag("FFlagDisableTerrainDecoration", "True")
    setfflag("FIntFRMMaxGrassDistance", "0")
    setfflag("FIntFRMMinGrassDistance", "0")
    setfflag("FIntGrassMovementReducedMotionFactor", "0")
    setfflag("FFlagDisableTerrainWaterReflections", "True")
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
    setfflag("DFIntPhysicsTickerMaxTime", "1")
    setfflag("FFlagDisableRaycastFiltering", "True")
    setfflag("DFFlagSkipRaycastFiltering", "True")
    setfflag("DFIntAdaptivePhysicsStepping", "1")
    setfflag("DFIntFrameBufferPoolSize", "1")
    setfflag("DFIntRenderMeshMaxBones", "1")
    setfflag("DFIntDebugEngineOptimizationLevel", "3")
    setfflag("DFFlagDisableGPUOcclusion", "False")
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
    setfflag("DFIntGCIncrementalPause", "0")
    setfflag("DFIntGCIncrementalStepMul", "2000")
    setfflag("DFIntConnectionMTUSize", "1400")
    setfflag("DFIntS2PhysicsSenderRate", "1")
    setfflag("FFlagDebugGraphicsDisableDirect3D11", "True")
    setfflag("FFlagDebugGraphicsPreferOpenGL", "True")
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
        Workspace.StreamingTargetRadius = 64
        Workspace.StreamingMinRadius = 32
        Workspace.StreamOutBehavior = Enum.StreamOutBehavior.Opportunistic
    end)
end)

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

pcall(function()
    if Terrain then
        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveSpeed = 0
        Terrain.WaterReflectance = 0
        Terrain.WaterTransparency = 0.4
        Terrain.WaterColor = Color3.fromRGB(60, 130, 220)
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

-- ==================== HÀM POTATO HOÁ BASEPART ====================
-- Đổi material sang SmoothPlastic, màu xám đơn điệu
local POTATO_COLOR = Color3.fromRGB(110, 110, 110)

local function potatoPart(part)
    pcall(function()
        part.Material = Enum.Material.SmoothPlastic
        part.Color = POTATO_COLOR
        part.Reflectance = 0
        part.Transparency = 0
        part.CastShadow = false
    end)
end

-- ==================== BULK XỬ LÝ ====================
local killTypes = {
    ParticleEmitter = true, Trail = true, Smoke = true, Fire = true,
    Sparkles = true, Beam = true, Highlight = true, SelectionBox = true,
    BoxHandleAdornment = true, PointLight = true, SpotLight = true,
    SurfaceLight = true, ForceField = true, Explosion = true,
    Sound = true, Animation = true, SurfaceAppearance = true,
    Decal = true, Texture = true, SpecialMesh = true,
}

local descendants = Workspace:GetDescendants()
local total = #descendants

for i = 1, total do
    local v = descendants[i]
    local cn = v.ClassName

    if cn == "Part" or cn == "MeshPart" or cn == "UnionOperation" or cn == "WedgePart"
        or cn == "TrussPart" or cn == "CornerWedgePart" or cn == "SpawnLocation" then
        if isChar(v) then
            potatoPart(v)
        else
            potatoPart(v)
        end
    elseif killTypes[cn] then
        if not isName(v) then
            if isChar(v) then
                if cn == "Decal" or cn == "Texture" then
                    local parent = v.Parent
                    if not (parent and parent.Name == "Head") then
                        pcall(function() v.Transparency = 1 end)
                    end
                elseif cn == "SpecialMesh" then
                    pcall(function()
                        if v.MeshType == Enum.MeshType.FileMesh or v.MeshType == Enum.MeshType.Head then
                            v.MeshType = Enum.MeshType.Head
                            v.TextureId = ""
                        end
                    end)
                elseif cn == "Sound" or cn == "Animation" then
                    pcall(function() v:Destroy() end)
                end
            else
                pcall(function() v:Destroy() end)
            end
        end
    end
    if i % 500 == 0 then task.wait() end
end

-- Đầu nhân vật về mặc định
local function resetHead(character)
    if not character then return end
    local head = character:FindFirstChild("Head")
    if not head then return end
    for _, v in ipairs(head:GetChildren()) do
        if v:IsA("SpecialMesh") then
            pcall(function() v:Destroy() end)
        end
    end
    local newMesh = Instance.new("SpecialMesh")
    newMesh.MeshType = Enum.MeshType.Head
    newMesh.Parent = head
end

for _, plr in ipairs(game.Players:GetPlayers()) do
    if plr.Character then resetHead(plr.Character) end
    plr.CharacterAdded:Connect(function(c)
        task.wait(0.5)
        resetHead(c)
    end)
end

-- ==================== LẮNG NGHE OBJECT MỚI ====================
local scanConn = Workspace.DescendantAdded:Connect(function(v)
    task.defer(function()
        pcall(function()
            local cn = v.ClassName
            if cn == "Part" or cn == "MeshPart" or cn == "UnionOperation" or cn == "WedgePart"
                or cn == "TrussPart" or cn == "CornerWedgePart" or cn == "SpawnLocation" then
                potatoPart(v)
            elseif killTypes[cn] then
                if not isName(v) then
                    if isChar(v) then
                        if cn == "Decal" or cn == "Texture" then
                            local parent = v.Parent
                            if not (parent and parent.Name == "Head") then
                                v.Transparency = 1
                            end
                        elseif cn == "Sound" or cn == "Animation" then
                            v:Destroy()
                        end
                    else
                        v:Destroy()
                    end
                end
            end
        end)
    end)
end)

-- ==================== VÒNG LẶP POTATO PART MỚI ====================
task.spawn(function()
    while statsGui and statsGui.Parent do
        task.wait(2)
        pcall(function()
            for _, top in ipairs(Workspace:GetChildren()) do
                if not isChar(top) then
                    for _, v in ipairs(top:GetDescendants()) do
                        if v:IsA("BasePart") then
                            if v.Material ~= Enum.Material.SmoothPlastic then
                                v.Material = Enum.Material.SmoothPlastic
                            end
                            if v.Color ~= POTATO_COLOR then
                                v.Color = POTATO_COLOR
                            end
                        end
                    end
                end
            end
        end)
    end
end)

-- ==================== DISTANCE CULLING ====================
local CULL_DIST = 12
local CULL_DIST_SQ = CULL_DIST * CULL_DIST

local culledState = {}

local function setVisible(obj, visible)
    if visible then
        pcall(function() obj.LocalTransparencyModifier = 0 end)
        culledState[obj] = false
    else
        pcall(function() obj.LocalTransparencyModifier = 1 end)
        culledState[obj] = true
    end
end

local cullConn = RunService.Heartbeat:Connect(function()
    pcall(function()
        if not Camera then return end
        local camPos = Camera.CFrame.Position
        for _, top in ipairs(Workspace:GetChildren()) do
            if top:IsA("Model") then
                if not isChar(top) then
                    local pivot
                    pcall(function() pivot = top:GetPivot().Position end)
                    if not pivot then
                        local prim = top.PrimaryPart
                        if prim then pivot = prim.Position end
                    end
                    if pivot then
                        local d = pivot - camPos
                        local distSq = d.X*d.X + d.Y*d.Y + d.Z*d.Z
                        local visible = distSq <= CULL_DIST_SQ
                        for _, p in ipairs(top:GetDescendants()) do
                            if p:IsA("BasePart") then
                                local cur = culledState[p]
                                if visible and cur ~= false then
                                    setVisible(p, true)
                                elseif not visible and cur ~= true then
                                    setVisible(p, false)
                                end
                            end
                        end
                    end
                end
            elseif top:IsA("BasePart") then
                if not isChar(top) then
                    local d = top.Position - camPos
                    local distSq = d.X*d.X + d.Y*d.Y + d.Z*d.Z
                    local visible = distSq <= CULL_DIST_SQ
                    local cur = culledState[top]
                    if visible and cur ~= false then
                        setVisible(top, true)
                    elseif not visible and cur ~= true then
                        setVisible(top, false)
                    end
                end
            end
        end
    end)
end)

-- ==================== UI FPS + PING ====================
local statsGui = Instance.new("ScreenGui")
statsGui.Name = "KudoStats"
statsGui.ResetOnSpawn = false
statsGui.IgnoreGuiInset = true
statsGui.Parent = playerGui

local box = Instance.new("Frame")
box.Size = UDim2.new(0, 100, 0, 46)
box.Position = UDim2.new(1, -110, 1, -56)
box.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
box.BackgroundTransparency = 0.45
box.BorderSizePixel = 0
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

local frames = 0
task.spawn(function()
    RunService.RenderStepped:Connect(function() frames = frames + 1 end)
    while statsGui.Parent do
        task.wait(0.5)
        local fps = math.floor(frames * 2 + 0.5)
        frames = 0
        fpsValue.Text = tostring(fps)

        local fpsColor
        if fps < 25 then
            fpsColor = Color3.fromRGB(255, 60, 60)
        elseif fps < 40 then
            fpsColor = Color3.fromRGB(255, 200, 60)
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
        if ping <= 27 then
            pingColor = Color3.fromRGB(0, 255, 120)
        elseif ping <= 110 then
            pingColor = Color3.fromRGB(255, 200, 60)
        else
            pingColor = Color3.fromRGB(255, 60, 60)
        end
        pingValue.TextColor3 = pingColor
    end
end)

task.spawn(function()
    while statsGui.Parent do
        task.wait(15)
        pcall(function() collectgarbage("collect") end)
    end
end)

task.spawn(function()
    while statsGui.Parent do
        task.wait(2)
        pcall(function()
            for _, top in ipairs(Workspace:GetChildren()) do
                if not isChar(top) then
                    for _, v in ipairs(top:GetDescendants()) do
                        if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam")
                            or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles")
                            or v:IsA("PointLight") or v:IsA("SpotLight") or v:IsA("SurfaceLight") then
                            if not isName(v) then
                                v:Destroy()
                            end
                        end
                    end
                end
            end
        end)
    end
end)

print("✅ fix lag by kudo29001")