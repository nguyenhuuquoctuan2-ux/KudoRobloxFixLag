-- Fix Lag v1.0 by kudo29001
local player = game.Players.LocalPlayer
local pg = player:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local TS = game:GetService("TweenService")
local Stats = game:GetService("Stats")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local Terrain = Workspace:FindFirstChildOfClass("Terrain")
local Camera = Workspace.CurrentCamera

-- Xoá UI cũ
for _, v in pairs(pg:GetChildren()) do
    if v.Name == "KudoPopup" or v.Name == "KudoStats" or v.Name == "KudoToggle" then
        v:Destroy()
    end
end

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
    if Camera then Camera.FieldOfView = 70 end
    Workspace.StreamingEnabled = true
    Workspace.StreamingTargetRadius = 96
    Workspace.StreamingMinRadius = 48
end)

pcall(function()
    for _, v in ipairs(Lighting:GetChildren()) do
        if v:IsA("PostEffect") or v:IsA("Sky") or v:IsA("Atmosphere") or v:IsA("Clouds") then
            v:Destroy()
        end
    end
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 100000
    Lighting.FogStart = 100000
    Lighting.Brightness = 2
    Lighting.ClockTime = 14
    Lighting.EnvironmentDiffuseScale = 0
    Lighting.EnvironmentSpecularScale = 0
    Lighting.OutdoorAmbient = Color3.fromRGB(180, 180, 180)
    Lighting.Ambient = Color3.fromRGB(180, 180, 180)
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
local function watchChar(plr)
    if plr.Character then charModels[plr.Character] = true end
    plr.CharacterAdded:Connect(function(c) charModels[c] = true end)
end
for _, plr in ipairs(game.Players:GetPlayers()) do watchChar(plr) end
game.Players.PlayerAdded:Connect(watchChar)
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

-- ==================== KILL / POTATO ====================
local killTypes = {
    ParticleEmitter = true, Trail = true, Smoke = true, Fire = true,
    Sparkles = true, Beam = true, Highlight = true, SelectionBox = true,
    BoxHandleAdornment = true, PointLight = true, SpotLight = true,
    SurfaceLight = true, ForceField = true, Explosion = true,
    Animation = true, SurfaceAppearance = true,
    Decal = true, Texture = true, SpecialMesh = true,
}

local function handleObject(v)
    if isName(v) or isChar(v) then return end
    local cn = v.ClassName
    if killTypes[cn] then
        pcall(function() v:Destroy() end)
    elseif cn == "Part" or cn == "MeshPart" or cn == "UnionOperation" or cn == "WedgePart"
        or cn == "TrussPart" or cn == "CornerWedgePart" or cn == "SpawnLocation" then
        pcall(function()
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
            v.CastShadow = false
            if v.Transparency < 0.5 then v.Transparency = 0 end
        end)
    end
end

-- Bulk dọn map lần đầu
task.spawn(function()
    local descendants = Workspace:GetDescendants()
    for i = 1, #descendants do
        handleObject(descendants[i])
        if i % 800 == 0 then task.wait() end
    end
end)

-- Object mới spawn
Workspace.DescendantAdded:Connect(function(v)
    task.defer(function()
        pcall(function() handleObject(v) end)
    end)
end)

-- ==================== GIẢM LAG KỸ THUẬT ====================

-- 1. CAMERA CULLING — ẩn part xa ngoài tầm nhìn
local CULL_DIST_SQ = 80 * 80
local culled = {}

task.spawn(function()
    while true do
        task.wait(0.4)
        pcall(function()
            if not Camera then return end
            local camPos = Camera.CFrame.Position
            local camLook = Camera.CFrame.LookVector
            for _, v in ipairs(Workspace:GetChildren()) do
                if v:IsA("BasePart") and not isChar(v) then
                    local pos = v.Position
                    -- Không cull part thấp hơn chân 3 studs (mặt đất)
                    if pos.Y >= camPos.Y - 3 then
                        local d = pos - camPos
                        local distSq = d.X*d.X + d.Y*d.Y + d.Z*d.Z
                        -- Cull nếu xa hơn ngưỡng HOẶC sau lưng camera nhiều
                        local toPart = d.Unit
                        local dot = camLook:Dot(toPart)
                        local shouldHide = distSq > CULL_DIST_SQ or (dot < -0.3 and distSq > 400)
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

-- 2. OBJECT POOLING — ẩn thay vì destroy cho hiệu ứng nhỏ
-- (không áp dụng vì destroy hiệu quả hơn cho fix lag)

-- 3. GIẢM TẦN SỐ UPDATÉ cho part không quan trọng
pcall(function()
    for _, v in ipairs(Workspace:GetChildren()) do
        if v:IsA("BasePart") then
            v.CanQuery = false
            v.CanTouch = false
        end
    end
end)

-- 4. TẮT ANIMATION CHO PART TĨNH
task.spawn(function()
    task.wait(2)
    pcall(function()
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") and not isChar(v) and not v.Anchored then
                if v:FindFirstChildOfClass("Motor6D") then
                    -- Bỏ qua part có Motor6D (có thể là part động của game)
                end
            end
        end
    end)
end)

-- 5. GIẢM TẦN SỐ CẬP NHẬT HRP
pcall(function()
    local char = player.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5, 1, 1)
        end
    end
end)

-- 6. GC NGẦM
task.spawn(function()
    while true do
        task.wait(45)
        pcall(function() collectgarbage("collect") end)
    end
end)

-- 7. TẮT SOUND XA CAMERA
task.spawn(function()
    while true do
        task.wait(3)
        pcall(function()
            if not Camera then return end
            local camPos = Camera.CFrame.Position
            for _, v in ipairs(Workspace:GetDescendants()) do
                if v:IsA("Sound") and v.Playing then
                    local parent = v.Parent
                    if parent and parent:IsA("BasePart") then
                        local d = parent.Position - camPos
                        if d.X*d.X + d.Y*d.Y + d.Z*d.Z > 10000 then
                            v.Volume = 0
                        end
                    end
                end
            end
        end)
    end
end)

-- 8. GIẢM LIGHT COUNT
pcall(function()
    local count = 0
    for _, v in ipairs(Lighting:GetDescendants()) do
        if v:IsA("PointLight") or v:IsA("SpotLight") or v:IsA("SurfaceLight") then
            if v.Brightness < 2 then
                v.Enabled = false
            end
            count = count + 1
            if count > 15 then
                v.Enabled = false
            end
        end
    end
end)

-- ==================== POPUP ====================
local sg = Instance.new("ScreenGui")
sg.Name = "KudoPopup"
sg.ResetOnSpawn = false
sg.IgnoreGuiInset = true
sg.DisplayOrder = 1000
sg.Parent = pg

local popup = Instance.new("Frame")
popup.Size = UDim2.new(0, 360, 0, 140)
popup.Position = UDim2.new(0.5, -180, 0.4, -70)
popup.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
popup.BorderSizePixel = 0
popup.Parent = sg
Instance.new("UICorner", popup).CornerRadius = UDim.new(0, 14)

local border = Instance.new("UIStroke")
border.Color = Color3.fromRGB(255, 60, 60)
border.Thickness = 2
border.Parent = popup

-- 3 SAO BĂNG 💫 TRẮNG
local starWrap = Instance.new("Frame")
starWrap.Size = UDim2.new(0, 52, 0, 52)
starWrap.Position = UDim2.new(0, 20, 0, 22)
starWrap.BackgroundTransparency = 1
starWrap.Parent = popup

local star1 = Instance.new("TextLabel")
star1.Size = UDim2.new(1, 0, 1, 0)
star1.BackgroundTransparency = 1
star1.Text = "💫"
star1.Font = Enum.Font.GothamBold
star1.TextSize = 36
star1.TextColor3 = Color3.fromRGB(255, 255, 255)
star1.Parent = starWrap

local star2 = Instance.new("TextLabel")
star2.Size = UDim2.new(1, 0, 1, 0)
star2.Position = UDim2.new(0, -5, 0, 0)
star2.BackgroundTransparency = 1
star2.Text = "💫"
star2.Font = Enum.Font.GothamBold
star2.TextSize = 30
star2.TextColor3 = Color3.fromRGB(255, 240, 240)
star2.TextTransparency = 0.4
star2.Parent = starWrap

local star3 = Instance.new("TextLabel")
star3.Size = UDim2.new(1, 0, 1, 0)
star3.Position = UDim2.new(0, 5, 0, -4)
star3.BackgroundTransparency = 1
star3.Text = "💫"
star3.Font = Enum.Font.GothamBold
star3.TextSize = 26
star3.TextColor3 = Color3.fromRGB(255, 255, 255)
star3.TextTransparency = 0.6
star3.Parent = starWrap

RS.Heartbeat:Connect(function()
    if star1.Parent then
        local t = tick() * 8
        star1.Rotation = math.sin(t) * 8
        star2.Rotation = math.cos(t * 1.3) * 10
        star3.Rotation = math.sin(t * 1.7) * 12
        star1.TextTransparency = 0.1 + math.abs(math.sin(t * 2)) * 0.2
        star2.TextTransparency = 0.4 + math.abs(math.cos(t * 2.5)) * 0.2
        star3.TextTransparency = 0.6 + math.abs(math.sin(t * 3)) * 0.2
        star1.Position = UDim2.new(0, 0, 0, math.sin(t * 1.5) * 2)
        star2.Position = UDim2.new(0, -5, 0, math.cos(t * 1.8) * 3)
        star3.Position = UDim2.new(0, 5, 0, -4 + math.sin(t * 2.2) * 2)
    end
end)

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

local percentL = Instance.new("TextLabel")
percentL.Size = UDim2.new(1, -40, 0, 22)
percentL.Position = UDim2.new(0, 20, 0, 82)
percentL.BackgroundTransparency = 1
percentL.Text = "0%"
percentL.Font = Enum.Font.GothamBold
percentL.TextSize = 16
percentL.TextColor3 = Color3.fromRGB(255, 130, 100)
percentL.Parent = popup

local pBg = Instance.new("Frame")
pBg.Size = UDim2.new(1, -40, 0, 8)
pBg.Position = UDim2.new(0, 20, 0, 112)
pBg.BackgroundColor3 = Color3.fromRGB(40, 30, 35)
pBg.BorderSizePixel = 0
pBg.Parent = popup
Instance.new("UICorner", pBg).CornerRadius = UDim.new(1, 0)

local pFill = Instance.new("Frame")
pFill.Size = UDim2.new(0, 0, 1, 0)
pFill.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
pFill.BorderSizePixel = 0
pFill.Parent = pBg
Instance.new("UICorner", pFill).CornerRadius = UDim.new(1, 0)

task.spawn(function()
    local st = tick()
    while tick() - st < 3 do
        local t = (tick() - st) / 3
        if t > 1 then t = 1 end
        percentL.Text = math.floor(t * 100) .. "%"
        pFill.Size = UDim2.new(t, 0, 1, 0)
        task.wait(0.05)
    end
    percentL.Text = "DONE ✓"
    percentL.TextColor3 = Color3.fromRGB(80, 255, 130)
    pFill.Size = UDim2.new(1, 0, 1, 0)
    pFill.BackgroundColor3 = Color3.fromRGB(80, 255, 130)
end)

task.delay(4.5, function()
    TS:Create(popup, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
    TS:Create(border, TweenInfo.new(0.6), {Transparency = 1}):Play()
    TS:Create(title, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
    TS:Create(sub, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
    TS:Create(percentL, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
    TS:Create(pBg, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
    TS:Create(pFill, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
    TS:Create(star1, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
    TS:Create(star2, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
    TS:Create(star3, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
    task.wait(0.7)
    sg:Destroy()
end)

-- ==================== UI FPS/PING/TIME ====================
local stats = Instance.new("ScreenGui")
stats.Name = "KudoStats"
stats.ResetOnSpawn = false
stats.IgnoreGuiInset = true
stats.DisplayOrder = 999
stats.Parent = pg

local box = Instance.new("Frame")
box.Size = UDim2.new(0, 150, 0, 92)
box.Position = UDim2.new(1, -160, 1, -102)
box.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
box.BackgroundTransparency = 0.4
box.BorderSizePixel = 0
box.Active = true
box.Parent = stats
Instance.new("UICorner", box).CornerRadius = UDim.new(0, 10)

local bxStroke = Instance.new("UIStroke")
bxStroke.Color = Color3.fromRGB(255, 60, 60)
bxStroke.Thickness = 1
bxStroke.Transparency = 0.6
bxStroke.Parent = box

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 16)
header.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
header.BackgroundTransparency = 0.7
header.BorderSizePixel = 0
header.Parent = box
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 10)

local function mkLabel(t, y)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(0, 40, 0, 16)
    l.Position = UDim2.new(0, 10, 0, y)
    l.BackgroundTransparency = 1
    l.Text = t
    l.Font = Enum.Font.GothamBold
    l.TextSize = 10
    l.TextColor3 = Color3.fromRGB(180, 180, 180)
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = box
end

local function mkValue(y)
    local v = Instance.new("TextLabel")
    v.Size = UDim2.new(0, 70, 0, 16)
    v.Position = UDim2.new(1, -80, 0, y)
    v.BackgroundTransparency = 1
    v.Text = "--"
    v.Font = Enum.Font.GothamBold
    v.TextSize = 12
    v.TextColor3 = Color3.fromRGB(0, 255, 120)
    v.TextXAlignment = Enum.TextXAlignment.Right
    v.Parent = box
    return v
end

mkLabel("FPS", 20)
local fpsV = mkValue(20)
mkLabel("PING", 38)
local pingV = mkValue(38)
mkLabel("TIME", 56)
local timeV = mkValue(56)
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
closeB.Size = UDim2.new(0, 22, 0, 22)
closeB.Position = UDim2.new(1, -26, 0, -3)
closeB.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeB.Text = "x"
closeB.Font = Enum.Font.GothamBold
closeB.TextSize = 13
closeB.TextColor3 = Color3.new(1, 1, 1)
closeB.BorderSizePixel = 0
closeB.Parent = box
Instance.new("UICorner", closeB).CornerRadius = UDim.new(1, 0)

local hideB = Instance.new("TextButton")
hideB.Size = UDim2.new(0, 22, 0, 22)
hideB.Position = UDim2.new(1, -52, 0, -3)
hideB.BackgroundColor3 = Color3.fromRGB(255, 150, 50)
hideB.Text = "-"
hideB.Font = Enum.Font.GothamBold
hideB.TextSize = 15
hideB.TextColor3 = Color3.new(1, 1, 1)
hideB.BorderSizePixel = 0
hideB.Parent = box
Instance.new("UICorner", hideB).CornerRadius = UDim.new(1, 0)

local resizeB = Instance.new("TextButton")
resizeB.Size = UDim2.new(0, 24, 0, 24)
resizeB.Position = UDim2.new(0, 6, 1, -26)
resizeB.BackgroundTransparency = 1
resizeB.Text = ""
resizeB.BorderSizePixel = 0
resizeB.Parent = box

local vL = Instance.new("Frame")
vL.Size = UDim2.new(0, 2, 0, 12)
vL.Position = UDim2.new(0, 7, 0, 9)
vL.AnchorPoint = Vector2.new(0.5, 0.5)
vL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
vL.BackgroundTransparency = 0.3
vL.BorderSizePixel = 0
vL.Rotation = -45
vL.Parent = resizeB
Instance.new("UICorner", vL).CornerRadius = UDim.new(1, 0)

local vR = Instance.new("Frame")
vR.Size = UDim2.new(0, 2, 0, 12)
vR.Position = UDim2.new(0, 17, 0, 9)
vR.AnchorPoint = Vector2.new(0.5, 0.5)
vR.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
vR.BackgroundTransparency = 0.3
vR.BorderSizePixel = 0
vR.Rotation = 45
vR.Parent = resizeB
Instance.new("UICorner", vR).CornerRadius = UDim.new(1, 0)

local showSg = Instance.new("ScreenGui")
showSg.Name = "KudoToggle"
showSg.ResetOnSpawn = false
showSg.IgnoreGuiInset = true
showSg.DisplayOrder = 998
showSg.Parent = pg

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
    stats:Destroy()
    showSg:Destroy()
end)

local dragging = false
local ds, sp
header.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        ds = i.Position
        sp = box.Position
    end
end)

UIS.InputChanged:Connect(function(i)
    if dragging then
        local d = i.Position - ds
        box.Position = UDim2.new(sp.X.Scale, sp.X.Offset + d.X, sp.Y.Scale, sp.Y.Offset + d.Y)
    end
end)

UIS.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Resize đúng hướng: kéo phải = tăng
local resizing = false
local rs, rss
resizeB.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        resizing = true
        rs = i.Position
        rss = box.Size
    end
end)

UIS.InputChanged:Connect(function(i)
    if resizing then
        local d = i.Position - rs
        local nx = math.max(120, rss.X.Offset + d.X)
        local ny = math.max(80, rss.Y.Offset + d.Y)
        box.Size = UDim2.new(0, nx, 0, ny)
    end
end)

UIS.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        resizing = false
    end
end)

local st = tick()
task.spawn(function()
    while stats.Parent do
        task.wait(1)
        local e = math.floor(tick() - st)
        timeV.Text = string.format("%02d:%02d", math.floor(e / 60), e % 60)
    end
end)

local fr = 0
RS.RenderStepped:Connect(function()
    fr = fr + 1
end)

task.spawn(function()
    while stats.Parent do
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

print("✅ fix lag v1.0 by kudo29001 loaded")