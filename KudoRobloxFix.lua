-- Fix Lag v1.0 by kudo29001 - Lightweight
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

pcall(function()
    for _, v in pairs(playerGui:GetChildren()) do
        if v.Name == "KudoPopup" or v.Name == "KudoStats" or v.Name == "KudoToggle" then
            v:Destroy()
        end
    end
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
    setfflag("FFlagRenderShadowIntensity", "0")
    setfflag("FFlagRenderShadowIntensityOverride", "True")
    setfflag("DFFlagDisableRenderShadowMap", "True")
    setfflag("FFlagDisableShadows", "True")
    setfflag("FFlagDisableDynamicLighting", "True")
    setfflag("FFlagDebugSkyGray", "True")
    setfflag("FFlagDisableAtmosphere", "True")
    setfflag("FFlagDisableSky", "True")
    setfflag("FFlagDisableFog", "True")
    setfflag("FFlagDisableTerrainDecoration", "True")
    setfflag("FIntFRMMaxGrassDistance", "0")
    setfflag("FIntFRMMinGrassDistance", "0")
    setfflag("DFIntCSGLevelOfDetailSwitchingDistance", "0")
    setfflag("DFIntCSGLevelOfDetailSwitchingDistanceL12", "0")
    setfflag("DFIntCSGLevelOfDetailSwitchingDistanceL23", "0")
    setfflag("DFIntCSGLevelOfDetailSwitchingDistanceL34", "0")
    setfflag("FFlagDisableLODTransitions", "True")
    setfflag("FFlagForceLOD0", "True")
    setfflag("DFIntLODBias", "8")
    setfflag("DFFlagDebugRenderForceTechnologyVoxel", "True")
    setfflag("FFlagDebugPauseVoxelizer", "True")
    setfflag("DFIntSolverSpringDamping", "0")
    setfflag("DFIntPhysicsSendRate", "1")
    setfflag("DFIntMaxSimultaneousPhysicsJobs", "1")
    setfflag("DFIntPhysicsStepPerFrame", "1")
    setfflag("DFIntMaximumCollisionIterations", "1")
    setfflag("DFIntSolverConvergenceIterations", "1")
    setfflag("DFIntFrameBufferPoolSize", "1")
    setfflag("DFIntRenderMeshMaxBones", "1")
    setfflag("DFIntDebugEngineOptimizationLevel", "3")
    setfflag("DFFlagGCEnableIncremental", "True")
    setfflag("DFIntGCIncrementalPause", "2")
    setfflag("DFIntGCIncrementalStepMul", "3000")
    setfflag("FFlagDebugGraphicsPreferOpenGL", "True")
end)

-- ==================== ENGINE CONFIG ====================
pcall(function()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01
    settings().Rendering.AnimationWeightedBlendFix = Enum.AnimationWeightedBlendFix.Disabled
end)

pcall(function()
    if Camera then
        Camera.FieldOfView = 70
    end
    Workspace.StreamingEnabled = true
    Workspace.StreamingTargetRadius = 96
    Workspace.StreamingMinRadius = 48
end)

