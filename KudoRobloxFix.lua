local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Stats = game:GetService("Stats")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local Terrain = Workspace:FindFirstChildOfClass("Terrain")
local Camera = Workspace.CurrentCamera
local VirtualUser = game:GetService("VirtualUser")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local uiParent = PlayerGui
pcall(function()
    if gethui then uiParent = gethui() end
end)

local function destroyOldUI()
    local namesToKill = {"kudo", "fixlag", "mailbox", "sender", "kudostats", "kudotoggle", "kudopopup", "kudoloader"}
    local structMarkers = {"BorderHolder", "Runner", "RunnerDot", "KudoLoaderV2", "KudoBackdrop"}
    for _, container in ipairs({PlayerGui, CoreGui}) do
        pcall(function()
            for _, v in ipairs(container:GetChildren()) do
                if v:IsA("ScreenGui") then
                    local n = v.Name:lower()
                    local kill = false
                    for _, key in ipairs(namesToKill) do
                        if n:find(key) then kill = true break end
                    end
                    if not kill then
                        for _, m in ipairs(structMarkers) do
                            if v:FindFirstChild(m, true) then kill = true break end
                        end
                    end
                    if kill then pcall(function() v:Destroy() end) end
                end
            end
        end)
    end
end

for i = 1, 4 do
    destroyOldUI()
    task.wait(0.02)
end

local cleanStart = tick()
task.spawn(function()
    while tick() - cleanStart < 2.5 do
        destroyOldUI()
        task.wait(0.1)
    end
end)

