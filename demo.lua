-- Script gửi tin nhắn và ngắt kết nối người chơi
game.Players.PlayerAdded:Connect(function(player)
    -- Gửi tin nhắn "hi" khi người chơi tham gia
    player:Chat("hi")
    
    -- Ngắt kết nối người chơi sau 2 giây
    wait(2)
    player:Kick("You have been disconnected. Goodbye!")
end)
