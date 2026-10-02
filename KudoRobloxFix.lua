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

for _, v in pairs(pg:GetChildren()) do
    if v.Name == "KudoPopup" or v.Name == "KudoStats" or v.Name == "KudoToggle" then
        v:Destroy()
    end
end

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
sg.DisplayOrder = 1000
sg.Parent = pg

local popup = Instance.new("Frame")
popup.Size = UDim2.new(0, 360, 0, 140)
popup.Position = UDim2.new(0.5, -180, 0.4, -70)
popup.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
popup.BorderSizePixel = 0
popup.Active = false
popup.ZIndex = 1000
popup.Parent = sg
Instance.new("UICorner", popup).CornerRadius = UDim.new(0, 14)

-- DẢI SÁNG ĐỎ CHẠY QUANH VIỀN
-- Cách làm: 4 frame sáng (trên/dưới/trái/phải) di chuyển tuần tự quanh viền
local lightThickness = 3

-- Cạnh trên (chạy từ trái sang phải)
local lightTop = Instance.new("Frame")
lightTop.Name = "LightTop"
lightTop.Size = UDim2.new(0, 60, 0, lightThickness)
lightTop.Position = UDim2.new(0, -60, 0, -1)
lightTop.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
lightTop.BorderSizePixel = 0
lightTop.ZIndex = 1001
lightTop.Active = false
lightTop.Parent = popup
Instance.new("UICorner", lightTop).CornerRadius = UDim.new(1, 0)

local lightTopGlow = Instance.new("ImageLabel")
lightTopGlow.Size = UDim2.new(1, 30, 1, 30)
lightTopGlow.Position = UDim2.new(0, -15, 0, -15)
lightTopGlow.BackgroundTransparency = 1
lightTopGlow.Image = "rbxassetid://5028857472"
lightTopGlow.ImageColor3 = Color3.fromRGB(255, 80, 80)
lightTopGlow.ImageTransparency = 0.3
lightTopGlow.ZIndex = 1000
lightTopGlow.Parent = lightTop

-- Cạnh phải (chạy từ trên xuống dưới)
local lightRight = Instance.new("Frame")
lightRight.Name = "LightRight"
lightRight.Size = UDim2.new(0, lightThickness, 0, 60)
lightRight.Position = UDim2.new(1, -1, 0, -60)
lightRight.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
lightRight.BorderSizePixel = 0
lightRight.ZIndex = 1001
lightRight.Active = false
lightRight.Parent = popup
Instance.new("UICorner", lightRight).CornerRadius = UDim.new(1, 0)

local lightRightGlow = Instance.new("ImageLabel")
lightRightGlow.Size = UDim2.new(1, 30, 1, 30)
lightRightGlow.Position = UDim2.new(0, -15, 0, -15)
lightRightGlow.BackgroundTransparency = 1
lightRightGlow.Image = "rbxassetid://5028857472"
lightRightGlow.ImageColor3 = Color3.fromRGB(255, 80, 80)
lightRightGlow.ImageTransparency = 0.3
lightRightGlow.ZIndex = 1000
lightRightGlow.Parent = lightRight

-- Cạnh dưới (chạy từ phải sang trái)
local lightBottom = Instance.new("Frame")
lightBottom.Name = "LightBottom"
lightBottom.Size = UDim2.new(0, 60, 0, lightThickness)
lightBottom.Position = UDim2.new(1, 0, 1, -lightThickness + 1)
lightBottom.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
lightBottom.BorderSizePixel = 0
lightBottom.ZIndex = 1001
lightBottom.Active = false
lightBottom.Parent = popup
Instance.new("UICorner", lightBottom).CornerRadius = UDim.new(1, 0)

local lightBottomGlow = Instance.new("ImageLabel")
lightBottomGlow.Size = UDim2.new(1, 30, 1, 30)
lightBottomGlow.Position = UDim2.new(0, -15, 0, -15)
lightBottomGlow.BackgroundTransparency = 1
lightBottomGlow.Image = "rbxassetid://5028857472"
lightBottomGlow.ImageColor3 = Color3.fromRGB(255, 80, 80)
lightBottomGlow.ImageTransparency = 0.3
lightBottomGlow.ZIndex = 1000
lightBottomGlow.Parent = lightBottom

-- Cạnh trái (chạy từ dưới lên trên)
local lightLeft = Instance.new("Frame")
lightLeft.Name = "LightLeft"
lightLeft.Size = UDim2.new(0, lightThickness, 0, 60)
lightLeft.Position = UDim2.new(0, -1, 1, 0)
lightLeft.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
lightLeft.BorderSizePixel = 0
lightLeft.ZIndex = 1001
lightLeft.Active = false
lightLeft.Parent = popup
Instance.new("UICorner", lightLeft).CornerRadius = UDim.new(1, 0)

local lightLeftGlow = Instance.new("ImageLabel")
lightLeftGlow.Size = UDim2.new(1, 30, 1, 30)
lightLeftGlow.Position = UDim2.new(0, -15, 0, -15)
lightLeftGlow.BackgroundTransparency = 1
lightLeftGlow.Image = "rbxassetid://5028857472"
lightLeftGlow.ImageColor3 = Color3.fromRGB(255, 80, 80)
lightLeftGlow.ImageTransparency = 0.3
lightLeftGlow.ZIndex = 1000
lightLeftGlow.Parent = lightLeft

