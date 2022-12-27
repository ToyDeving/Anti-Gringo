local WorldTable = {}
for i, v in pairs(workspace:GetChildren()) do
	if v:IsA("Model") and not v:FindFirstChild("Humanoid") then
		table.insert(WorldTable, v)
	end
end
local Player = game.Players.LocalPlayer
local SizeConnection
local TargetConnections = {}
local IsSkill = false
local function Call()
	IsSkill = false	
	if SizeConnection then SizeConnection:Disconnect() SizeConnection = nil end
	SizeConnection = Player.PlayerGui.HUD.MainFrame.CDBack.E.Indicator:GetPropertyChangedSignal("Size"):Connect(function()
		if Player.PlayerGui.HUD.MainFrame.CDBack.E.Indicator.Size == UDim2.new(1,0,1,0) then
			IsSkill = true
			task.delay(0.45, function()
				IsSkill = false
			end)
		end
	end)
end
Call()

Player.CharacterAdded:Connect(function()
	task.delay(0.35, function()	
		Call()
	end)
end)

function ChildAdded(Child)
	task.delay(0.15, function()
		if Child:FindFirstChild("Humanoid") and Child:FindFirstChild("HumanoidRootPart") then
			local Connnection
			Connnection = Child.HumanoidRootPart.ChildAdded:Connect(function(added)
				local Lock = _G.CurrentLockTarget
				if Lock == nil or Lock ~= nil and Lock == added.Parent.Parent then
					if added.Name == "Motor6D" and added.Part0.Parent.Parent ~= nil and added.Part0.Parent.Parent.Name == Player.Name and string.find(Player.Character:WaitForChild("ServerControl").CurrentWep.Value, "Seidou") then
						if IsSkill then
							task.delay(0.45,function()
								local Anim = Instance.new("Animation")
								Anim.AnimationId = "rbxassetid://2881558870"
								Anim.Parent = Player.Character.HumanoidRootPart
								local Track = Player.Character.Humanoid:LoadAnimation(Anim)
								Track:Play()
								local ray = Ray.new(Player.Character.HumanoidRootPart.Position, Player.Character.HumanoidRootPart.CFrame.LookVector * 85)
								local part, position = workspace:FindPartOnRayWithWhitelist(ray, WorldTable)
								if not part then
									Player.Character.HumanoidRootPart.CFrame *= CFrame.new(0,0,-85)
								end
							end)
						end
					end
				end
			end)
			table.insert(TargetConnections, {Child, Connnection})
		end
	end)
end

function ChildRemoved(Child)
	for i, v in pairs(TargetConnections) do
		if i and v and v[1] == Child then
			v[2]:Disconnect()
			table.remove(TargetConnections, i)
		end
	end
end

function F(Child)
	if Child:FindFirstChild("Humanoid") and Child:FindFirstChild("HumanoidRootPart") then
		local Connnection
		Connnection = Child.HumanoidRootPart.ChildAdded:Connect(function(added)
			local Lock = _G.CurrentLockTarget
			if Lock == nil or Lock ~= nil and Lock == added.Parent.Parent then
				if added.Name == "Motor6D" and added.Part0.Parent.Parent ~= nil and added.Part0.Parent.Parent.Name == Player.Name and string.find(Player.Character:WaitForChild("ServerControl").CurrentWep.Value, "Seidou") then
					if IsSkill then
						task.delay(0.45,function()
							local Anim = Instance.new("Animation")
							Anim.AnimationId = "rbxassetid://2881558870"
							Anim.Parent = Player.Character.HumanoidRootPart
							local Track = Player.Character.Humanoid:LoadAnimation(Anim)
							Track:Play()
							local ray = Ray.new(Player.Character.HumanoidRootPart.Position, Player.Character.HumanoidRootPart.CFrame.LookVector * 85)
							local part, position = workspace:FindPartOnRayWithWhitelist(ray, WorldTable)
							if not part then
								Player.Character.HumanoidRootPart.CFrame *= CFrame.new(0,0,-85)
							end
						end)
					end
				end
			end
		end)
		table.insert(TargetConnections, {Child, Connnection})
	end
end

for i, Child in pairs(workspace:GetChildren()) do
	F(Child)
end

for i, Child in pairs(game.Workspace.NPCSpawns:GetDescendants()) do
	F(Child)
end

game.Workspace.ChildAdded:Connect(function(Child)
	ChildAdded(Child)
end)
game.Workspace.ChildRemoved:Connect(function(Child)
	ChildRemoved(Child)
end)
game.Workspace.NPCSpawns.DescendantAdded:Connect(function(Child)
	ChildAdded(Child)
end)
game.Workspace.NPCSpawns.DescendantRemoved:Connect(function(Child)
	ChildRemoved(Child)
end)