local fflagTable = {
    ["DFIntTaskSchedulerTargetFps"] = "9999",
    ["FIntTaskSchedulerAutoThreadLimit"] = "6",
    ["FIntTaskSchedulerAsyncTasksMinimumThreadCount"] = "2",
    ["FIntTaskSchedulerMaxNumOfJobs"] = "86",
    ["FIntTaskSchedulerThreadMin"] = "1",

    ["DFFlagBrowserTrackerIdTelemetryEnabled"] = "False",
    ["DFFlagPreloadAsyncSupportTexturePack"] = "True",
    ["DFFlagTextureQualityOverrideEnabled"] = "True",
    ["DFFlagVideoCaptureServiceEnabled"] = "False",
    ["DFFlagSampleAndRefreshRakPing"] = "True",
    ["DFFlagRakNetUseSlidingWindow4"] = "True",
    ["DFFlagCoreScriptTelemetry2"] = "False",
    ["DFFlagEnableSoundPreloading"] = "True",
    ["DFFlagOptimizePartsInPart"] = "True",
    ["DFFlagDisableDPIScale"] = "True",
    ["DFFlagDebugPerfMode"] = "True",

    ["DFIntRaknetBandwidthInfluxHundredthsPercentageV2"] = "10000",
    ["DFIntRakNetClockDriftAdjustmentPerPingMillisecond"] = "100",
    ["DFIntRaknetBandwidthPingSendEveryXSeconds"] = "1",
    ["DFIntRakNetNakResendDelayRttPercent"] = "50",
    ["DFIntRakNetNakResendDelayMsMax"] = "100",
    ["DFIntRakNetNakResendDelayMs"] = "10",
    ["DFIntRakNetResendRttMultiple"] = "1",
    ["DFIntRakNetSelectTimeoutMs"] = "1",
    ["DFIntRakNetLoopMs"] = "1",
    ["DFIntRakNetMinAckGrowthPercent"] = "0",
    ["DFIntRakNetMtuValue1InBytes"] = "1280",
    ["DFIntRakNetMtuValue2InBytes"] = "1240",
    ["DFIntRakNetMtuValue3InBytes"] = "1200",
    ["DFIntConnectionMTUSize"] = "1260",

    ["DFIntMaxReceiveToDeserializeLatencyMilliseconds"] = "15",
    ["DFIntNetworkInDeserializeLimitGameplayMsClient"] = "6",
    ["DFIntNetworkInProcessLimitGameplayMsClient"] = "6",
    ["DFIntClientPacketHealthyAllocationPercent"] = "20",
    ["DFIntClientPacketMaxFrameMicroseconds"] = "200",
    ["DFIntClientPacketExcessMicroseconds"] = "1000",
    ["DFIntClientPacketMinMicroseconds"] = "1",
    ["DFIntClientPacketMaxDelayMs"] = "11",
    ["DFIntMaxWaitTimeBeforeForcePacketProcessMS"] = "1",
    ["DFIntMaxProcessPacketsStepsPerCyclic"] = "5000",
    ["DFIntMaxProcessPacketsStepsAccumulated"] = "0",
    ["DFIntMaxProcessPacketsJobScaling"] = "10000",
    ["DFIntLargePacketQueueSizeCutoffMB"] = "1000",
    ["DFIntDataSenderRate"] = "1000",
    ["DFIntDataSenderMaxBandwidthBps"] = "2147483647",
    ["DFIntDataSenderMaxJoinBandwidthBps"] = "2147483647",
    ["DFIntS2PhysicsSenderRate"] = "1000",
    ["DFIntS2NumPhysicsPacketsPerStep"] = "100",
    ["DFIntPhysicsSenderMaxBandwidthBps"] = "2147483647",
    ["DFIntPhysicsSenderMaxBandwidthBpsScaling"] = "1000",
    ["FIntPGSAngularDampingPermilPersecond"] = "0",
    ["DFFlagPhysicsSkipNonRealTimeHumanoidForceCalc2"] = "True",

    ["DFIntSignalRHubConnectionHeartbeatTimerRateMs"] = "1000",
    ["DFIntSignalRHubConnectionBaseRetryTimeMs"] = "100",
    ["DFIntSignalRCoreKeepAlivePingPeriodMs"] = "250",
    ["DFIntSignalRCoreServerTimeoutMs"] = "11100",
    ["DFIntSignalRCoreTimerMs"] = "750",
    ["DFIntSignalRCoreRpcQueueSize"] = "256",

    ["DFIntAnimationLodFacsVisibilityDenominator"] = "0",
    ["DFIntAnimationLodFacsDistanceMin"] = "0",
    ["DFIntAnimationLodFacsDistanceMax"] = "0",
    ["DFIntDebugFRMQualityLevelOverride"] = "1",
    ["DFIntDebugDynamicRenderKiloPixels"] = "1100",
    ["DFIntDebugRestrictGCDistance"] = "1",

    ["DFIntWaitOnUpdateNetworkLoopEndedMS"] = "100",
    ["DFIntWaitOnRecvFromLoopEndedMS"] = "100",

    ["FIntRenderMaxShadowAtlasUsageBeforeDownscale"] = "80",
    ["FIntRenderShadowMapDepthCacheMemLimit"] = "192",
    ["FIntUITextureMaxRenderTextureSize"] = "1024",
    ["FIntRakNetResendBufferArrayLength"] = "128",
    ["FIntTerrainOTAMaxTextureSize"] = "1024",
    ["FIntOcclusionWorkerThreadCount"] = "5",
    ["FIntDefaultMeshCacheSizeMB"] = "256",
    ["FIntRobloxGuiBlurIntensity"] = "0",
    ["FIntTerrainArraySliceSize"] = "0",
    ["FIntDebugForceMSAASamples"] = "1",
    ["FIntRenderShadowmapBias"] = "0",
    ["FIntFRMMaxGrassDistance"] = "0",
    ["FIntFRMMinGrassDistance"] = "0",
    ["FIntGrassMovementReducedMotionFactor"] = "0",
    ["FIntDebugTextureManagerSkipMips"] = "7",
    ["FIntPerformanceTelemetryQueueProcessLimit"] = "0",
    ["FIntTelemetryProfilerFrequency"] = "0",
    ["FIntRenderLocalLightFadeInMs"] = "0",
    ["FIntReportDeviceInfoRollout"] = "0",

    ["FFlagRenderAllocateShadowMapResourcesOnDemand"] = "True",
    ["FFlagSpecifyNetworkReplicatorScopeForItems"] = "True",
    ["FFlagTaskSchedulerLimitTargetFpsTo2402"] = "False",
    ["FFlagHandleAltEnterFullscreenManually"] = "False",
    ["FFlagGameBasicSettingsFramerateCap5"] = "False",
    ["FFlagSpecifyNetworkReplicatorScope"] = "True",
    ["FFlagSendRenderFidelityTelemetry2"] = "False",
    ["FFlagRenderGpuTextureCompressor"] = "True",
    ["FFlagBaseThreadPoolUseRuntime2"] = "True",
    ["FFlagCacheTextBoundsInGuiText"] = "True",
    ["FFlagEnableTelemetryService1"] = "False",
    ["FFlagDebugGraphicsPreferD3D11"] = "True",
    ["FFlagPerfDataOnTelemetryV2"] = "False",
    ["FFlagOpenTelemetryEnabled2"] = "False",
    ["FFlagRbxStorageUseMemCache"] = "True",
    ["FFlagDebugForceGenerateHSR"] = "True",
    ["FFlagRenderInitShadowmaps"] = "True",
    ["FFlagFastGPULightCulling3"] = "True",
    ["FFlagDebugSkyGray"] = "True",
    ["FFlagDebugRenderingSetDeterministic"] = "True",
    ["FLogNetwork"] = "7",

    ["DFIntTextureQualityOverride"] = "0",
    ["FFlagTextureQualityOverride"] = "True",
    ["FFlagDisableTextures"] = "True",
    ["FFlagDisableSurfaceAppearance"] = "True",
    ["FFlagDisableDecals"] = "True",
    ["FFlagDisableMaterialTextures"] = "True",
    ["FFlagDisableBumpMap"] = "True",
    ["FFlagDisableNormalMap"] = "True",
    ["FFlagDisableSpecularMap"] = "True",

    ["DFFlagDisableSSAO"] = "True",
    ["FFlagDisableSSAO"] = "True",
    ["FFlagDisablePostFx"] = "True",
    ["FFlagDisableBloom"] = "True",
    ["FFlagDisableDepthOfField"] = "True",
    ["FFlagDisableSunRays"] = "True",
    ["FFlagDisableAntiAliasing"] = "True",
    ["FFlagDisableMotionBlur"] = "True",
    ["FFlagDisableHDR"] = "True",
    ["FFlagDisableToneMapping"] = "True",
    ["FFlagDisableMultiSample"] = "True",

    ["FFlagRenderShadowIntensity"] = "0",
    ["FFlagRenderShadowIntensityOverride"] = "True",
    ["FFlagDisableShadows"] = "True",
    ["FFlagDisableAtmosphere"] = "True",
    ["FFlagDisableSky"] = "True",
    ["FFlagDisableFog"] = "True",
    ["FFlagDisableTerrainDecoration"] = "True",
    ["FFlagDisableGrass"] = "True",

    ["DFIntCSGLevelOfDetailSwitchingDistance"] = "0",
    ["FFlagDisableLODTransitions"] = "True",
    ["FFlagForceLOD0"] = "True",
    ["DFIntLODBias"] = "8",
    ["DFIntMeshQualityOverride"] = "0",

    ["DFFlagDebugRenderForceTechnologyVoxel"] = "True",
    ["FFlagDebugPauseVoxelizer"] = "True",
    ["DFIntSolverSpringDamping"] = "0",
    ["DFIntMaxSimultaneousPhysicsJobs"] = "1",
    ["DFIntPhysicsStepPerFrame"] = "1",
    ["DFIntMaximumCollisionIterations"] = "1",
    ["DFIntSolverConvergenceIterations"] = "1",
    ["DFIntSolverIterations"] = "1",
    ["FFlagDisableFluidForces"] = "True",
    ["FFlagDisableAeroForces"] = "True",
    ["FFlagSimplifyPhysics"] = "True",
    ["DFIntPhysicsQualityOverride"] = "0",

    ["DFIntFrameBufferPoolSize"] = "1",
    ["DFIntDebugEngineOptimizationLevel"] = "3",
    ["DFFlagDisableGPUOcclusion"] = "True",
    ["FFlagRenderDisableForwardLights"] = "True",
    ["DFIntNumberOfRenderPasses"] = "1",
    ["DFIntMaxConcurrentRenderPasses"] = "1",

    ["DFIntMaxDataPacketsPerFrame"] = "1",
    ["DFIntMaxDataPacketsPerSecond"] = "60",
    ["FFlagOptimizeNetworkSend"] = "True",
    ["DFIntNetworkClusterPacketCache"] = "1",

    ["FFlagDisableTerrain"] = "True",
    ["FFlagDisableWater"] = "True",
    ["FFlagDisableSkybox"] = "True",
    ["FFlagDisableParticles"] = "True",
    ["FFlagDisableTrails"] = "True",
    ["FFlagDisableBeams"] = "True",
    ["FFlagDisableHighlight"] = "True",
    ["DFIntMaxVisibleParticles"] = "0",
    ["DFIntMaxVisibleBeams"] = "0",
    ["DFIntMaxVisibleTrails"] = "0",

    ["FFlagDisableReflections"] = "True",
    ["FFlagDisableWaterReflections"] = "True",
    ["FFlagDisableGlassReflections"] = "True",
    ["DFIntReflectionQualityOverride"] = "0",

    ["DFIntLightingQualityOverride"] = "0",
    ["DFFlagLightingQualityOverrideEnabled"] = "True",
    ["FFlagDisablePointLights"] = "True",
    ["FFlagDisableSpotLights"] = "True",
    ["FFlagDisableSurfaceLights"] = "True",
    ["DFIntMaxLights"] = "0",
    ["FFlagDisableGlobalShadows"] = "True",
    ["FFlagDisableLocalShadows"] = "True",

    ["DFIntAnimationQualityOverride"] = "0",
    ["FFlagDisableAnimationBlending"] = "True",
    ["DFIntMaxAnimationTracks"] = "1",
    ["FFlagSimplifyAnimations"] = "True",

    ["DFIntMaterialQualityOverride"] = "0",
    ["FFlagDisableMaterialShaders"] = "True",
    ["FFlagForceSimpleMaterial"] = "True",

    ["FFlagDisableParticleLighting"] = "True",
    ["FFlagDisableParticleShadows"] = "True",
    ["FFlagDisableParticleReflections"] = "True",
    ["DFIntParticleQualityOverride"] = "0",

    ["FFlagDisableClouds"] = "True",
    ["FFlagDisableStars"] = "True",
    ["FFlagDisableMoon"] = "True",
    ["FFlagDisableSun"] = "True",
    ["FFlagDisableCelestialBodies"] = "True",
    ["DFIntSolverMaxIterations"] = "1",
    ["FFlagDisableSkyboxTextures"] = "True",
    ["FFlagDisableCelestialBodyRendering"] = "True",
    ["FFlagDisableStarfieldRendering"] = "True",
    ["FFlagDisableSunRendering"] = "True",
    ["FFlagDisableMoonRendering"] = "True",

    ["DFIntMaxActiveSounds"] = "8",
    ["DFIntMaxSoundChannels"] = "8",
    ["FFlagDisableSoundOcclusion"] = "True",
    ["DFIntSoundRollOffQuality"] = "0",
}