pcall(function()
    for _, v in ipairs(Lighting:GetChildren()) do
        if v:IsA("PostEffect") or v:IsA("Sky") or v:IsA("Atmosphere") 
            or v:IsA("Clouds") then
            v:Destroy()
        end
    end
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 100000
    Lighting.FogStart = 100000
    Lighting.Brightness = 2
    Lighting.ClockTime = 14
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

-- ==================== CACHE NHÂN VẬT ====================
local charModels = {}
local function watchPlayer(plr)
    if plr.Character then charModels[plr.Character] = true end
    plr.CharacterAdded:Connect(function(c) charModels[c] = true end)
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
        pcall(function()
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
            v.CastShadow = false
        end)
    end
end

task.spawn(function()
    local descendants = Workspace:GetDescendants()
    for i = 1, #descendants do
        handleObject(descendants[i])
        if i % 1000 == 0 then task.wait() end
    end
end)

Workspace.DescendantAdded:Connect(function(v)
    task.defer(function()
        pcall(function() handleObject(v) end)
    end)
end)

-- ==================== CULLING ====================
local CULL_DIST_SQ = 80 * 80
local culled = {}

task.spawn(function()
    while true do
        task.wait(0.5)
        pcall(function()
            if not Camera then return end
            local camPos = Camera.CFrame.Position
            for _, v in ipairs(Workspace:GetChildren()) do
                if v:IsA("BasePart") and not isChar(v) then
                    local pos = v.Position
                    if pos.Y >= camPos.Y - 3 then
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
        end)
    end
end)

task.spawn(function()
    while true do
        task.wait(60)
        pcall(function() collectgarbage("collect") end)
    end
end)

-- ==================== POPUP ====================
local popupGui = Instance.new("ScreenGui")
popupGui.Name = "KudoPopup"
popupGui.ResetOnSpawn = false
popupGui.IgnoreGuiInset = true
popupGui.DisplayOrder = 1000
popupGui.Parent = playerGui

local popup = Instance.new("Frame")
popup.Size = UDim2.new(0, 360, 0, 140)
popup.Position = UDim2.new(0.5, -180, 0.4, -70)
popup.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
popup.BorderSizePixel = 0
popup.Parent = popupGui
Instance.new("UICorner", popup).CornerRadius = UDim.new(0, 14)

local border = Instance.new("UIStroke")
border.Color = Color3.fromRGB(255, 60, 60)
border.Thickness = 2
border.Parent = popup

-- ===== LOGO VÒNG TRÒN RỖNG, CHỈ CÓ VIỀN =====
local spinWrap = Instance.new("Frame")
spinWrap.Size = UDim2.new(0, 52, 0, 52)
spinWrap.Position = UDim2.new(0, 20, 0, 22)
spinWrap.BackgroundTransparency = 1
spinWrap.Parent = popup

-- Vòng tròn viền mờ nền (background ring)
local bgRing = Instance.new("Frame")
bgRing.Size = UDim2.new(1, 0, 1, 0)
bgRing.Position = UDim2.new(0, 0, 0, 0)
bgRing.BackgroundTransparency = 1
bgRing.Parent = spinWrap
Instance.new("UICorner", bgRing).CornerRadius = UDim.new(1, 0)

local bgRingStroke = Instance.new("UIStroke")
bgRingStroke.Color = Color3.fromRGB(60, 40, 45)
bgRingStroke.Thickness = 2
bgRingStroke.Transparency = 0.3
bgRingStroke.Parent = bgRing

-- Vòng sáng xoay (chỉ viền, rỗng bên trong)
local spinner = Instance.new("Frame")
spinner.Size = UDim2.new(0, 52, 0, 52)
spinner.BackgroundTransparency = 1
spinner.Parent = spinWrap
Instance.new("UICorner", spinner).CornerRadius = UDim.new(1, 0)

-- Tạo vòng cung bằng Frame + UIStroke có Gradient
local arcFrame = Instance.new("Frame")
arcFrame.Size = UDim2.new(1, 0, 1, 0)
arcFrame.BackgroundTransparency = 1
arcFrame.Parent = spinner
Instance.new("UICorner", arcFrame).CornerRadius = UDim.new(1, 0)

local arcStroke = Instance.new("UIStroke")
arcStroke.Color = Color3.fromRGB(255, 80, 80)
arcStroke.Thickness = 3
arcStroke.Transparency = 0.1
arcStroke.Parent = arcFrame

-- Xoay vòng
task.spawn(function()
    local rot = 0
    while spinner.Parent do
        rot = (rot + 12) % 360
        spinner.Rotation = rot
        task.wait(0.03)
    end
end)

-- ===== TEXT =====
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -180, 0, 26)
title.Position = UDim2.new(0, 88, 0, 22)
title.BackgroundTransparency = 1
title.Text = "fix lag v1.0"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255, 100, 100)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = popup

local sub = Instance.new("TextLabel")
sub.Size = UDim2.new(1, -180, 0, 18)
sub.Position = UDim2.new(0, 88, 0, 50)
sub.BackgroundTransparency = 1
sub.Text = "by kudo29001 ⚡"
sub.Font = Enum.Font.Gotham
sub.TextSize = 12
sub.TextColor3 = Color3.fromRGB(160, 160, 170)
sub.TextXAlignment = Enum.TextXAlignment.Left
sub.Parent = popup

local percentLabel = Instance.new("TextLabel")
percentLabel.Size = UDim2.new(1, -40, 0, 22)
percentLabel.Position = UDim2.new(0, 20, 0, 82)
percentLabel.BackgroundTransparency = 1
percentLabel.Text = "0%"
percentLabel.Font = Enum.Font.GothamBold
percentLabel.TextSize = 16
percentLabel.TextColor3 = Color3.fromRGB(255, 130, 100)
percentLabel.Parent = popup

local progressBg = Instance.new("Frame")
progressBg.Size = UDim2.new(1, -40, 0, 8)
progressBg.Position = UDim2.new(0, 20, 0, 112)
progressBg.BackgroundColor3 = Color3.fromRGB(40, 30, 35)
progressBg.BorderSizePixel = 0
progressBg.Parent = popup
Instance.new("UICorner", progressBg).CornerRadius = UDim.new(1, 0)

