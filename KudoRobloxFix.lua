local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Terrain = Workspace:FindFirstChildOfClass("Terrain")
local Camera = Workspace.CurrentCamera
local Stats = game:GetService("Stats")

-- ==================== POPUP 6 GIÂY ====================
local popupGui = Instance.new("ScreenGui")
popupGui.Name = "KudoPopup"
popupGui.ResetOnSpawn = false
popupGui.IgnoreGuiInset = true
popupGui.Parent = playerGui

local popup = Instance.new("Frame")
popup.Size = UDim2.new(0, 240, 0, 44)
popup.Position = UDim2.new(1, 20, 0.35, -22)
popup.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
popup.BackgroundTransparency = 0.05
popup.BorderSizePixel = 0
popup.Parent = popupGui
Instance.new("UICorner", popup).CornerRadius = UDim.new(0, 10)

local popupStroke = Instance.new("UIStroke")
popupStroke.Color = Color3.fromRGB(255, 60, 60)
popupStroke.Thickness = 1.5
popupStroke.Transparency = 0.2
popupStroke.Parent = popup

local popupLabel = Instance.new("TextLabel")
popupLabel.Size = UDim2.new(1, -20, 1, -12)
popupLabel.Position = UDim2.new(0, 10, 0, 6)
popupLabel.BackgroundTransparency = 1
popupLabel.Text = "fix lag by kudo29001⚡"
popupLabel.Font = Enum.Font.GothamBold
popupLabel.TextSize = 14
popupLabel.TextColor3 = Color3.fromRGB(255, 70, 70)
popupLabel.TextXAlignment = Enum.TextXAlignment.Center
popupLabel.Parent = popup

TweenService:Create(popup, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Position = UDim2.new(1, -260, 0.35, -22)
}):Play()

task.delay(6, function()
    pcall(function()
        local out = TweenService:Create(popup, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(1, 20, 0.35, -22),
            BackgroundTransparency = 1
        })
        out:Play()
        TweenService:Create(popupLabel, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
        TweenService:Create(popupStroke, TweenInfo.new(0.4), {Transparency = 1}):Play()
        out.Completed:Wait()
        popupGui:Destroy()
    end)
end)

-- ==================== FFLAG MAX ====================
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

-- ==================== ENGINE CONFIG SONG SONG ====================
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
        Workspace.StreamingTargetRadius = 128
        Workspace.StreamingMinRadius = 64
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

-- ==================== BULK DESTROY ====================
local killTypes = {
    ParticleEmitter = true, Trail = true, Smoke = true, Fire = true,
    Sparkles = true, Beam = true, Highlight = true, SelectionBox = true,
    BoxHandleAdornment = true, PointLight = true, SpotLight = true,
    SurfaceLight = true, ForceField = true, Explosion = true,
    Sound = true, Animation = true, SurfaceAppearance = true,
}

local descendants = Workspace:GetDescendants()
local total = #descendants

for i = 1, total do
    local v = descendants[i]
    local cn = v.ClassName
    if killTypes[cn] then
        if not isName(v) and not isChar(v) then
            pcall(function() v:Destroy() end)
        end
    elseif cn == "BasePart" or cn == "MeshPart" or cn == "UnionOperation" or cn == "Part" then
        pcall(function()
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
            v.CastShadow = false
        end)
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
    if i % 500 == 0 then task.wait() end
end

local scanConn = Workspace.DescendantAdded:Connect(function(v)
    task.defer(function()
        pcall(function()
            local cn = v.ClassName
            if killTypes[cn] then
                if not isName(v) and not isChar(v) then v:Destroy() end
            elseif cn == "BasePart" or cn == "MeshPart" then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
                v.CastShadow = false
            elseif cn == "Decal" or cn == "Texture" then
                v.Transparency = 1
            end
        end)
    end)
end)

-- ==================== DISTANCE CULLING (khoảng cách gần hơn) ====================
-- Ngưỡng: 120 studs. Xa hơn → ẩn hoàn toàn.
local CULL_DIST = 120

local originalTransparency = {}
local culledState = {}

local function setPartVisible(part, visible)
    if visible then
        pcall(function() part.LocalTransparencyModifier = 0 end)
        culledState[part] = false
    else
        if originalTransparency[part] == nil then
            originalTransparency[part] = part.Transparency
        end
        pcall(function() part.LocalTransparencyModifier = 1 end)
        culledState[part] = true
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
                        local dist = (pivot - camPos).Magnitude
                        local visible = dist <= CULL_DIST
                        for _, p in ipairs(top:GetDescendants()) do
                            if p:IsA("BasePart") then
                                local cur = culledState[p]
                                if visible and cur ~= false then
                                    setPartVisible(p, true)
                                elseif not visible and cur ~= true then
                                    setPartVisible(p, false)
                                end
                            end
                        end
                    end
                end
            elseif top:IsA("BasePart") then
                if not isChar(top) then
                    local dist = (top.Position - camPos).Magnitude
                    local visible = dist <= CULL_DIST
                    local cur = culledState[top]
                    if visible and cur ~= false then
                        setPartVisible(top, true)
                    elseif not visible and cur ~= true then
                        setPartVisible(top, false)
                    end
                end
            end
        end
    end)
end)

-- ==================== FPS + PING COUNTER ĐƠN GIẢN ====================
local statsGui = Instance.new("ScreenGui")
statsGui.Name = "KudoStats"
statsGui.ResetOnSpawn = false
statsGui.IgnoreGuiInset = true
statsGui.Parent = playerGui

local fpsLabel = Instance.new("TextLabel")
fpsLabel.Size = UDim2.new(0, 140, 0, 22)
fpsLabel.Position = UDim2.new(1, -150, 1, -52)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Text = "FPS: --"
fpsLabel.Font = Enum.Font.Times
fpsLabel.TextSize = 18
fpsLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
fpsLabel.TextXAlignment = Enum.TextXAlignment.Right
fpsLabel.Parent = statsGui

local pingLabel = Instance.new("TextLabel")
pingLabel.Size = UDim2.new(0, 140, 0, 22)
pingLabel.Position = UDim2.new(1, -150, 1, -28)
pingLabel.BackgroundTransparency = 1
pingLabel.Text = "Ping: --"
pingLabel.Font = Enum.Font.Times
pingLabel.TextSize = 18
pingLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
pingLabel.TextXAlignment = Enum.TextXAlignment.Right
pingLabel.Parent = statsGui

local frames = 0
task.spawn(function()
    RunService.RenderStepped:Connect(function() frames = frames + 1 end)
    while statsGui.Parent do
        task.wait(0.5)
        local fps = math.floor(frames * 2 + 0.5)
        frames = 0
        fpsLabel.Text = "FPS: " .. fps

        local ping = 0
        pcall(function()
            ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        end)
        pingLabel.Text = "Ping: " .. ping .. "ms"
    end
end)

-- GC ngầm
task.spawn(function()
    while statsGui.Parent do
        task.wait(20)
        pcall(function() collectgarbage("collect") end)
    end
end)

-- Dẹp particle mới
task.spawn(function()
    while statsGui.Parent do
        task.wait(3)
        pcall(function()
            for _, top in ipairs(Workspace:GetChildren()) do
                if not isChar(top) then
                    for _, v in ipairs(top:GetDescendants()) do
                        if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam")
                            or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
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