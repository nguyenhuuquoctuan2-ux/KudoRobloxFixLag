-- Fix Lag + Anti-AFK v1.0 by kudo29001
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
local VirtualUser = game:GetService("VirtualUser")
local VIM = game:GetService("VirtualInputManager")

local uiParent = pg
pcall(function()
    if gethui then uiParent = gethui() end
end)

-- XOÁ UI CŨ TRIỆT ĐỂ (cả PlayerGui lẫn CoreGui)
for _, v in pairs(pg:GetChildren()) do
    if v.Name == "KudoPopup" or v.Name == "KudoStats" or v.Name == "KudoToggle" then
        v:Destroy()
    end
end
pcall(function()
    for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do
        if v.Name == "KudoPopup" or v.Name == "KudoStats" or v.Name == "KudoToggle" then
            v:Destroy()
        end
    end
end)
-- Xoá cả GUI cũ dạng khác nếu còn sót
for _, v in pairs(pg:GetChildren()) do
    if v:IsA("ScreenGui") and (v.Name:find("Kudo") or v.Name:find("FixLag")) then
        pcall(function() v:Destroy() end)
    end
end

-- ==================== FFLAG ====================
pcall(function()
    setfflag("DFIntTaskSchedulerTargetFps", "9999")
    setfflag("DFIntFrameRateCap", "9999")
    setfflag("DFIntMaxFrameRate", "9999")
    setfflag("FFlagDisableVSync", "True")
    setfflag("DFIntDebugFRMQualityLevelOverride", "1")
    setfflag("DFIntTextureQualityOverride", "0")
    setfflag("DFFlagTextureQualityOverrideEnabled", "True")
    setfflag("FFlagTextureQualityOverride", "True")
    setfflag("FFlagDisableTextures", "True")
    setfflag("FFlagDisableSurfaceAppearance", "True")
    setfflag("DFFlagDisableSSAO", "True")
    setfflag("FFlagDisableSSAO", "True")
    setfflag("FFlagDisablePostFx", "True")
    setfflag("FFlagDisableBloom", "True")
    setfflag("FFlagDisableDepthOfField", "True")
    setfflag("FFlagDisableSunRays", "True")
    setfflag("FFlagDisableAntiAliasing", "True")
    setfflag("FFlagDisableMotionBlur", "True")
    setfflag("FFlagRenderShadowIntensity", "0")
    setfflag("FFlagRenderShadowIntensityOverride", "True")
    setfflag("FFlagDisableShadows", "True")
    setfflag("FFlagDebugSkyGray", "True")
    setfflag("FFlagDisableAtmosphere", "True")
    setfflag("FFlagDisableSky", "True")
    setfflag("FFlagDisableFog", "True")
    setfflag("FFlagDisableTerrainDecoration", "True")
    setfflag("FIntFRMMaxGrassDistance", "0")
    setfflag("DFIntCSGLevelOfDetailSwitchingDistance", "0")
    setfflag("FFlagDisableLODTransitions", "True")
    setfflag("FFlagForceLOD0", "True")
    setfflag("DFIntLODBias", "8")
    setfflag("DFFlagDebugRenderForceTechnologyVoxel", "True")
    setfflag("FFlagDebugPauseVoxelizer", "True")
    setfflag("DFIntSolverSpringDamping", "0")
    setfflag("DFIntMaxSimultaneousPhysicsJobs", "1")
    setfflag("DFIntPhysicsStepPerFrame", "1")
    setfflag("DFIntMaximumCollisionIterations", "1")
    setfflag("DFIntSolverConvergenceIterations", "1")
    setfflag("DFIntFrameBufferPoolSize", "1")
    setfflag("DFIntDebugEngineOptimizationLevel", "3")
end)