local progressFill = Instance.new("Frame")
progressFill.Size = UDim2.new(0, 0, 1, 0)
progressFill.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
progressFill.BorderSizePixel = 0
progressFill.Parent = progressBg
Instance.new("UICorner", progressFill).CornerRadius = UDim.new(1, 0)

-- Load 0→100% + thông báo DONE
task.spawn(function()
    local startTick = tick()
    local duration = 3
    while tick() - startTick < duration do
        local t = (tick() - startTick) / duration
        if t > 1 then t = 1 end
        percentLabel.Text = math.floor(t * 100) .. "%"
        progressFill.Size = UDim2.new(t, 0, 1, 0)
        task.wait(0.05)
    end
    
    percentLabel.Text = "DONE ✓"
    percentLabel.TextColor3 = Color3.fromRGB(80, 255, 130)
    percentLabel.TextSize = 18
    progressFill.Size = UDim2.new(1, 0, 1, 0)
    TweenService:Create(progressFill, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(80, 255, 130)
    }):Play()
end)

task.delay(4, function()
    pcall(function() popupGui:Destroy() end)
end)

-- ==================== UI FPS + PING + TIME ====================
local statsGui = Instance.new("ScreenGui")
statsGui.Name = "KudoStats"
statsGui.ResetOnSpawn = false
statsGui.IgnoreGuiInset = true
statsGui.DisplayOrder = 999
statsGui.Parent = playerGui

local box = Instance.new("Frame")
box.Size = UDim2.new(0, 150, 0, 92)
box.Position = UDim2.new(1, -160, 1, -102)
box.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
box.BackgroundTransparency = 0.4
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
header.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
header.BackgroundTransparency = 0.7
header.BorderSizePixel = 0
header.Parent = box
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 10)

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
hideBtn.Parent = box
Instance.new("UICorner", hideBtn).CornerRadius = UDim.new(1, 0)

-- ===== CHỮ V TRONG UI, GÓC TRÁI DƯỚI =====
local resizeBtn = Instance.new("TextButton")
resizeBtn.Size = UDim2.new(0, 22, 0, 22)
resizeBtn.Position = UDim2.new(0, 4, 1, -24)
resizeBtn.BackgroundTransparency = 1
resizeBtn.Text = ""
resizeBtn.BorderSizePixel = 0
resizeBtn.Parent = box

local vL = Instance.new("Frame")
vL.Size = UDim2.new(0, 2, 0, 12)
vL.Position = UDim2.new(0, 6, 0, 10)
vL.AnchorPoint = Vector2.new(0.5, 0.5)
vL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
vL.BackgroundTransparency = 0.3
vL.BorderSizePixel = 0
vL.Rotation = -45
vL.Parent = resizeBtn
Instance.new("UICorner", vL).CornerRadius = UDim.new(1, 0)

local vR = Instance.new("Frame")
vR.Size = UDim2.new(0, 2, 0, 12)
vR.Position = UDim2.new(0, 14, 0, 10)
vR.AnchorPoint = Vector2.new(0.5, 0.5)
vR.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
vR.BackgroundTransparency = 0.3
vR.BorderSizePixel = 0
vR.Rotation = 45
vR.Parent = resizeBtn
Instance.new("UICorner", vR).CornerRadius = UDim.new(1, 0)

local showGui = Instance.new("ScreenGui")
showGui.Name = "KudoToggle"
showGui.ResetOnSpawn = false
showGui.IgnoreGuiInset = true
showGui.DisplayOrder = 998
showGui.Parent = playerGui

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

hideBtn.MouseButton1Click:Connect(function()
    box.Visible = false
    showBtn.Visible = true
end)

showBtn.MouseButton1Click:Connect(function()
    box.Visible = true
    showBtn.Visible = false
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
    if dragging then
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
    if resizing then
        local delta = input.Position - resizeStart
        local newX = math.max(120, resizeStartSize.X.Offset + delta.X)
        local newY = math.max(80, resizeStartSize.Y.Offset + delta.Y)
        box.Size = UDim2.new(0, newX, 0, newY)
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
task.spawn(function()
    RunService.RenderStepped:Connect(function()
        frames = frames + 1
    end)
    while statsGui.Parent do
        task.wait(1)
        local fps = frames
        frames = 0
        fpsValue.Text = tostring(fps)
        if fps < 40 then
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

print("✅ fix lag v1.0 by kudo29001 loaded")