-- Animation chạy dải sáng quanh viền
task.spawn(function()
    while popup.Parent do
        -- Trên: trái sang phải (0.8s)
        lightTop.Position = UDim2.new(0, -60, 0, -1)
        TS:Create(lightTop, TweenInfo.new(0.8, Enum.EasingStyle.Linear), {
            Position = UDim2.new(1, 0, 0, -1)
        }):Play()
        task.wait(0.8)

        -- Phải: trên xuống dưới (0.5s)
        lightRight.Position = UDim2.new(1, -1, 0, -60)
        TS:Create(lightRight, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            Position = UDim2.new(1, -1, 1, 0)
        }):Play()
        task.wait(0.5)

        -- Dưới: phải sang trái (0.8s)
        lightBottom.Position = UDim2.new(1, 0, 1, -lightThickness + 1)
        TS:Create(lightBottom, TweenInfo.new(0.8, Enum.EasingStyle.Linear), {
            Position = UDim2.new(0, -60, 1, -lightThickness + 1)
        }):Play()
        task.wait(0.8)

        -- Trái: dưới lên trên (0.5s)
        lightLeft.Position = UDim2.new(0, -1, 1, 0)
        TS:Create(lightLeft, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            Position = UDim2.new(0, -1, 0, -60)
        }):Play()
        task.wait(0.5)
    end
end)

-- NỘI DUNG POPUP
local iconWrap = Instance.new("Frame")
iconWrap.Size = UDim2.new(0, 52, 0, 52)
iconWrap.Position = UDim2.new(0, 20, 0, 22)
iconWrap.BackgroundColor3 = Color3.fromRGB(25, 15, 20)
iconWrap.BorderSizePixel = 0
iconWrap.ZIndex = 1002
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
arcHolder.ZIndex = 1003
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
mask1.ZIndex = 1004
mask1.Active = false
mask1.Parent = arcHolder
Instance.new("UICorner", mask1).CornerRadius = UDim.new(0, 4)

local mask2 = Instance.new("Frame")
mask2.Size = UDim2.new(0, 20, 0, 20)
mask2.Position = UDim2.new(1, -17, 1, -17)
mask2.BackgroundColor3 = Color3.fromRGB(25, 15, 20)
mask2.BorderSizePixel = 0
mask2.ZIndex = 1004
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
title.Size = UDim2.new(1, -180, 0, 26)
title.Position = UDim2.new(0, 88, 0, 22)
title.BackgroundTransparency = 1
title.Text = "fix lag v1.0"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255, 100, 100)
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 1002
title.Active = false
title.Parent = popup

local sub = Instance.new("TextLabel")
sub.Size = UDim2.new(1, -180, 0, 18)
sub.Position = UDim2.new(0, 88, 0, 50)
sub.BackgroundTransparency = 1
sub.Text = "by kudo29001 ⚡"
sub.Font = Enum.Font.Gotham
sub.TextSize = 12
sub.TextColor3 = Color3.fromRGB(170, 170, 180)
sub.TextXAlignment = Enum.TextXAlignment.Left
sub.ZIndex = 1002
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
percentL.ZIndex = 1002
percentL.Active = false
percentL.Parent = popup

local pBg = Instance.new("Frame")
pBg.Size = UDim2.new(1, -40, 0, 8)
pBg.Position = UDim2.new(0, 20, 0, 112)
pBg.BackgroundColor3 = Color3.fromRGB(40, 30, 35)
pBg.BorderSizePixel = 0
pBg.ZIndex = 1002
pBg.Active = false
pBg.Parent = popup
Instance.new("UICorner", pBg).CornerRadius = UDim.new(1, 0)

local pFill = Instance.new("Frame")
pFill.Size = UDim2.new(0, 0, 1, 0)
pFill.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
pFill.BorderSizePixel = 0
pFill.ZIndex = 1003
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
    TS:Create(sub, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
    TS:Create(percentL, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
    TS:Create(pBg, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
    TS:Create(pFill, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
    TS:Create(iconWrap, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
    TS:Create(arcStroke, TweenInfo.new(0.6), {Transparency = 1}):Play()
    TS:Create(mask1, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
    TS:Create(mask2, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
    TS:Create(iconStroke, TweenInfo.new(0.6), {Transparency = 1}):Play()
    TS:Create(lightTop, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
    TS:Create(lightRight, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
    TS:Create(lightBottom, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
    TS:Create(lightLeft, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
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
header.Active = true
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

local lockB = Instance.new("TextButton")
lockB.Size = UDim2.new(0, 22, 0, 22)
lockB.Position = UDim2.new(1, -78, 0, -3)
lockB.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
lockB.Text = "🔓"
lockB.Font = Enum.Font.GothamBold
lockB.TextSize = 11
lockB.TextColor3 = Color3.new(1, 1, 1)
lockB.BorderSizePixel = 0
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

local opacityLevels = {0.4, 0.55, 0.7, 0.85, 1}
local opacityIndex = 1

local function applyOpacity(v)
    box.BackgroundTransparency = v
    for _, child in ipairs(box:GetDescendants()) do
        if child:IsA("TextLabel") then
            if child.Name ~= "fpsValue" and child.Name ~= "pingValue" and child.Name ~= "timeValue" then
                child.TextTransparency = math.clamp(v - 0.4, 0, 0.5)
            end
        end
    end
    header.BackgroundTransparency = math.clamp(v + 0.3, 0, 1)
    bxStroke.Transparency = math.clamp(v + 0.2, 0, 1)
end

opacityB.MouseButton1Click:Connect(function()
    opacityIndex = opacityIndex + 1
    if opacityIndex > #opacityLevels then
        opacityIndex = 1
    end
    applyOpacity(opacityLevels[opacityIndex])
end)

applyOpacity(opacityLevels[opacityIndex])

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
vL.Active = false
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
vR.Active = false
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

local resizing = false
local rs, rss
resizeB.InputBegan:Connect(function(i)
    if locked then return end
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        resizing = true
        rs = i.Position
        rss = box.Size
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

print("✅ fix lag v1.0 by kudo29001 loaded")