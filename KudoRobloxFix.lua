local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Terrain = Workspace:FindFirstChildOfClass("Terrain")
local Camera = Workspace.CurrentCamera

local sg = Instance.new("ScreenGui")
sg.Name = "FixLag"
sg.ResetOnSpawn = false
sg.IgnoreGuiInset = true
sg.Parent = playerGui

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 280, 0, 110)
main.Position = UDim2.new(0.5, -140, 0.5, -55)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
main.BackgroundTransparency = 0.05
main.BorderSizePixel = 0
main.Parent = sg
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(0, 220, 100)
stroke.Thickness = 1.5
stroke.Transparency = 0.3
stroke.Parent = main

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -20, 0, 26)
titleLabel.Position = UDim2.new(0, 10, 0, 10)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "⚡ FIX LAG"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 14
titleLabel.TextColor3 = Color3.fromRGB(0, 255, 120)
titleLabel.TextXAlignment = Enum.TextXAlignment.Center
titleLabel.Parent = main

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -20, 0, 18)
statusLabel.Position = UDim2.new(0, 10, 0, 38)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Đang khởi tạo..."
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 10
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
statusLabel.TextXAlignment = Enum.TextXAlignment.Center
statusLabel.Parent = main

local percentLabel = Instance.new("TextLabel")
percentLabel.Size = UDim2.new(1, -20, 0, 16)
percentLabel.Position = UDim2.new(0, 10, 0, 56)
percentLabel.BackgroundTransparency = 1
percentLabel.Text = "0%"
percentLabel.Font = Enum.Font.GothamBold
percentLabel.TextSize = 12
percentLabel.TextColor3 = Color3.fromRGB(0, 255, 120)
percentLabel.TextXAlignment = Enum.TextXAlignment.Center
percentLabel.Parent = main

local progressBg = Instance.new("Frame")
progressBg.Size = UDim2.new(1, -40, 0, 6)
progressBg.Position = UDim2.new(0, 20, 0, 78)
progressBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
progressBg.BorderSizePixel = 0
progressBg.Parent = main
Instance.new("UICorner", progressBg).CornerRadius = UDim.new(0, 3)

local progressFill = Instance.new("Frame")
progressFill.Size = UDim2.new(0, 0, 1, 0)
progressFill.BackgroundColor3 = Color3.fromRGB(0, 220, 100)
progressFill.BorderSizePixel = 0
progressFill.Parent = progressBg
Instance.new("UICorner", progressFill).CornerRadius = UDim.new(0, 3)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 20, 0, 20)
closeBtn.Position = UDim2.new(1, -26, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
closeBtn.Text = "✕"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 11
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.BorderSizePixel = 0
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.Parent = main

local function setProgress(percent, text)
    percent = math.clamp(percent, 0, 100)
    TweenService:Create(progressFill, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
        Size = UDim2.new(percent / 100, 0, 1, 0)
    }):Play()
    percentLabel.Text = math.floor(percent) .. "%"
    if text then statusLabel.Text = text end
end

local function step(text, fn, percent)
    setProgress(percent, text)
    pcall(fn)
    task.wait(0.02)
end

step("Áp dụng FastFlags...", function()
    setfflag("DFIntTaskSchedulerTargetFps", "9999")
    setfflag("DFIntFrameRateCap", "9999")
    setfflag("DFIntMaxFrameRate", "9999")
    setfflag("DFIntMinFrameRate", "1")
    setfflag("FFlagDisableVSync", "True")
    setfflag("FFlagDebugDisplayFPS", "True")
    setfflag("DFIntFrameRateCapOverride", "9999")
    setfflag("DFIntRenderThrottleEnabled", "0")
    setfflag("DFIntRenderThrottleMs", "0")
    setfflag("FFlagRenderThrottleDisable", "True")
    setfflag("DFIntMaxFramesInFlight", "1")
    setfflag("DFIntTripleBufferingEnabled", "0")
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
    setfflag("DFFlagDisableGPUOcclusion", "False")

    setfflag("FFlagDisableAnimationBlending", "True")
    setfflag("DFFlagSkipAnimationBlending", "True")
    setfflag("FFlagDisableFacialAnimation", "True")

    setfflag("DFIntConnectionMTUSize", "1400")
end, 20)

step("Hạ graphics...", function()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01
    settings().Rendering.AnimationWeightedBlendFix = Enum.AnimationWeightedBlendFix.Disabled
    settings().Rendering.EagerBulkExecution = true
end, 30)

step("Tối ưu Camera...", function()
    if Camera then
        Camera.FieldOfView = 70
        Camera.CameraType = Enum.CameraType.Custom
    end
end, 40)

step("Tắt Terrain...", function()
    if Terrain then
        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveSpeed = 0
        Terrain.WaterReflectance = 0
        Terrain.WaterTransparency = 1
        Terrain.Decoration = false
    end
end, 50)

