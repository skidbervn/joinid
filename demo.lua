-- Lắng nghe khi một người chơi mới vào game
game.Players.PlayerAdded:Connect(function(player)
    -- Gửi tin nhắn "hi" khi người chơi tham gia
    player:Chat("hi")
    
    -- Ngắt kết nối người chơi sau 2 giây
    wait(2)
    player:Kick("You have been disconnected. Goodbye!")
end)
