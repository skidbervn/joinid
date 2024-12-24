local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = game:GetService("Workspace").CurrentCamera

-- Tạo một GUI chứa thông tin ESP
local function createESP(player)
    -- Tạo phần tử GUI cho tên người chơi
    local espLabel = Instance.new("TextLabel")
    espLabel.Parent = game.Players.LocalPlayer.PlayerGui:WaitForChild("ScreenGui")
    espLabel.Size = UDim2.new(0, 100, 0, 50)
    espLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    espLabel.BackgroundTransparency = 1
    espLabel.TextSize = 18
    espLabel.Text = player.Name

    -- Cập nhật vị trí của label dựa trên vị trí người chơi trong thế giới
    local function updateESP()
        local character = player.Character
        if character and character:FindFirstChild("Head") then
            local headPosition = character.Head.Position
            local screenPosition, onScreen = Camera:WorldToViewportPoint(headPosition)

            if onScreen then
                espLabel.Position = UDim2.new(0, screenPosition.X, 0, screenPosition.Y)
                espLabel.Visible = true
            else
                espLabel.Visible = false
            end
        end
    end

    -- Cập nhật liên tục
    RunService.RenderStepped:Connect(updateESP)
end

-- Gọi hàm createESP cho mỗi người chơi
Players.PlayerAdded:Connect(function(player)
    -- Kiểm tra nếu người chơi có nhân vật
    player.CharacterAdded:Connect(function(character)
        createESP(player)
    end)
end)
