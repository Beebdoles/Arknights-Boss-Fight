--disable

--importing services--
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local StarterGUI = game:GetService("StarterGui")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

--basic imports--

local character = script.Parent
local humanoid = character.Parent;
local humanoidRootPart = character:WaitForChild("humanoidRootPart")
local player = Players.LocalPlayer

--adjustable variables--
local humanoidWalkSpeed = 5
local humanoidRunSpeed = 15

--utility things ig--
local mouse = player:GetMouse()

local DashTime = 0.150
local Amount = 50
local MaxForce = Vector3.new(math.huge, math.huge, math.huge)
local P = 100
local Cooldown = false
local CooldownTime = 2

--Events--

local BindableEvent = ReplicatedStorage:WaitForChild("BindableEvent")

--the rest of the cancer--

UserInputService.InputBegan:Connect(function(input, e)
    if input.KeyCode == Enum.KeyCode.F then

        Cooldown = true
        humanoid:SetAttribute("Stamina", humanoid:GetAttribute("Stamina") - 15)
        
        local BodyVelocity = Instance.new("BodyVelocity")
        BodyVelocity.Parent = script.Parent:FindFirstChild("Torso")
        BodyVelocity.P = P
        BodyVelocity.MaxForce = MaxForce
        BodyVelocity.Velocity = humanoid.MoveDirection * Amount
        script:FindFirstChild("Dash"):Play()

        Debris:AddItem(BodyVelocity, DashTime)

        local startTime = tick()
        local condition = true

        while condition do
            local PlayerBody = ReplicatedStorage:FindFirstChild("Shadow"):Clone()
            PlayerBody.Parent = workspace
            PlayerBody:SetPrimaryPartCFrame(humanoidRootPart.CFrame)
            Debris:AddItem(PlayerBody, 0.5)

            local endTime = tick()
            if endTime - startTime >= DashTime then
                condition = false
            end
            task.wait(0.05)
        end
        
        BindableEvent:Fire("Dash", CooldownTime)
        task.wait(CooldownTime)
        Cooldown = false
    end

    if input.KeyCode == Enum.KeyCode.LeftControl then
        --toggle sprint

        if humanoid.WalkSpeed == humanoidRunSpeed then
            humanoid.WalkSpeed = humanoidWalkSpeed
            --play walk anim
        else
            humanoidWalkSpeed = humanoidRunSpeed
            --play run anim
        end
    end

    if input.KeyCode == Enum.KeyCode.Z then
        --heal
    end

    if input.KeyCode == Enum.KeyCode.E then
        --special ability
    end
end)

UserInputService.InputEnded:Connect(function(input, e)
    if 
end)


humanoid.WalkSpeed = 5