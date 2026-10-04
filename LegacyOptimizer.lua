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
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local uiParent = PlayerGui
pcall(function()
    if gethui then uiParent = gethui() elseif cloneref then uiParent = cloneref(CoreGui) end
end)

local flagtables = {
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
    ["FFlagDebugDisplayFPS"] = "True",

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
    ["FLogNetwork"] = "7"
}

local function formatFlag(z)
    z = z:gsub("^DFInt", "")
    z = z:gsub("^DFFlag", "")
    z = z:gsub("^FFlag", "")
    z = z:gsub("^FInt", "")
    z = z:gsub("FString", "")
    z = z:gsub("FLog", "")
    return z
end

task.spawn(function()
    if setfflag then
        for k, v in pairs(flagtables) do
            pcall(function()
                local formatted = formatFlag(k)
                if getfflag and getfflag(formatted) then
                    setfflag(formatted, v)
                elseif getfflag and getfflag(k) then
                    setfflag(k, v)
                else
                    setfflag(k, v)
                end
            end)
        end
    end
end)

pcall(function()
    if Camera then
        Camera.FieldOfView = 90
    end
end)

local SKY_GRAY = Color3.fromRGB(128, 128, 128)

local function hardNukeSky()
    pcall(function()
        for _, v in ipairs(Lighting:GetChildren()) do
            if v:IsA("Sky") or v:IsA("Atmosphere") or v:IsA("Clouds") or v:IsA("PostEffect") then
                pcall(function() v:Destroy() end)
            end
        end
        local sky = Instance.new("Sky")
        sky.SkyboxBk = "rbxasset://textures/sky/sky512_bk.tex"
        sky.SkyboxDn = "rbxasset://textures/sky/sky512_dn.tex"
        sky.SkyboxFt = "rbxasset://textures/sky/sky512_ft.tex"
        sky.SkyboxLf = "rbxasset://textures/sky/sky512_lf.tex"
        sky.SkyboxRt = "rbxasset://textures/sky/sky512_rt.tex"
        sky.SkyboxUp = "rbxasset://textures/sky/sky512_up.tex"
        sky.SunTextureId = ""
        sky.MoonTextureId = ""
        sky.StarCount = 0
        sky.CelestialBodiesShown = false
        sky.Parent = Lighting
    end)
end

task.spawn(function()
    while true do
        hardNukeSky()
        task.wait(0.5)
    end
end)

task.spawn(function()
    while true do
        pcall(function()
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
        task.wait(1)
    end
end)

task.spawn(function()
    while true do
        pcall(function()
            if Terrain then
                Terrain.WaterWaveSize = 0
                Terrain.WaterWaveSpeed = 0
                Terrain.WaterReflectance = 0
                Terrain.WaterTransparency = 0
                Terrain.WaterColor = Color3.fromRGB(0, 100, 200)
                Terrain.Decoration = false
                for _, v in ipairs(Terrain:GetChildren()) do
                    if v:IsA("Water") then
                        v.WaterColor = Color3.fromRGB(0, 100, 200)
                        v.WaterTransparency = 0
                        v.WaterReflectance = 0
                        v.WaterWaveSize = 0
                        v.WaterWaveSpeed = 0
                    end
                end
            end
        end)
        task.wait(0.5)
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

local function isProtected(v)
    return v:IsA("BillboardGui")
        or v:IsA("TextLabel")
        or v:IsA("TextButton")
        or v:IsA("TextBox")
        or v:IsA("ImageLabel")
        or v:IsA("ImageButton")
        or v:IsA("Humanoid")
        or v:IsA("ProximityPrompt")
        or v:IsA("ProximityPromptService")
        or v:IsA("ClickDetector")
        or v:IsA("SurfaceGui")
        or v:IsA("SurfaceAppearance")
        or v:IsA("ScreenGui")
        or v:IsA("GuiObject")
        or v:IsA("GuiMain")
        or v:IsA("Folder")
        or v:IsA("Configuration")
        or v:IsA("Script")
        or v:IsA("LocalScript")
        or v:IsA("ModuleScript")
        or v:IsA("RemoteEvent")
        or v:IsA("RemoteFunction")
        or v:IsA("BindableEvent")
        or v:IsA("BindableFunction")
        or v:IsA("Animation")
        or v:IsA("AnimationController")
        or v:IsA("Animator")
end

local killTypes = {
    ParticleEmitter = true, Trail = true, Smoke = true, Fire = true,
    Sparkles = true, Beam = true,
    PointLight = true, SpotLight = true,
    SurfaceLight = true, ForceField = true, Explosion = true,
    Atmosphere = true, Clouds = true,
    DepthOfFieldEffect = true, BloomEffect = true, BlurEffect = true,
    ColorCorrectionEffect = true, SunRaysEffect = true,
}

local function handleObject(v)
    if isProtected(v) or isChar(v) then return end
    local cn = v.ClassName
    if killTypes[cn] then
        pcall(function() v:Destroy() end)
    elseif cn == "Part" or cn == "MeshPart" or cn == "UnionOperation" or cn == "WedgePart" or cn == "CornerWedgePart" then
        pcall(function()
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
            v.CastShadow = false
            if v:IsA("MeshPart") and v.TextureID ~= "" then
                v.RenderFidelity = Enum.RenderFidelity.Performance
            end
        end)
    elseif cn == "Model" then
        pcall(function()
            v.LevelOfDetail = Enum.ModelLevelOfDetail.StreamingMesh
        end)
    end
end

task.spawn(function()
    local descendants = Workspace:GetDescendants()
    local total = #descendants
    if total == 0 then return end
    local BATCH_SIZE = 800
    local MAX_CONCURRENT = 50
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
end)

Workspace.DescendantAdded:Connect(function(v)
    task.defer(function()
        pcall(handleObject, v)
    end)
end)

task.spawn(function()
    while true do
        task.wait(2)
        pcall(function()
            for _, v in ipairs(Workspace:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
                    if v.Enabled then v.Enabled = false end
                end
            end
        end)
    end
end)

task.spawn(function()
    while true do
        task.wait(1.5)
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
        task.wait(4)
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

task.spawn(function()
    while true do
        task.wait(15)
        pcall(function()
            collectgarbage("collect")
            collectgarbage("collect")
            collectgarbage("collect")
        end)
    end
end)

local CULL_DIST_SQ = 50 * 50
local culled = {}

task.spawn(function()
    while true do
        task.wait(0.25)
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

local statsGui = Instance.new("ScreenGui")
statsGui.Name = "LegacyStats"
statsGui.ResetOnSpawn = false
statsGui.IgnoreGuiInset = true
statsGui.DisplayOrder = 2147483647
statsGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
statsGui.Parent = uiParent

local box = Instance.new("Frame")
box.Size = UDim2.new(0, 220, 0, 108)
box.Position = UDim2.new(1, -230, 1, -118)
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
    l.Size = UDim2.new(0, 55, 0, 18)
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
    v.Size = UDim2.new(0, 120, 0, 18)
    v.Position = UDim2.new(1, -132, 0, y)
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
credit.Text = "@realz29001 on tiktok"
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
showSg.Name = "LegacyToggle"
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

print("Legacy optimizer v1.2.0 by @realz29001 loaded")