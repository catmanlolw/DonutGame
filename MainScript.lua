--// Variables \\ --

local RepStorage = game:GetService("ReplicatedStorage")
local Remotes = RepStorage:FindFirstChild("Remotes")
local Assets = RepStorage:FindFirstChild("Assets")

local DonutFolder = game.Workspace:FindFirstChild("EatADonut")
local DonutSpawn = DonutFolder:FindFirstChild("DonutSpawn")

local SFX = DonutFolder:FindFirstChild("SFX")
local VFX = DonutFolder:FindFirstChild("VFX")

local count = 0

--// Functions \\ --

local function Click(Player, Part)
	Remotes.Bite:FireAllClients(Part, Part.Position) -- Remote event for vfx
	SFX.EatClick:Play() -- plays sound xd
	Part:Destroy()


	--[[If statement below is finding players data 
		via leaderstats to add bites and money
		per bite the player takes]]--
	local leaderstats = Player:FindFirstChild("leaderstats")
	if leaderstats then
		local Bites = leaderstats:FindFirstChild("Bites")
		local BiteBucks = Player:FindFirstChild("BiteBucks")
		Bites.Value += 1
		BiteBucks.Value += 1
	end
end
--// Main Code \\--
while wait(1) do
	
	--[[Announce remote event updates UI to keep player updated in current events]]--
	
	Remotes.Announce:FireAllClients("Donut Loading!") 
	
	--Spawning in donut for players to devour
	local Donut = Assets:FindFirstChild("donut")
	local NewDonut = Donut:Clone()
	NewDonut.Parent = DonutSpawn

	SFX.DonutSpawn:Play()
	Remotes.Announce:FireAllClients("Donut Incoming!")
	
	--[[using pairs loop to set up donut so players can eat it
		a connection is made between the clickdectector and function above]]--
	for _, v in ipairs(NewDonut:GetChildren()) do
		if v:FindFirstChild("ClickDetector") then
			local Clicker = v.ClickDetector
			Clicker.Parent = v
			Clicker.MaxActivationDistance = 20

			connection = Clicker.MouseClick:Connect(function(Player)
				Click(Player, Clicker.Parent)
			end)
		end
	end
	--[[Repeat loop that waits until the donut is fully eaten]]--
	repeat
		wait(2)
		if DonutSpawn:FindFirstChild("donut") then
			if #DonutSpawn:FindFirstChild("donut"):GetChildren() == 0 then
				NewDonut:Destroy()
			end
		end
	until NewDonut == nil or #DonutSpawn:GetChildren() == 0 

	connection:Disconnect() --disconnecting any connections to prevent memory leaks :D
end
