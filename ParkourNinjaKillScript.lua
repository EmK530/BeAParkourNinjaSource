local range = 6
local leastdistance = nil
local leastdistancecharacter = nil
local laststring = nil
local hitbox = Instance.new("Part")
local targetY = nil
local currentY = nil
local lastkill = nil
hitbox.Shape = Enum.PartType.Ball
hitbox.Size = Vector3.new(range,range,range)
hitbox.Color = Color3.fromRGB(255,0,0)
hitbox.Transparency = 0.9
hitbox.CanCollide = false
hitbox.Anchored = true
hitbox.BottomSurface = Enum.SurfaceType.Smooth
hitbox.TopSurface = Enum.SurfaceType.Smooth
hitbox.Parent = game.Workspace
game:GetService("RunService").RenderStepped:Connect(function()
	local name = game.Players.LocalPlayer.Name
	if game.Workspace:FindFirstChild(name) and game.Workspace[name]:FindFirstChild("Humanoid") then
		game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 47
	end
	if game.Workspace:FindFirstChild(name) and game.Workspace:FindFirstChild(name):FindFirstChild("HumanoidRootPart") then
		hitbox.CFrame = game.Workspace:FindFirstChild(name):FindFirstChild("HumanoidRootPart").CFrame
	end
	if game.Workspace:FindFirstChild(name) and game.Workspace:FindFirstChild(name):FindFirstChild("Katana") then
		hitbox.Transparency = 0.9
	else
		hitbox.Transparency = 1
	end
end)

local target
game:GetService("RunService").RenderStepped:Connect(function(step)
	local name = game.Players.LocalPlayer.Name
	if game.Workspace:FindFirstChild(name) and game.Workspace:FindFirstChild(name):FindFirstChild("Humanoid") and game.Workspace:FindFirstChild(name):FindFirstChild("Humanoid").Health ~= 0 then
	for i = 1, #game.Players:GetChildren() do
		target = game.Players:GetChildren()[math.random(1, #game.Players:GetChildren())]
		if game.Players:FindFirstChild(target.Name) and target.Name ~= game.Players.LocalPlayer.Name and game.Workspace:FindFirstChild(target.Name) and game.Workspace:FindFirstChild(target.Name):FindFirstChild("HumanoidRootPart") and game.Workspace:FindFirstChild(target.Name):FindFirstChild("Humanoid") and game.Workspace:FindFirstChild(target.Name).Humanoid.Health ~= 0 and game.Workspace:FindFirstChild(target.Name):FindFirstChild("ForceField") == nil then
			local char = game.Workspace:FindFirstChild(target.Name)
			if leastdistancecharacter ~= nil then
				if not leastdistancecharacter:FindFirstChild("HumanoidRootPart") then
					leastdistance = nil
					leastdistancecharacter = nil
				elseif leastdistancecharacter:FindFirstChild("Humanoid").Health == 0 then
					leastdistance = nil
					leastdistancecharacter = nil
				elseif leastdistancecharacter:FindFirstChild("ForceField") then
					leastdistance = nil
					leastdistancecharacter = nil
				end
			end
			if leastdistance == nil then
				leastdistance = (char.HumanoidRootPart.CFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position).magnitude
				leastdistancecharacter = char
			else
				if leastdistance > (char.HumanoidRootPart.CFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position).magnitude then
					leastdistance = (char.HumanoidRootPart.CFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position).magnitude
					leastdistancecharacter = char
				end
			end
			--game.Players.LocalPlayer.Character.Humanoid:MoveTo(leastdistancecharacter.HumanoidRootPart.Position)
			if currentY == nil then
				currentY = game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y
			end
			targetY = leastdistancecharacter.HumanoidRootPart.Position.Y
			if currentY < targetY then
				currentY = currentY + step*7
			elseif currentY > targetY then
				currentY = currentY - step*7
			end
			local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
			--hrp.CFrame = CFrame.new(hrp.Position.X, currentY, hrp.Position.Z)
			hrp.CFrame = CFrame.new(hrp.Position, leastdistancecharacter.HumanoidRootPart.Position)
			hrp.CFrame = hrp.CFrame * CFrame.new(0,0,-0.1)
			if laststring ~= ("Moving towards "..leastdistancecharacter.Name) then
				print("Moving towards "..leastdistancecharacter.Name)
				laststring = ("Moving towards "..leastdistancecharacter.Name)
			end
			if (char.HumanoidRootPart.CFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position).magnitude < range and not char:FindFirstChild("ForceField") then
				local Arguments = {
					[1] = char.Humanoid,
					[2] = game.Players.LocalPlayer.Character.Katana
				}
				if lastkill ~= char.Name then
					game.ReplicatedStorage.RemoteTriggers.Bolster:FireServer(unpack(Arguments))
                			game.ReplicatedStorage.RemoteTriggers.Bolster:FireServer(unpack(Arguments))
                			game.ReplicatedStorage.RemoteTriggers.Bolster:FireServer(unpack(Arguments))
					game.ReplicatedStorage.RemoteTriggers.Bolster:FireServer(unpack(Arguments))
                			game.ReplicatedStorage.RemoteTriggers.Bolster:FireServer(unpack(Arguments))
					warn("Killed "..char.Name)
					lastkill = char.Name
				end
			end 
		end
	end
	end
end)