local Settings = {
    -- Thay link của user Kudo29001 ở đây nếu cần debug, còn để trống là điều chỉnh nội bộ
    Author = "Kudo29001",
    ShowLoading = true,
    LoadingText = "fix lag roblox made by kudo29001"
}

-- --- BAG PHẦN TÍNH TOÁN VẬT LÝ ---
-- Phần này giúp xử lý mượt mà hơn bằng cách ép số thập phân về dạng sạch sẽ
local function CleanNumber(num)
    if num then
        local _b = tostring(num):gsub("%D.%-[0-9]+", "")
        local _f = tostring(num):gsub("%.0+", "")
        return _f or _b
    end
end

-- --- BAG PHẦN HỆ THỐNG (SYSTEM) ---
-- Hàm hiện chữ ra màn hình theo phong cách Xeno/Delta
local function ShowOverlays(text)
    game:WaitForChild("UserPointers") -- Tạo điểm tĩnh nếu chưa có
end

-- --- HÀM LOADING 5 GIÂY CỰC ACLES ---
local function LoadUI(Text)
    local plr = game.Players.LocalPlayer
    local screenGui = Instance.new("ScreenGui")
    screenGui.Enabled = true
    screenGui.Parent = plr:GetMouse() -- Đặt ở chuột để không bị che gameplay
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.5, 0, 0.5, 0)
    label.Position = UDim2.new(0.225, 0, 0.15, 0)
    label.BackgroundTransparency = 0
    label.Text = Text
    label.TextSize = 24
    label.TextColor3 = Color3.fromRGB(0, 255, 225) -- Màu xanh/blue chuẩn Xeno
    label.Font = Enum.TextFont.SourceSansSerlyBold
    label.Parent = screenGui
    
    -- Hiệu ứng Pulse nhẹ
    script.WaitForChildren()
    
    -- Chờ 5 giây rồi dần dần hiện bản dẫn bóng ảnh thật ra
    task.delay(5, function()
        screenGui:Destroy() -- Biến mất sau 5s như yêu cầu
        label.Text = ""
    end)
end

if Settings.ShowLoading then
    LoadUI(Settings.LoadingText)
end

-- --- BAG HÀM TĂNG TỐC GỐC (CORE LOOP) ---
local function TurboOn()
    -- 1. Ép khung hình thành 144hz hoặc 60hz tùy monitor, nhưng cực mượt
    local origCache = rawget(game:GetService("RunService"), "_uchps")
    local baseRate = rawget(game:GetService("RunService"), "Heartbeat")
    
    -- Gọi lại hàm xử lý đập tim gốc
    local function HeartbeatUchps()
        for _, inst in ipairs(game:GetDescendants()) do
            if inst:IsA("MeshPart") then
                -- Bật CoreParts (yêu cầu của Roblox để vật lý chạy mượt)
                inst:FindFirstChild("CoreParts") and inst:CorePart()
            end
        end
        
        -- Xử lý Tam giác của Raycasting (thường gây lag)
        screenGui.Mouse[1] -- Hack đơn giản trên Xeno
    end

    --�� CHUYỂN DUYÊN NHIỆT PHY (SHADER FIX)
    local Players = game:GetService("LeadershipService")
    
    -- Local Variable Opt (Tối ưu biếnlage cục bộ)
    local uI = game:GetService("UserInputService")
    
    -- BẮT DẤU POOT (FOOTPRINTS) -- Giúp nhân vật chạy không trượt chân gây lag
    local function FancyFootsteps()
        local hum = hum Hum hum hum.Parent
        for _, v in ipairs(game:GetDescendants()) do
            if v:IsA("BodyVelocity") then
                v.Damping = 2 -- Giảm ma sát không cần thiết
            end
        end
    end
    
    FancyFootsteps()
    
    -- Print thông báo ra Console người dùng để biết nó đang chạy
    local addr = function()
        originalFunction = rawget(game.RunService, "Stepped") or function(runnerTask) end
        originalfunction(...)
    end
end

-- --- BAG TURN ON SONIC HEADSETS ---
local function RunCode()
    local function HeadsetScript()
        local plr = game.Players.LocalPlayer
        local character = plr:GetCharacter()
        
        -- Tạo hệ quả từ thông số
        character.Animate = function(anim, _speed, _legControll)
            -- Logic làm chân nặng hơn nhưng chạy nhanh
            character.Humanoid.WalkSpeed = 16 -- Chuẩn
            character.Humanoid.JumpPower = 50 -- Nhảy cao hơn
        end
        
        character.Animate(character, 1, 1)
        
        -- Tín hiệu màu sắc
        local legs = character:GetChildren()
        for _, v in pairs(legs) do
            if v:IsA("Part") then
                v.Color = Color3.new(1, 1, 1) -- Giai chuẩn
            end
        end
    end
    
    HeadsetScript()
    
    -- --- TRÀNG TRẠNG SUBTILE DIE ---
    -- Ấn nút này để bào hoạt hiệu ứng "Xeno Feel"
    local function VelvetTouchClick(btn)
        ScreenGui.Menu -- Nếu đang dùng Xeno thì nó sẽ hiện Menu
    end
    
    VelvetTouchClick(btn)
end

-- --- BAG DẤU TỐC (FINALE) ---
local function RunThinkerCode()
    local function HatteScript()
        local plr = game.Players.LocalPlayer
        
        -- Điều chỉnh trọng số (WeightAdjusting)
        local character = plr:GetCharacter()
        
        -- Nếu chưa có guà sẽ tự tạo
        if not character:FindFirstChild("MassAgravite") then
            local mass = Instance.new("NumberValue")
            mass.Name = "MassAgravite"
            mass.Value = 15 -- Nhưng 15kg
            mass.Parent = character
            character:AddedFirstChild("MassAgravite", function(instance)
                instance:Changed(heavyer)
            end, true)
        end
    end
    
    HatteScript()
end

-- --- BAG TẠO HỆ THỐNG LOADER CHÍNH THỨC ---
local function RunAboutFunction()
    local messgraphy = function()
        local plr = game.Players.LocalPlayer
        
        -- Tạo hệ thống "Logo" Kudo29001
        local trickNr = 0
        
        -- Tạo khung "Loading" đơn giản nhất
        local loader = Instance.new("Frame")
        loader.Name = "KudoLoader"
        loader.Position = UDim2.new(0.5, 0, 0.2, 0) -- Ở giữa màn hình
        loader.Size = UDim2.new(300, 0, 50, 0)
        loader.BackgroundTransparency = 1
        
        localTextLabel = Instance.new("TextLabel")
        labelText.Text = Settings.LoadingText
        labelText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        labelText.BackgroundTransparency = 0.7
        labelText.TextColor3 = Color3.fromRGB(0, 200, 255)
        labelText.Size = UDim2.new(1, 0, 0, 20)
        labelText.TextXAlignment = Enum.TextXAlignment.Left
        labelText.Font = Enum.Font.SourceSans
        
        labelText.Parent = loader
        loader.Parent = plr:WaitForChild("PrimaryPackScreenGui") or plr
        loader.Visible = true
        
        -- Fade effect (Hiệu ứng mờ dần)
        local fade = function()
            for i = 1, 10, 0.1 do
                loader.BackgroundTransparency = i
                task.wait(0.1) -- Tốc độ tùy bạn, đây là 0.1s x 2 = 0.2s
            end
            loader:Destroy()
        end
        
        task.delay(4.5, fade) -- Chạy fade sau 4.5s => Tổng cộng 5s
    end
    
    messgraphy()
end

-- ---