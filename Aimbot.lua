-- سكريبت Aimbot لـ Delta
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local TargetPart = "Head"

local function GetClosestPlayer()
    local target = nil
    local shortestDistance = math.huge
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild(TargetPart) then
            local humanoid = player.Character:FindFirstChild("Humanoid")
            if humanoid and humanoid.Health > 0 then
                local part = player.Character[TargetPart]
                local pos, onScreen = Camera:WorldToViewportPoint(part.Position)

                if onScreen then
                    local screenPos = Vector2.new(pos.X, pos.Y)
                    local distance = (screenPos - screenCenter).Magnitude

                    if distance < shortestDistance then
                        shortestDistance = distance
                        target = part
                    end
                end
            end
        end
    end
    return target
end

RunService.RenderStepped:Connect(function()
    local targetPart = GetClosestPlayer()
    if targetPart then
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPart.Position)
    end
end)

print("Delta Script Loaded Successfully!")