for key, value in pairs(fflagTable) do
    pcall(setfflag, key, value)
end

pcall(function()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01
    settings().Rendering.AnimationWeightedBlendFix = Enum.AnimationWeightedBlendFix.Disabled
    settings().Rendering.EagerBulkExecution = true
end)

pcall(function()
    if Camera then
        Camera.FieldOfView = 85
    end
    Workspace.StreamingEnabled = true
    Workspace.StreamingTargetRadius = 24
    Workspace.StreamingMinRadius = 12
end)

local SKY_GRAY = Color3.fromRGB(128, 128, 128)

local function applySky()
    pcall(function()
        for _, v in ipairs(Lighting:GetChildren()) do
            if v:IsA("PostEffect") or v:IsA("Sky") or v:IsA("Atmosphere") or v:IsA("Clouds") then
                pcall(function() v:Destroy() end)
            end
        end
        local sky = Instance.new("Sky")
        sky.SkyboxBk = ""
        sky.SkyboxDn = ""
        sky.SkyboxFt = ""
        sky.SkyboxLf = ""
        sky.SkyboxRt = ""
        sky.SkyboxUp = ""
        sky.SunTextureId = ""
        sky.MoonTextureId = ""
        sky.StarCount = 0
        sky.CelestialBodiesShown = false
        sky.Parent = Lighting
        Lighting.GlobalShadows = false
        Lighting.Brightness = 1.6
        Lighting.ClockTime = 14
        Lighting.GeographicLatitude = 0
        Lighting.Ambient = SKY_GRAY
        Lighting.OutdoorAmbient = SKY_GRAY
        Lighting.EnvironmentDiffuseScale = 0
        Lighting.EnvironmentSpecularScale = 0
        Lighting.ExposureCompensation = 0
        Lighting.ShadowSoftness = 0
        Lighting.FogColor = SKY_GRAY
        Lighting.FogStart = 0
        Lighting.FogEnd = 5000
        Lighting.ColorShift_Top = SKY_GRAY
        Lighting.ColorShift_Bottom = SKY_GRAY
    end)
