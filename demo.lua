-- Hàm tạo ESP cho từng người chơi
local function createESP(player)
    -- Kiểm tra xem player có nhân vật và HumanoidRootPart không
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        -- Tạo BillboardGui để hiển thị trên nhân vật
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "ESP"
        billboard.Adornee = player.Character.HumanoidRootPart
        billboard.Size = UDim2.new(2, 0, 2, 0)
        billboard.AlwaysOnTop = true

        -- Tạo TextLabel để hiển thị thông tin
        local textLabel = Instance.new("TextLabel", billboard)
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.TextColor3 = Color3.new(1, 0, 0) -- Màu đỏ
        textLabel.TextStrokeTransparency = 0.5
        textLabel.TextScaled = true
        textLabel.Font = Enum.Font.SourceSansBold

        -- Thêm thông tin: Tên người chơi và máu
        local humanoid = player.Character:FindFirstChild("Humanoid")
        if humanoid then
            textLabel.Text = player.Name .. "\nHP: " .. math.floor(humanoid.Health) .. "/" .. humanoid.MaxHealth
        end

        -- Gắn BillboardGui vào nhân vật
        billboard.Parent = player.Character.HumanoidRootPart
    end
end

-- Hàm theo dõi và cập nhật thông tin
local function updateESP()
    for _, player in pairs(game.Players:GetPlayers()) do
        -- Kiểm tra nếu ESP đã tồn tại
        if player.Character and not player.Character:FindFirstChild("ESP") then
            createESP(player)
        end
    end
end

-- Kết nối sự kiện khi người chơi tham gia
game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        wait(1) -- Chờ nhân vật tải xong
        createESP(player)
    end)
end)

-- Cập nhật liên tục thông tin của ESP
while wait(1) do
    updateESP()
end
