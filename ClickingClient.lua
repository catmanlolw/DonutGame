--// Services \\ --
local RepStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Remotes = RepStorage:FindFirstChild("Remotes") -- Replicated Storage Variable

--// Donut Variables \\ --
local donutFolder = game.Workspace:WaitForChild("EatADonut")
local donutSpawn = donutFolder:WaitForChild("DonutSpawn")

local SFX = donutFolder:FindFirstChild("SFX")
local VFX = donutFolder:FindFirstChild("VFX")

--// Player Variables \\--
local player = Players.LocalPlayer
local PlayerGui = player.PlayerGui
local Mouse = player:GetMouse()

local GameplayUI = PlayerGui:FindFirstChild("GameplayUI")
local ServerMessage = GameplayUI:FindFirstChild("ServerMessage")

--[[Client Remote event that shows a crumbs vfx when player
	bites into the donut]]--
Remotes.Bite.OnClientEvent:Connect(function(Part,Position)
	local Target, Position = Part, Position

	if Target and Position then
		local donut = donutSpawn:FindFirstChild("donut")
		if donut and Target.Parent == donut then
			local DonutVFX = VFX:FindFirstChild("DonutVFX")
			if DonutVFX then
				local NeWDonutVFX = DonutVFX:Clone()
				
				NeWDonutVFX.Parent = game.Workspace
				
				NeWDonutVFX.DonutClick.Enabled = true
				NeWDonutVFX.Position = Position
				task.wait(0.4)
				NeWDonutVFX.DonutClick.Enabled = false
				task.wait(1)
				NeWDonutVFX:Destroy()
			end
		end
	end
end)
				
--[[Handles Server to client UI communication]]--
Remotes.Announce.OnClientEvent:Connect(function(Message)
	ServerMessage.Visible = true
	
	ServerMessage.Text = Message
	
	task.wait(2)
	
	ServerMessage.Visible = false
	
	ServerMessage.Text = ""
end)