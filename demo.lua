local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Tạo GUI menu
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ESPMenu"
screenGui.Parent = game.CoreGui

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 300, 0, 400)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.BackgroundTransparency = 0.5
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.new(1, 1, 1)

local titleLabel = Instance.new("TextLabel", frame)
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "ESP Menu"
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextScaled = true

-- Danh sách người chơi
local playerList = Instance.new("ScrollingFrame", frame)
playerList.Size = UDim2.new(1, 0, 1, -50)
playerList.Position = UDim2.new(0, 0, 0, 50)
playerList.BackgroundTransparency = 1
playerList.CanvasSize = UDim2.new(0, 0, 5, 0)

-- Hàm tạo item trong menu
local function createPlayerItem(player)
    local item = Instance.new("TextLabel", playerList)
    item.Size = UDim2.new(1, -10, 0, 30)
    item.Position = UDim2.new(0, 5, 0, (#playerList:GetChildren() - 1) * 35)
    item.BackgroundTransparency = 0.5
    item.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    item.TextColor3 = Color3.new(1, 1, 1)
    item.Font = Enum.Font.SourceSans
    item.TextScaled = true
    item.Text = "Loading..."
    item.Name = player.Name

    return item
end

-- Cập nhật thông tin trong menu
local function updatePlayerInfo()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local character = player.Character
            local item = playerList:FindFirstChild(player.Name)
            
            if character and character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("Humanoid") then
                local humanoid = character.Humanoid
                local rootPart = character.HumanoidRootPart

                -- Tính khoảng cách
                local distance = (LocalPlayer.Character.HumanoidRootPart.Position - rootPart.Position).Magnitude

                -- Hiển thị thông tin
                if item then
                    item.Text = string.format("%s | HP: %d | Distance: %d", player.Name, math.floor(humanoid.Health), math.floor(distance))
                else
                    createPlayerItem(player)
                end
            end
        end
    end
end

-- Tạo ESP menu cho mỗi người chơi
Players.PlayerAdded:Connect(function(player)
    createPlayerItem(player)
end)

-- Xóa item khi người chơi rời server
Players.PlayerRemoving:Connect(function(player)
    local item = playerList:FindFirstChild(player.Name)
    if item then
        item:Destroy()
    end
end)

-- Cập nhật liên tục thông tin
RunService.RenderStepped:Connect(updatePlayerInfo)