step("Tắt PostFX & Lighting...", function()
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
    Lighting.OutdoorAmbient = Color3.fromRGB(128,128,128)
    Lighting.Ambient = Color3.fromRGB(128,128,128)
    Lighting.ClockTime = 14
    Lighting.ExposureCompensation = 0
    Lighting.ShadowSoftness = 0
end, 60)

local potatoMaterials = {
    [Enum.Material.Grass]=true,[Enum.Material.LeafyGrass]=true,[Enum.Material.Wood]=true,
    [Enum.Material.WoodPlanks]=true,[Enum.Material.Rock]=true,[Enum.Material.Slate]=true,
    [Enum.Material.Sand]=true,[Enum.Material.Mud]=true,[Enum.Material.Snow]=true,
    [Enum.Material.Ice]=true,[Enum.Material.Glacier]=true,[Enum.Material.CorrodedMetal]=true,
    [Enum.Material.DiamondPlate]=true,[Enum.Material.Foil]=true,[Enum.Material.Marble]=true,
    [Enum.Material.Granite]=true,[Enum.Material.Brick]=true,[Enum.Material.Cobblestone]=true,
    [Enum.Material.Concrete]=true,[Enum.Material.Fabric]=true,[Enum.Material.Pebble]=true,
    [Enum.Material.Limestone]=true,[Enum.Material.Pavement]=true,[Enum.Material.Asphalt]=true,
    [Enum.Material.Basalt]=true,[Enum.Material.CrackedLava]=true,[Enum.Material.Neon]=true,
    [Enum.Material.Glass]=true,[Enum.Material.ForceField]=true,[Enum.Material.Metal]=true,
    [Enum.Material.Cardboard]=true,[Enum.Material.Carpet]=true,[Enum.Material.CeramicTiles]=true,
    [Enum.Material.ClayRoofTiles]=true,[Enum.Material.RoofShingles]=true,[Enum.Material.Leather]=true,
    [Enum.Material.Plaster]=true,[Enum.Material.Rubber]=true,
}

local charModels = {}
local charConns = {}
local function watchPlayer(plr)
    if charConns[plr] then charConns[plr]:Disconnect() end
    charConns[plr] = plr.CharacterAdded:Connect(function(c)
        charModels[c] = true
    end)
    if plr.Character then
        charModels[plr.Character] = true
    end
end

for _, plr in ipairs(game.Players:GetPlayers()) do
    watchPlayer(plr)
end
game.Players.PlayerAdded:Connect(watchPlayer)
game.Players.PlayerRemoving:Connect(function(plr)
    if charConns[plr] then
        charConns[plr]:Disconnect()
        charConns[plr] = nil
    end
    if plr.Character then
        charModels[plr.Character] = nil
    end
end)

local function isCharacterDescendant(v)
    local current = v
    while current do
        if charModels[current] then return true end
        if current:IsA("Accessory") then return true end
        if current:IsA("Tool") then return true end
        current = current.Parent
    end
    return false
end

local function isNameTag(v)
    if v:IsA("BillboardGui") then return true end
    if v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("TextScreenGui") then return true end
    if v:IsA("Humanoid") then return true end
    if v:IsA("Accessory") then return true end
    if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") then return true end
    if v:IsA("CharacterMesh") then return true end
    if v:IsA("BodyColors") then return true end
    if v:IsA("Sound") then return true end
    if v:IsA("Animator") or v:IsA("AnimationController") then return true end
    if v:IsA("Animation") then return true end
    if v:IsA("KeyframeSequence") or v:IsA("Keyframe") or v:IsA("Pose") then return true end
    return false
end

local function optimizeObject(v)
    if isNameTag(v) then return end
    if isCharacterDescendant(v) then return end

    if v:IsA("BasePart") then
        pcall(function()
            if potatoMaterials[v.Material] then v.Material = Enum.Material.SmoothPlastic end
            v.Reflectance = 0
            v.CastShadow = false
        end)
    elseif v:IsA("Decal") then
        pcall(function() v.Transparency = 1 end)
    elseif v:IsA("Texture") then
        pcall(function() v.Transparency = 1 end)
    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke")
        or v:IsA("Fire") or v:IsA("Sparkles") or v:IsA("Beam") then
        pcall(function() v.Enabled = false end)
    elseif v:IsA("SurfaceAppearance") then
        pcall(function() v:Destroy() end)
    elseif v:IsA("SpecialMesh") then
        pcall(function()
            if v.MeshType == Enum.MeshType.FileMesh or v.MeshType == Enum.MeshType.Head then
                v.TextureId = ""
            end
        end)
    elseif v:IsA("MeshPart") then
        pcall(function()
            v.TextureID = ""
            v.RenderFidelity = Enum.RenderFidelity.Performance
            v.CastShadow = false
        end)
    elseif v:IsA("Highlight") or v:IsA("SelectionBox") or v:IsA("BoxHandleAdornment") then
        pcall(function() v.Enabled = false end)
    elseif v:IsA("Attachment") then
        pcall(function()
            for _, c in ipairs(v:GetChildren()) do
                if c:IsA("ParticleEmitter") or c:IsA("Trail") or c:IsA("Beam") or c:IsA("Light") then
                    c:Destroy()
                end
            end
        end)
    elseif v:IsA("PointLight") or v:IsA("SpotLight") or v:IsA("SurfaceLight") then
        pcall(function() v:Destroy() end)
    end