pcall(function()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01
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

-- ==================== ANTI-AFK ====================
task.spawn(function()
    while true do
        task.wait(60)
        pcall(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
        pcall(function()
            VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
            task.wait(0.1)
            VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
        end)
    end
end)

pcall(function()
    player.Idled:Connect(function()
        pcall(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end)
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
    elseif cn == "Part" or cn == "MeshPart" or cn == "UnionOperation" or cn == "WedgePart" then
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
        end)
    end
end)

task.spawn(function()
    while true do
        task.wait(45)
        pcall(function() collectgarbage("collect") end)
    end
end)

-- ==================== POPUP ====================
local sg = Instance.new("ScreenGui")
sg.Name = "KudoPopup"
sg.ResetOnSpawn = false
sg.IgnoreGuiInset = true
sg.DisplayOrder = 2147483647
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.Parent = uiParent

local popup = Instance.new("Frame")
popup.Size = UDim2.new(0, 380, 0, 150)
popup.Position = UDim2.new(0.5, -190, 0.4, -75)
popup.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
popup.BorderSizePixel = 0
popup.Active = false
popup.ZIndex = 1000
popup.ClipsDescendants = true
popup.Parent = sg
Instance.new("UICorner", popup).CornerRadius = UDim.new(0, 14)

-- ===== VIỀN ĐỎ CHẠY ĐƠN GIẢN - DÙNG 1 DẢI SÁNG CHẠY VÒNG BẰNG TWEEN POSITION =====
-- Cách: dùng 1 frame dài 60px di chuyển tuần tự 4 cạnh
local runner = Instance.new("Frame")
runner.Name = "Runner"
runner.Size = UDim2.new(0, 60, 0, 2)
runner.Position = UDim2.new(0, -60, 0, 0)
runner.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
runner.BorderSizePixel = 0
runner.ZIndex = 1001
runner.Active = false
runner.Parent = popup
Instance.new("UICorner", runner).CornerRadius = UDim.new(1, 0)

local runnerGlow = Instance.new("ImageLabel")
runnerGlow.Size = UDim2.new(1, 20, 1, 20)
runnerGlow.Position = UDim2.new(0, -10, 0, -10)
runnerGlow.BackgroundTransparency = 1
runnerGlow.Image = "rbxassetid://5028857472"
runnerGlow.ImageColor3 = Color3.fromRGB(255, 60, 60)
runnerGlow.ImageTransparency = 0.3
runnerGlow.ZIndex = 1000
runnerGlow.Parent = runner

task.spawn(function()
    while runner.Parent do
        -- Cạnh trên (0 - 1s): trái -> phải
        runner.Size = UDim2.new(0, 60, 0, 2)
        runner.Position = UDim2.new(0, -60, 0, 0)
        local t1 = TS:Create(runner, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            Position = UDim2.new(1, 0, 0, 0)
        })
        t1:Play()
        t1.Completed:Wait()

        -- Cạnh phải (0.5s): trên -> dưới
        runner.Size = UDim2.new(0, 2, 0, 60)
        runner.Position = UDim2.new(1, -2, 0, -60)
        local t2 = TS:Create(runner, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            Position = UDim2.new(1, -2, 1, 0)
        })
        t2:Play()
        t2.Completed:Wait()

        -- Cạnh dưới (1s): phải -> trái
        runner.Size = UDim2.new(0, 60, 0, 2)
        runner.Position = UDim2.new(1, 0, 1, -2)
        local t3 = TS:Create(runner, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            Position = UDim2.new(0, -60, 1, -2)
        })
        t3:Play()
        t3.Completed:Wait()

        -- Cạnh trái (0.5s): dưới -> trên
        runner.Size = UDim2.new(0, 2, 0, 60)
        runner.Position = UDim2.new(0, 0, 1, 0)
        local t4 = TS:Create(runner, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            Position = UDim2.new(0, 0, 0, -60)
        })
        t4:Play()
        t4.Completed:Wait()
    end
end)

-- NỘI DUNG POPUP
local iconWrap = Instance.new("Frame")
iconWrap.Size = UDim2.new(0, 52, 0, 52)
iconWrap.Position = UDim2.new(0, 20, 0, 22)
iconWrap.BackgroundColor3 = Color3.fromRGB(25, 15, 20)
iconWrap.BorderSizePixel = 0
iconWrap.ZIndex = 1010
iconWrap.Active = false
iconWrap.Parent = popup
Instance.new("UICorner", iconWrap).CornerRadius = UDim.new(1, 0)

local iconStroke = Instance.new("UIStroke")
iconStroke.Color = Color3.fromRGB(80, 50, 55)
iconStroke.Thickness = 1.5
iconStroke.Parent = iconWrap

local arcHolder = Instance.new("Frame")
arcHolder.Size = UDim2.new(0, 34, 0, 34)
arcHolder.Position = UDim2.new(0.5, -17, 0.5, -17)
arcHolder.BackgroundTransparency = 1
arcHolder.ZIndex = 1011
arcHolder.Active = false
arcHolder.Parent = iconWrap

local arcRing = Instance.new("Frame")
arcRing.Size = UDim2.new(1, 0, 1, 0)
arcRing.BackgroundTransparency = 1
arcRing.Active = false
arcRing.Parent = arcHolder
Instance.new("UICorner", arcRing).CornerRadius = UDim.new(1, 0)

