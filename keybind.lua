local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Mouse = LocalPlayer:GetMouse()

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.MouseButton3 then -- Middle mouse button
        local mousePos = Mouse.Hit.Position
        HumanoidRootPart.CFrame = CFrame.new(mousePos.X, mousePos.Y, mousePos.Z)
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.H then
        local mousePos = Mouse.Hit.Position
        local direction = (mousePos - HumanoidRootPart.Position).Unit

        -- Keep Y rotation only, ignore vertical tilt
        local lookAt = CFrame.new(HumanoidRootPart.Position, Vector3.new(mousePos.X, HumanoidRootPart.Position.Y, mousePos.Z))
        HumanoidRootPart.CFrame = lookAt
    end
end)
getgenv().Speed = 200



local SPEED = getgenv().Speed -- studs per second
local moving = false

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.K then
        moving = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.K then
        moving = false
    end
end)

RunService.Heartbeat:Connect(function(deltaTime)
    if moving and HumanoidRootPart then
        local mousePos = Mouse.Hit.Position
        local direction = (mousePos - HumanoidRootPart.Position)
        direction = Vector3.new(direction.X, 0, direction.Z) -- keep it flat, no floating up/down
        local distance = direction.Magnitude

        if distance > 1 then
            local moveDelta = math.min(SPEED * deltaTime, distance)
            local moveVector = direction.Unit * moveDelta
            HumanoidRootPart.CFrame = HumanoidRootPart.CFrame + moveVector
        end
    end
end)