end

local allDescendants = Workspace:GetDescendants()
local total = #allDescendants

for i, v in ipairs(allDescendants) do
    optimizeObject(v)
    if i % 200 == 0 then
        local p = 65 + math.floor((i / total) * 30)
        setProgress(p, "Đang quét... " .. i .. "/" .. total)
        task.wait()
    end
end

local scanConn
scanConn = Workspace.DescendantAdded:Connect(function(v)
    task.defer(function() optimizeObject(v) end)
end)

task.spawn(function()
    while sg.Parent do
        task.wait(15)
        pcall(function() collectgarbage("collect") end)
    end
end)

local cullConn
cullConn = RunService.Heartbeat:Connect(function()
    pcall(function()
        if not Camera then return end
        local camPos = Camera.CFrame.Position
        local camLook = Camera.CFrame.LookVector
        for _, v in ipairs(Workspace:GetChildren()) do
            if v:IsA("BasePart") then
                if not isCharacterDescendant(v) then
                    local dist = (v.Position - camPos).Magnitude
                    if dist > 500 then
                        v.LocalTransparencyModifier = 1
                    else
                        local toPart = (v.Position - camPos).Unit
                        if camLook:Dot(toPart) < -0.3 then
                            v.LocalTransparencyModifier = 1
                        else
                            v.LocalTransparencyModifier = 0
                        end
                    end
                end
            end
        end
    end)
end)

task.spawn(function()
    while sg.Parent do
        task.wait(3)
        pcall(function()
            for _, v in ipairs(Workspace:GetDescendants()) do
                if (v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam")
                    or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles")) then
                    if not isCharacterDescendant(v) then
                        v.Enabled = false
                    end
                end
            end
        end)
    end
end)

local fpsGui = Instance.new("ScreenGui")
fpsGui.Name = "KudoFPS"
fpsGui.ResetOnSpawn = false
fpsGui.IgnoreGuiInset = true
fpsGui.Parent = playerGui

local fpsBox = Instance.new("TextLabel")
fpsBox.Size = UDim2.new(0, 150, 0, 26)
fpsBox.Position = UDim2.new(1, -160, 1, -34)
fpsBox.BackgroundTransparency = 1
fpsBox.Text = "FPS: --"
fpsBox.Font = Enum.Font.Times
fpsBox.TextSize = 15
fpsBox.TextColor3 = Color3.fromRGB(0, 255, 120)
fpsBox.TextXAlignment = Enum.TextXAlignment.Right
fpsBox.Parent = fpsGui

local frames = 0
task.spawn(function()
    RunService.RenderStepped:Connect(function()
        frames = frames + 1
    end)
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
        fpsBox.Text = "FPS: " .. fps
        fpsBox.TextColor3 = color
    end
end)

setProgress(100, "✅ Hoàn tất")

task.wait(1)

titleLabel.Text = "⚡ fix lag by kudo29001"
statusLabel.Text = ""
percentLabel.Text = ""
TweenService:Create(progressBg, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
TweenService:Create(progressFill, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
TweenService:Create(main, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
    Size = UDim2.new(0, 220, 0, 44),
    Position = UDim2.new(0, 15, 0, 15)
}):Play()
TweenService:Create(titleLabel, TweenInfo.new(0.4), {
    Size = UDim2.new(1, -20, 1, -12),
    Position = UDim2.new(0, 10, 0, 6),
    TextSize = 13
}):Play()

closeBtn.Visible = false

task.wait(4)
pcall(function()
    TweenService:Create(main, TweenInfo.new(0.5), {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 15, 0, 0)
    }):Play()
    TweenService:Create(titleLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(stroke, TweenInfo.new(0.5), {Transparency = 1}):Play()
    task.wait(0.6)
    if scanConn then scanConn:Disconnect() end
    if cullConn then cullConn:Disconnect() end
    sg:Destroy()
end)

closeBtn.MouseButton1Click:Connect(function()
    pcall(function()
        if scanConn then scanConn:Disconnect() end
        if cullConn then cullConn:Disconnect() end
        sg:Destroy()
    end)
end)

print("✅ fix lag by kudo29001")