local arcStroke = Instance.new("UIStroke")
arcStroke.Color = Color3.fromRGB(255, 255, 255)
arcStroke.Thickness = 3
arcStroke.Parent = arcRing

local mask1 = Instance.new("Frame")
mask1.Size = UDim2.new(0, 20, 0, 20)
mask1.Position = UDim2.new(0, -3, 0, -3)
mask1.BackgroundColor3 = Color3.fromRGB(25, 15, 20)
mask1.BorderSizePixel = 0
mask1.ZIndex = 1012
mask1.Active = false
mask1.Parent = arcHolder
Instance.new("UICorner", mask1).CornerRadius = UDim.new(0, 4)

local mask2 = Instance.new("Frame")
mask2.Size = UDim2.new(0, 20, 0, 20)
mask2.Position = UDim2.new(1, -17, 1, -17)
mask2.BackgroundColor3 = Color3.fromRGB(25, 15, 20)
mask2.BorderSizePixel = 0
mask2.ZIndex = 1012
mask2.Active = false
mask2.Parent = arcHolder
Instance.new("UICorner", mask2).CornerRadius = UDim.new(0, 4)

task.spawn(function()
    while arcHolder.Parent do
        arcHolder.Rotation = (arcHolder.Rotation + 12) % 360
        task.wait(0.03)
    end
end)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -200, 0, 26)
title.Position = UDim2.new(0, 88, 0, 22)
title.BackgroundTransparency = 1
title.Text = "fix lag + anti-afk v1.0"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(255, 100, 100)
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 1010
title.Active = false
title.Parent = popup

local checkMark = Instance.new("TextLabel")
checkMark.Size = UDim2.new(0, 24, 0, 26)
checkMark.Position = UDim2.new(1, -32, 0, 22)
checkMark.BackgroundTransparency = 1
checkMark.Text = "✓"
checkMark.Font = Enum.Font.GothamBold
checkMark.TextSize = 18
checkMark.TextColor3 = Color3.fromRGB(80, 255, 130)
checkMark.ZIndex = 1010
checkMark.Active = false
checkMark.Parent = popup

local sub = Instance.new("TextLabel")
sub.Size = UDim2.new(1, -180, 0, 18)
sub.Position = UDim2.new(0, 88, 0, 50)
sub.BackgroundTransparency = 1
sub.Text = "made by kudo29001"
sub.Font = Enum.Font.Gotham
sub.TextSize = 12
sub.TextColor3 = Color3.fromRGB(170, 170, 180)
sub.TextXAlignment = Enum.TextXAlignment.Left
sub.ZIndex = 1010
sub.Active = false
sub.Parent = popup

local percentL = Instance.new("TextLabel")
percentL.Size = UDim2.new(1, -40, 0, 22)
percentL.Position = UDim2.new(0, 20, 0, 82)
percentL.BackgroundTransparency = 1
percentL.Text = "0%"
percentL.Font = Enum.Font.GothamBold
percentL.TextSize = 16
percentL.TextColor3 = Color3.fromRGB(255, 130, 100)
percentL.ZIndex = 1010
percentL.Active = false
percentL.Parent = popup

local pBg = Instance.new("Frame")
pBg.Size = UDim2.new(1, -40, 0, 8)
pBg.Position = UDim2.new(0, 20, 0, 112)
pBg.BackgroundColor3 = Color3.fromRGB(40, 30, 35)
pBg.BorderSizePixel = 0
pBg.ZIndex = 1010
pBg.Active = false
pBg.Parent = popup
Instance.new("UICorner", pBg).CornerRadius = UDim.new(1, 0)

