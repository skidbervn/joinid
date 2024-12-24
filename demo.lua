local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player.PlayerGui)
local frame = Instance.new("Frame", gui)
local inputBox = Instance.new("TextBox", frame)
local joinButton = Instance.new("TextButton", frame)
local closeButton = Instance.new("TextButton", frame)

frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.Active = true
frame.Draggable = true  -- Cho phép kéo GUI

inputBox.Size = UDim2.new(0, 200, 0, 50)
inputBox.Position = UDim2.new(0.5, -100, 0.2, 0)
inputBox.PlaceholderText = "Enter Join ID"
inputBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

joinButton.Size = UDim2.new(0, 200, 0, 50)
joinButton.Position = UDim2.new(0.5, -100, 0.7, 0)
joinButton.Text = "Join Server"
joinButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

-- Tạo nút đóng (X)
closeButton.Size = UDim2.new(0, 50, 0, 50)
closeButton.Position = UDim2.new(1, -50, 0, 0)
closeButton.Text = "X"
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

-- Sự kiện khi bấm nút join
joinButton.MouseButton1Click:Connect(function()
    local joinID = inputBox.Text

    -- Kiểm tra nếu Join ID có hợp lệ hay không
    if joinID ~= "" then
        -- Gửi yêu cầu teleport đến server với Join ID đã nhập
        local success, err = pcall(function()
            ReplicatedStorage.__ServerBrowser:InvokeServer("teleport", joinID)
        end)

        -- Kiểm tra kết quả thành công hay thất bại
        if success then
            print("Đã tham gia vào server với ID: " .. joinID)
        else
            warn("Không thể tham gia server: " .. err)
        end
    else
        warn("Vui lòng nhập Join ID hợp lệ!")
    end
end)

-- Sự kiện khi bấm nút đóng (X)
closeButton.MouseButton1Click:Connect(function()
    gui:Destroy()  -- Xóa GUI khi bấm nút X
end)
