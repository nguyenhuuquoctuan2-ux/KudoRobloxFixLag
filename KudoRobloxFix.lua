local player = game.Players.LocalPlayer
local pg = player:WaitForChild("PlayerGui")

-- Xoá UI cũ
for _, v in pairs(pg:GetChildren()) do
    if v.Name == "KudoPopup" or v.Name == "KudoStats" then
        v:Destroy()
    end
end

-- POPUP
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

-- VÒNG TRÒN RỖNG XOAY (chỉ viền)
local spinnerOuter = Instance.new("Frame")
spinnerOuter.Size = UDim2.new(0, 52, 0, 52)
spinnerOuter.Position = UDim2.new(0, 20, 0, 22)
spinnerOuter.BackgroundTransparency = 1
spinnerOuter.Parent = popup

local baseRing = Instance.new("Frame")
baseRing.Size = UDim2.new(1, 0, 1, 0)
baseRing.BackgroundTransparency = 1
baseRing.Parent = spinnerOuter
Instance.new("UICorner", baseRing).CornerRadius = UDim.new(1, 0)

local baseStroke = Instance.new("UIStroke")
baseStroke.Color = Color3.fromRGB(60, 40, 45)
baseStroke.Thickness = 2
baseStroke.Parent = baseRing

local spinRing = Instance.new("Frame")
spinRing.Size = UDim2.new(1, 0, 1, 0)
spinRing.BackgroundTransparency = 1
spinRing.Parent = spinnerOuter
Instance.new("UICorner", spinRing).CornerRadius = UDim.new(1, 0)

local spinStroke = Instance.new("UIStroke")
spinStroke.Color = Color3.fromRGB(255, 80, 80)
spinStroke.Thickness = 3
spinStroke.Parent = spinRing

task.spawn(function()
    while spinRing.Parent do
        spinRing.Rotation = (spinRing.Rotation + 15) % 360
        task.wait(0.03)
    end
end)

-- TEXT
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

-- Load 0-100
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

task.delay(5, function()
    pcall(function() sg:Destroy() end)
end)

-- UI FPS/PING/TIME
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

local function mkLabel(text, y)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(0, 40, 0, 16)
    l.Position = UDim2.new(0, 10, 0, y)
    l.BackgroundTransparency = 1
    l.Text = text
    l.Font = Enum.Font.GothamBold
    l.TextSize = 10
    l.TextColor3 = Color3.fromRGB(180, 180, 180)
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = box
    return l
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

-- Nút X
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

-- Nút ẩn
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

-- Chữ V GÓC TRÁI DƯỚI trong UI
local resizeB = Instance.new("TextButton")
resizeB.Size = UDim2.new(0, 22, 0, 22)
resizeB.Position = UDim2.new(0, 4, 1, -24)
resizeB.BackgroundTransparency = 1
resizeB.Text = ""
resizeB.BorderSizePixel = 0
resizeB.Parent = box

local vL = Instance.new("Frame")
vL.Size = UDim2.new(0, 2, 0, 10)
vL.Position = UDim2.new(0, 6, 0, 8)
vL.AnchorPoint = Vector2.new(0.5, 0.5)
vL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
vL.BackgroundTransparency = 0.3
vL.BorderSizePixel = 0
vL.Rotation = -45
vL.Parent = resizeB
Instance.new("UICorner", vL).CornerRadius = UDim.new(1, 0)

local vR = Instance.new("Frame")
vR.Size = UDim2.new(0, 2, 0, 10)
vR.Position = UDim2.new(0, 14, 0, 8)
vR.AnchorPoint = Vector2.new(0.5, 0.5)
vR.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
vR.BackgroundTransparency = 0.3
vR.BorderSizePixel = 0
vR.Rotation = 45
vR.Parent = resizeB
Instance.new("UICorner", vR).CornerRadius = UDim.new(1, 0)

-- Nút hiện
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

-- Drag
local dragging = false
local ds, sp
header.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        ds = i.Position
        sp = box.Position
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(i)
    if dragging then
        local d = i.Position - ds
        box.Position = UDim2.new(sp.X.Scale, sp.X.Offset + d.X, sp.Y.Scale, sp.Y.Offset + d.Y)
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Resize
local resizing = false
local rs, rss
resizeB.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        resizing = true
        rs = i.Position
        rss = box.Size
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(i)
    if resizing then
        local d = i.Position - rs
        local nx = math.max(120, rss.X.Offset + d.X)
        local ny = math.max(80, rss.Y.Offset + d.Y)
        box.Size = UDim2.new(0, nx, 0, ny)
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        resizing = false
    end
end)

-- Timer
local st = tick()
task.spawn(function()
    while stats.Parent do
        task.wait(1)
        local e = math.floor(tick() - st)
        timeV.Text = string.format("%02d:%02d", math.floor(e / 60), e % 60)
    end
end)

-- FPS
local fr = 0
game:GetService("RunService").RenderStepped:Connect(function()
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
            p = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
        end)
        pingV.Text = p .. "ms"
        if p <= 100 then
            pingV.TextColor3 = Color3.fromRGB(0, 255, 120)
        else
            pingV.TextColor3 = Color3.fromRGB(255, 60, 60)
        end
    end
end)

print("✅ loaded")