local pFill = Instance.new("Frame")
pFill.Size = UDim2.new(0, 0, 1, 0)
pFill.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
pFill.BorderSizePixel = 0
pFill.ZIndex = 1011
pFill.Active = false
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
    TS:Create(title, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
    TS:Create(checkMark, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
    TS:Create(sub, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
    TS:Create(percentL, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
    TS:Create(pBg, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
    TS:Create(pFill, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
    TS:Create(iconWrap, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
    TS:Create(arcStroke, TweenInfo.new(0.6), {Transparency = 1}):Play()
    TS:Create(mask1, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
    TS:Create(mask2, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
    TS:Create(iconStroke, TweenInfo.new(0.6), {Transparency = 1}):Play()
    TS:Create(runner, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
    task.wait(0.7)
    sg:Destroy()
end)

-- ==================== UI FPS/PING/TIME ====================
local stats = Instance.new("ScreenGui")
stats.Name = "KudoStats"
stats.ResetOnSpawn = false
stats.IgnoreGuiInset = true
stats.DisplayOrder = 2147483647
stats.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
stats.Parent = uiParent

local box = Instance.new("Frame")
box.Size = UDim2.new(0, 150, 0, 92)
box.Position = UDim2.new(1, -160, 1, -102)
box.AnchorPoint = Vector2.new(1, 0)
box.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
box.BackgroundTransparency = 0.4
box.BorderSizePixel = 0
box.Active = false
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
header.Active = false
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
    l.Active = false
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
    v.Active = false
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
credit.Active = false
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
closeB.ZIndex = 10
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
hideB.ZIndex = 10
hideB.Parent = box
Instance.new("UICorner", hideB).CornerRadius = UDim.new(1, 0)

local lockB = Instance.new("TextButton")
lockB.Size = UDim2.new(0, 22, 0, 22)
lockB.Position = UDim2.new(1, -78, 0, -3)
lockB.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
lockB.Text = "🔓"
lockB.Font = Enum.Font.GothamBold
lockB.TextSize = 11
lockB.TextColor3 = Color3.new(1, 1, 1)
lockB.BorderSizePixel = 0
lockB.ZIndex = 10
lockB.Parent = box
Instance.new("UICorner", lockB).CornerRadius = UDim.new(1, 0)

local opacityB = Instance.new("TextButton")
opacityB.Size = UDim2.new(0, 22, 0, 22)
opacityB.Position = UDim2.new(1, -104, 0, -3)
opacityB.BackgroundColor3 = Color3.fromRGB(80, 100, 200)
opacityB.Text = "◐"
opacityB.Font = Enum.Font.GothamBold
opacityB.TextSize = 13
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

-- ===== SLIDER ĐỘ MỜ =====
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
        if child:IsA("TextLabel") then
            child.TextTransparency = math.clamp(transparency * 0.9, 0, 1)
        elseif child:IsA("TextButton") then
            child.BackgroundTransparency = math.clamp(transparency * 0.5, 0, 0.7)
            child.TextTransparency = math.clamp(transparency * 0.7, 0, 0.8)
        end
    end
end

local draggingSlider = false
sliderKnob.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingSlider = true
    end
end)

UIS.InputChanged:Connect(function(i)
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

UIS.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingSlider = false
    end
end)

local sliderVisible = false
opacityB.MouseButton1Click:Connect(function()
    sliderVisible = not sliderVisible
    sliderPanel.Visible = sliderVisible
end)

applyOpacity(0.5)

-- ===== CHỮ V GÓC TRÁI DƯỚI =====
-- Dùng 1 TextLabel với ký tự "V", xoay 45 độ
-- Neo ở góc dưới trái, khít vào viền
local vMark = Instance.new("TextButton")
vMark.Size = UDim2.new(0, 20, 0, 20)
vMark.Position = UDim2.new(0, 0, 1, -20)
vMark.AnchorPoint = Vector2.new(0, 1)
vMark.BackgroundTransparency = 1
vMark.Text = "V"
vMark.Font = Enum.Font.GothamBold
vMark.TextSize = 14
vMark.TextColor3 = Color3.fromRGB(255, 255, 255)
vMark.TextTransparency = 0.3
vMark.Rotation = 45
vMark.BorderSizePixel = 0
vMark.ZIndex = 10
vMark.Parent = box

-- ===== NÚT HIỆN =====
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
    stats:Destroy()
    showSg:Destroy()
end)

-- ===== DRAG =====
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

UIS.InputChanged:Connect(function(i)
    if dragging and not locked then
        local d = i.Position - ds
        box.Position = UDim2.new(sp.X.Scale, sp.X.Offset + d.X, sp.Y.Scale, sp.Y.Offset + d.Y)
    end
end)

UIS.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- ===== RESIZE =====
local resizing = false
local rs, rss
vMark.InputBegan:Connect(function(i)
    if locked then return end
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        resizing = true
        rs = i.Position
        rss = box.Size
        dragging = false
    end
end)

UIS.InputChanged:Connect(function(i)
    if resizing and not locked then
        local d = i.Position - rs
        local nx = math.max(120, rss.X.Offset - d.X)
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

print("✅ fix lag + anti-afk v1.0 by kudo29001 loaded")