end

applySky()

task.spawn(function()
    while true do
        task.wait(3)
        applySky()
    end
end)

pcall(function()
    if Terrain then
        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveSpeed = 0
        Terrain.WaterReflectance = 0
        Terrain.WaterTransparency = 0
        Terrain.WaterColor = Color3.fromRGB(0, 100, 200)
        Terrain.Decoration = false
    end
end)

task.spawn(function()
    while true do
        task.wait(120)
        pcall(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end
end)

pcall(function()
    LocalPlayer.Idled:Connect(function()
        pcall(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end)
end)

local charModels = {}
local function watchChar(plr)
    if plr.Character then charModels[plr.Character] = true end
    plr.CharacterAdded:Connect(function(c) charModels[c] = true end)
end
for _, plr in ipairs(Players:GetPlayers()) do watchChar(plr) end
Players.PlayerAdded:Connect(watchChar)
Players.PlayerRemoving:Connect(function(plr)
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

local killTypes = {
    ParticleEmitter = true, Trail = true, Smoke = true, Fire = true,
    Sparkles = true, Beam = true, Highlight = true, SelectionBox = true,
    BoxHandleAdornment = true, PointLight = true, SpotLight = true,
    SurfaceLight = true, ForceField = true, Explosion = true,
    Animation = true, SurfaceAppearance = true,
    Decal = true, Texture = true, SpecialMesh = true,
    Cloth = true, WrapLayer = true, WrapTarget = true,
    Atmosphere = true, Clouds = true,
    DepthOfFieldEffect = true, BloomEffect = true, BlurEffect = true,
    ColorCorrectionEffect = true, SunRaysEffect = true,
}

local function flattenWater(v)
    pcall(function()
        v.WaterColor = Color3.fromRGB(0, 100, 200)
        v.WaterTransparency = 0
        v.WaterReflectance = 0
        v.WaterWaveSize = 0
        v.WaterWaveSpeed = 0
    end)
end

local function handleObject(v)
    if isName(v) or isChar(v) then return end
    local cn = v.ClassName
    if killTypes[cn] then
        pcall(function() v:Destroy() end)
    elseif cn == "Part" or cn == "MeshPart" or cn == "UnionOperation" or cn == "WedgePart" then
        pcall(function()
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
            v.CastShadow = false
            if v:IsA("MeshPart") then
                v.RenderFidelity = Enum.RenderFidelity.Performance
                v.TextureID = ""
            end
        end)
    elseif cn == "Model" then
        pcall(function()
            v.LevelOfDetail = Enum.ModelLevelOfDetail.StreamingMesh
        end)
    end
end

task.spawn(function()
    while true do
        task.wait(0.5)
        pcall(function()
            if not Terrain then return end
            flattenWater(Terrain)
            for _, v in ipairs(Terrain:GetChildren()) do
                if v:IsA("Water") then
                    flattenWater(v)
                end
            end
        end)
    end
end)

local scanFinished = false

task.spawn(function()
    local descendants = Workspace:GetDescendants()
    local total = #descendants
    if total == 0 then scanFinished = true return end
    local BATCH_SIZE = 600
    local MAX_CONCURRENT = 40
    local batches = {}
    local current = {}
    for i = 1, total do
        current[#current + 1] = descendants[i]
        if #current >= BATCH_SIZE then
            batches[#batches + 1] = current
            current = {}
        end
    end
    if #current > 0 then batches[#batches + 1] = current end
    local running = 0
    local index = 1
    while true do
        if running < MAX_CONCURRENT and index <= #batches then
            local batch = batches[index]
            index = index + 1
            running = running + 1
            task.spawn(function()
                for _, v in ipairs(batch) do
                    pcall(handleObject, v)
                end
                running = running - 1
            end)
        elseif index > #batches and running == 0 then
            break
        else
            RunService.Heartbeat:Wait()
        end
    end
    scanFinished = true
end)

Workspace.DescendantAdded:Connect(function(v)
    task.defer(function()
        pcall(handleObject, v)
    end)
end)

local CULL_DIST_SQ = 32 * 32
local culled = {}

task.spawn(function()
    while true do
        task.wait(0.4)
        pcall(function()
            if not Camera then return end
            local camPos = Camera.CFrame.Position
            for _, v in ipairs(Workspace:GetChildren()) do
                if v:IsA("BasePart") and not isChar(v) then
                    if not v:FindFirstChildOfClass("Humanoid") and not v:FindFirstChildOfClass("BillboardGui") then
                        local pos = v.Position
                        if pos.Y >= camPos.Y - 3 then
                            local dx, dy, dz = pos.X - camPos.X, pos.Y - camPos.Y, pos.Z - camPos.Z
                            local shouldHide = (dx*dx + dy*dy + dz*dz) > CULL_DIST_SQ
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
            end
        end)
    end
end)

task.spawn(function()
    while true do
        task.wait(3)
        pcall(function()
            for _, v in ipairs(Lighting:GetDescendants()) do
                if v:IsA("PointLight") or v:IsA("SpotLight") or v:IsA("SurfaceLight") then
                    if v.Enabled then v.Enabled = false end
                end
            end
        end)
    end
end)

task.spawn(function()
    while true do
        task.wait(40)
        pcall(function()
            collectgarbage("collect")
        end)
    end
end)

task.spawn(function()
    while true do
        task.wait(3)
        pcall(function()
            for _, v in ipairs(Workspace:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                    if v.Enabled then v.Enabled = false end
                end
            end
        end)
    end
end)

task.spawn(function()
    while true do
        task.wait(6)
        pcall(function()
            for _, v in ipairs(Workspace:GetDescendants()) do
                if v:IsA("Decal") or v:IsA("Texture") then
                    pcall(function() v:Destroy() end)
                elseif v:IsA("MeshPart") and v.TextureID ~= "" then
                    pcall(function() v.TextureID = "" end)
                end
            end
        end)
    end
end)

local sg = Instance.new("ScreenGui")
sg.Name = "KudoLoaderV2"
sg.ResetOnSpawn = false
sg.IgnoreGuiInset = true
sg.DisplayOrder = 2147483647
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.Parent = uiParent

local backdrop = Instance.new("Frame")
backdrop.Name = "KudoBackdrop"
backdrop.Size = UDim2.new(1, 0, 1, 0)
backdrop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
backdrop.BackgroundTransparency = 0.5
backdrop.BorderSizePixel = 0
backdrop.ZIndex = 999
backdrop.Parent = sg

local popup = Instance.new("Frame")
popup.Size = UDim2.new(0, 320, 0, 90)
popup.Position = UDim2.new(0.5, -160, 0.5, -45)
popup.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
popup.BorderSizePixel = 0
popup.ZIndex = 1000
popup.Parent = sg
Instance.new("UICorner", popup).CornerRadius = UDim.new(0, 8)

local borderStroke = Instance.new("UIStroke")
borderStroke.Color = Color3.fromRGB(80, 30, 30)
borderStroke.Thickness = 1
borderStroke.Parent = popup

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -30, 0, 20)
title.Position = UDim2.new(0, 15, 0, 14)
title.BackgroundTransparency = 1
title.Text = "fix lag + anti-afk"
title.Font = Enum.Font.GothamMedium
title.TextSize = 15
title.TextColor3 = Color3.fromRGB(240, 240, 240)
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 1010
title.Parent = popup

local sub = Instance.new("TextLabel")
sub.Size = UDim2.new(1, -30, 0, 14)
sub.Position = UDim2.new(0, 15, 0, 34)
sub.BackgroundTransparency = 1
sub.Text = "made by @kudo29001.      v1.1"
sub.Font = Enum.Font.Gotham
sub.TextSize = 10
sub.TextColor3 = Color3.fromRGB(140, 140, 140)
sub.TextXAlignment = Enum.TextXAlignment.Left
sub.ZIndex = 1010
sub.Parent = popup

local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(1, -30, 0, 5)
barBg.Position = UDim2.new(0, 15, 0, 60)
barBg.BackgroundColor3 = Color3.fromRGB(40, 25, 25)
barBg.BorderSizePixel = 0
barBg.ZIndex = 1010
barBg.Parent = popup
Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)

local barBgStroke = Instance.new("UIStroke")
barBgStroke.Color = Color3.fromRGB(180, 50, 50)
barBgStroke.Thickness = 1
barBgStroke.Transparency = 0.5
barBgStroke.Parent = barBg

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
barFill.BorderSizePixel = 0
barFill.ZIndex = 1011
barFill.Parent = barBg
Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)

local barGlow = Instance.new("Frame")
barGlow.Size = UDim2.new(1, 4, 1, 4)
barGlow.Position = UDim2.new(0, -2, 0, -2)
barGlow.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
barGlow.BackgroundTransparency = 0.6
barGlow.BorderSizePixel = 0
barGlow.ZIndex = 1009
barGlow.Parent = barFill
Instance.new("UICorner", barGlow).CornerRadius = UDim.new(1, 0)

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -100, 0, 14)
statusLabel.Position = UDim2.new(0, 15, 0, 70)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "optimizing..."
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 10
statusLabel.TextColor3 = Color3.fromRGB(160, 120, 120)
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.ZIndex = 1010
statusLabel.Parent = popup

local percentL = Instance.new("TextLabel")
percentL.Size = UDim2.new(0, 60, 0, 14)
percentL.Position = UDim2.new(1, -75, 0, 70)
percentL.BackgroundTransparency = 1
percentL.Text = "0%"
percentL.Font = Enum.Font.GothamMedium
percentL.TextSize = 10
percentL.TextColor3 = Color3.fromRGB(255, 130, 130)
percentL.TextXAlignment = Enum.TextXAlignment.Right
percentL.ZIndex = 1010
percentL.Parent = popup

task.spawn(function()
    while barBg.Parent do
        local pulse = math.abs(math.sin(tick() * 3))
        barBgStroke.Transparency = 0.3 + pulse * 0.4
        barGlow.BackgroundTransparency = 0.5 + pulse * 0.3
        task.wait(0.05)
    end
end)

task.spawn(function()
    local startT = tick()
    local currentP = 0
    while true do
        if scanFinished then
            currentP = currentP + (100 - currentP) * 0.15
            if currentP > 99.5 then
                currentP = 100
            end
        else
            local elapsed = tick() - startT
            local target = math.min(elapsed / 1.5 * 95, 95)
            currentP = currentP + (target - currentP) * 0.08
        end
        barFill.Size = UDim2.new(currentP / 100, 0, 1, 0)
        percentL.Text = math.floor(currentP) .. "%"
        if currentP >= 100 then
            statusLabel.Text = "done"
            statusLabel.TextColor3 = Color3.fromRGB(120, 220, 140)
            barFill.BackgroundColor3 = Color3.fromRGB(120, 220, 140)
            barGlow.BackgroundColor3 = Color3.fromRGB(120, 220, 140)
            barBgStroke.Color = Color3.fromRGB(120, 220, 140)
            break
        end
        task.wait(0.03)
    end
end)

task.spawn(function()
    while not scanFinished do
        task.wait(0.1)
    end
    task.wait(1.2)
    TweenService:Create(backdrop, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(popup, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(title, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(sub, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(percentL, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(statusLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(barBg, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(barFill, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(barGlow, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(barBgStroke, TweenInfo.new(0.5), {Transparency = 1}):Play()
    TweenService:Create(borderStroke, TweenInfo.new(0.5), {Transparency = 1}):Play()
    task.wait(0.6)
    sg:Destroy()
end)

local statsGui = Instance.new("ScreenGui")
statsGui.Name = "KudoStats"
statsGui.ResetOnSpawn = false
statsGui.IgnoreGuiInset = true
statsGui.DisplayOrder = 2147483647
statsGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
statsGui.Parent = uiParent

local box = Instance.new("Frame")
box.Size = UDim2.new(0, 175, 0, 108)
box.Position = UDim2.new(1, -185, 1, -118)
box.AnchorPoint = Vector2.new(1, 0)
box.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
box.BackgroundTransparency = 0.3
box.BorderSizePixel = 0
box.Active = false
box.Parent = statsGui
Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)

local bxStroke = Instance.new("UIStroke")
bxStroke.Color = Color3.fromRGB(255, 60, 60)
bxStroke.Thickness = 1
bxStroke.Transparency = 0.5
bxStroke.Parent = box

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 16)
header.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
header.BackgroundTransparency = 0.7
header.BorderSizePixel = 0
header.Parent = box
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 8)

local function mkLabel(t, y)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(0, 45, 0, 18)
    l.Position = UDim2.new(0, 12, 0, y)
    l.BackgroundTransparency = 1
    l.Text = t
    l.Font = Enum.Font.GothamBold
    l.TextSize = 11
    l.TextColor3 = Color3.fromRGB(180, 180, 180)
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = box
end

local function mkValue(y)
    local v = Instance.new("TextLabel")
    v.Size = UDim2.new(0, 80, 0, 18)
    v.Position = UDim2.new(1, -92, 0, y)
    v.BackgroundTransparency = 1
    v.Text = "--"
    v.Font = Enum.Font.GothamBold
    v.TextSize = 13
    v.TextColor3 = Color3.fromRGB(0, 255, 120)
    v.TextXAlignment = Enum.TextXAlignment.Right
    v.Parent = box
    return v
end

mkLabel("FPS", 24)
local fpsV = mkValue(24)
mkLabel("PING", 44)
local pingV = mkValue(44)
mkLabel("TIME", 64)
local timeV = mkValue(64)
timeV.TextColor3 = Color3.fromRGB(255, 100, 100)
timeV.Text = "00:00"

local credit = Instance.new("TextLabel")
credit.Size = UDim2.new(1, -10, 0, 12)
credit.Position = UDim2.new(0, 5, 1, -14)
credit.BackgroundTransparency = 1
credit.Text = "@script by kudo29001"
credit.Font = Enum.Font.GothamBold
credit.TextSize = 10
credit.TextColor3 = Color3.fromRGB(255, 100, 100)
credit.TextTransparency = 0.3
credit.TextXAlignment = Enum.TextXAlignment.Center
credit.Parent = box

local closeB = Instance.new("TextButton")
closeB.Size = UDim2.new(0, 24, 0, 24)
closeB.Position = UDim2.new(1, -28, 0, -4)
closeB.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeB.Text = "x"
closeB.Font = Enum.Font.GothamBold
closeB.TextSize = 14
closeB.TextColor3 = Color3.new(1, 1, 1)
closeB.BorderSizePixel = 0
closeB.ZIndex = 10
closeB.Parent = box
Instance.new("UICorner", closeB).CornerRadius = UDim.new(1, 0)

local hideB = Instance.new("TextButton")
hideB.Size = UDim2.new(0, 24, 0, 24)
hideB.Position = UDim2.new(1, -56, 0, -4)
hideB.BackgroundColor3 = Color3.fromRGB(255, 150, 50)
hideB.Text = "-"
hideB.Font = Enum.Font.GothamBold
hideB.TextSize = 16
hideB.TextColor3 = Color3.new(1, 1, 1)
hideB.BorderSizePixel = 0
hideB.ZIndex = 10
hideB.Parent = box
Instance.new("UICorner", hideB).CornerRadius = UDim.new(1, 0)

local lockB = Instance.new("TextButton")
lockB.Size = UDim2.new(0, 24, 0, 24)
lockB.Position = UDim2.new(1, -84, 0, -4)
lockB.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
lockB.Text = "🔓"
lockB.Font = Enum.Font.GothamBold
lockB.TextSize = 12
lockB.TextColor3 = Color3.new(1, 1, 1)
lockB.BorderSizePixel = 0
lockB.ZIndex = 10
lockB.Parent = box
Instance.new("UICorner", lockB).CornerRadius = UDim.new(1, 0)

local opacityB = Instance.new("TextButton")
opacityB.Size = UDim2.new(0, 24, 0, 24)
opacityB.Position = UDim2.new(1, -112, 0, -4)
opacityB.BackgroundColor3 = Color3.fromRGB(80, 100, 200)
opacityB.Text = "◐"
opacityB.Font = Enum.Font.GothamBold
opacityB.TextSize = 14
opacityB.TextColor3 = Color3.new(1, 1, 1)
opacityB.BorderSizePixel = 0
opacityB.ZIndex = 10
opacityB.Parent = box
Instance.new("UICorner", opacityB).CornerRadius = UDim.new(1, 0)

local locked = false
lockB.MouseButton1Click:Connect(function()
    locked = not locked
    if locked then
        lockB.BackgroundColor3 = Color3.fromRGB(80, 200, 100)
        lockB.Text = "🔒"
    else
        lockB.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
        lockB.Text = "🔓"
    end
end)

local sliderPanel = Instance.new("Frame")
sliderPanel.Name = "OpacitySlider"
sliderPanel.Size = UDim2.new(1, -20, 0, 30)
sliderPanel.Position = UDim2.new(0, 10, 1, -34)
sliderPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
sliderPanel.BorderSizePixel = 0
sliderPanel.Visible = false
sliderPanel.ZIndex = 20
sliderPanel.Parent = box
Instance.new("UICorner", sliderPanel).CornerRadius = UDim.new(0, 6)

local sliderBg = Instance.new("Frame")
sliderBg.Size = UDim2.new(1, -20, 0, 6)
sliderBg.Position = UDim2.new(0, 10, 0.5, -3)
sliderBg.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
sliderBg.BorderSizePixel = 0
sliderBg.ZIndex = 21
sliderBg.Parent = sliderPanel
Instance.new("UICorner", sliderBg).CornerRadius = UDim.new(1, 0)

local sliderFill = Instance.new("Frame")
sliderFill.Size = UDim2.new(0.5, 0, 1, 0)
sliderFill.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
sliderFill.BorderSizePixel = 0
sliderFill.ZIndex = 22
sliderFill.Parent = sliderBg
Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(1, 0)

local sliderKnob = Instance.new("TextButton")
sliderKnob.Size = UDim2.new(0, 16, 0, 16)
sliderKnob.Position = UDim2.new(0.5, -8, 0.5, -8)
sliderKnob.BackgroundColor3 = Color3.fromRGB(150, 200, 255)
sliderKnob.Text = ""
sliderKnob.BorderSizePixel = 0
sliderKnob.ZIndex = 23
sliderKnob.Parent = sliderBg
Instance.new("UICorner", sliderKnob).CornerRadius = UDim.new(1, 0)

local function applyOpacity(value)
    local transparency = 1 - value
    box.BackgroundTransparency = math.clamp(0.1 + transparency * 0.85, 0, 1)
    header.BackgroundTransparency = math.clamp(0.4 + transparency * 0.5, 0, 1)
    bxStroke.Transparency = math.clamp(0.4 + transparency * 0.55, 0, 1)
    for _, child in ipairs(box:GetDescendants()) do
        local skip = false
        local parent = child.Parent
        while parent do
            if parent == sliderPanel then
                skip = true
                break
            end
            if parent == box then break end
            parent = parent.Parent
        end
        if not skip then
            if child:IsA("TextLabel") then
                child.TextTransparency = math.clamp(transparency * 0.9, 0, 1)
            elseif child:IsA("TextButton") then
                child.BackgroundTransparency = math.clamp(transparency * 0.5, 0, 0.7)
                child.TextTransparency = math.clamp(transparency * 0.7, 0, 0.8)
            end
        end
    end
end

local draggingSlider = false
sliderKnob.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingSlider = true
    end
end)

UserInputService.InputChanged:Connect(function(i)
    if draggingSlider then
        local mouseX = i.Position.X
        local bgAbsPos = sliderBg.AbsolutePosition.X
        local bgAbsSize = sliderBg.AbsoluteSize.X
        local percent = math.clamp((mouseX - bgAbsPos) / bgAbsSize, 0, 1)
        sliderFill.Size = UDim2.new(percent, 0, 1, 0)
        sliderKnob.Position = UDim2.new(percent, -8, 0.5, -8)
        applyOpacity(percent)
    end
end)

UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingSlider = false
    end
end)

local sliderVisible = false
opacityB.MouseButton1Click:Connect(function()
    sliderVisible = not sliderVisible
    sliderPanel.Visible = sliderVisible
end)

local showSg = Instance.new("ScreenGui")
showSg.Name = "KudoToggle"
showSg.ResetOnSpawn = false
showSg.IgnoreGuiInset = true
showSg.DisplayOrder = 2147483647
showSg.Parent = uiParent

local showB = Instance.new("TextButton")
showB.Size = UDim2.new(0, 44, 0, 44)
showB.Position = UDim2.new(1, -54, 1, -54)
showB.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
showB.Text = "⚡"
showB.Font = Enum.Font.GothamBold
showB.TextSize = 22
showB.TextColor3 = Color3.new(1, 1, 1)
showB.BorderSizePixel = 0
showB.Visible = false
showB.Parent = showSg
Instance.new("UICorner", showB).CornerRadius = UDim.new(1, 0)

hideB.MouseButton1Click:Connect(function()
    box.Visible = false
    showB.Visible = true
end)

showB.MouseButton1Click:Connect(function()
    box.Visible = true
    showB.Visible = false
end)

closeB.MouseButton1Click:Connect(function()
    statsGui:Destroy()
    showSg:Destroy()
end)

local dragging = false
local ds, sp

box.InputBegan:Connect(function(i)
    if locked then return end
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        ds = i.Position
        sp = box.Position
    end
end)

UserInputService.InputChanged:Connect(function(i)
    if dragging and not locked then
        local d = i.Position - ds
        box.Position = UDim2.new(sp.X.Scale, sp.X.Offset + d.X, sp.Y.Scale, sp.Y.Offset + d.Y)
    end
end)

UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

local st = tick()
task.spawn(function()
    while statsGui.Parent do
        task.wait(1)
        local e = math.floor(tick() - st)
        timeV.Text = string.format("%02d:%02d", math.floor(e / 60), e % 60)
    end
end)

local fr = 0
RunService.RenderStepped:Connect(function()
    fr = fr + 1
end)

task.spawn(function()
    while statsGui.Parent do
        task.wait(1)
        fpsV.Text = tostring(fr)
        if fr < 40 then
            fpsV.TextColor3 = Color3.fromRGB(255, 60, 60)
        else
            fpsV.TextColor3 = Color3.fromRGB(0, 255, 120)
        end
        fr = 0
        local p = 0
        pcall(function()
            p = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        end)
        pingV.Text = p .. "ms"
        if p <= 100 then
            pingV.TextColor3 = Color3.fromRGB(0, 255, 120)
        else
            pingV.TextColor3 = Color3.fromRGB(255, 60, 60)
        end
    end
end)

task.wait(0.1)
applyOpacity(0.5)

print("fix lag + anti-afk v1.1 by kudo29001 loaded")