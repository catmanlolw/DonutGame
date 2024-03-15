--// Services \\ --
local Players = game:GetService("Players")
local RepStorage = game:GetService("ReplicatedStorage")
local RS = game:GetService("RunService")
local DSS = game:GetService("DataStoreService")
local ServerStorage = game:GetService("ServerStorage")
local playerData = DSS:GetDataStore("PlayerData")


--// Module Variables \\ --
local Modules = RepStorage:FindFirstChild("Modules")
local DataModule = require(Modules.PlayerOtherData)


Players.PlayerAdded:Connect(function(Player)
	local success, err = pcall(function()
		repeat wait() until Player.Character
		--[[Creates Data Values]]--
		local leaderstats = Instance.new("Folder")
		leaderstats.Parent = Player
		leaderstats.Name = "leaderstats"

		local Donuts = Instance.new("IntValue")
		Donuts.Parent = leaderstats
		Donuts.Name = "Donuts"

		local BiteBucks = Instance.new("IntValue")
		BiteBucks.Parent = Player
		BiteBucks.Name = "BiteBucks"
		local Bites = Instance.new("IntValue")
		Bites.Parent = leaderstats
		Bites.Name = "Bites"
		
		--[[Players Data]]--
		local playerid = "Player_" .. Player.UserId
		local data = playerData:GetAsync(playerid)
		
		--[[Player has data then we load all that is saved. 
			Otherwise, We just set them to default amounts]]--
		if data then
			Donuts.Value = data['Donuts']
			BiteBucks.Value = data['BiteBucks']
			Bites.Value = data['Bites']
			DataModule.PlayerTable[Player.Name] = {
				["Islands"] = data['Islands'];
				["Gamepasses"] = data['Gamepasses'];
			}
		else
			Donuts.Value = 0
			Bites.Value = 0
			
			DataModule.PlayerTable[Player.Name] = {
				["Islands"] = {
					["Island1"] = false,
					["Island2"] = false
				};
				["Gamepasses"] = {

				};
			}
		end
	end)
end)


--[[PlayerRemoving saves players data when they leave the game]]--
game.Players.PlayerRemoving:Connect(function(player)
	if player and player:FindFirstChild("leaderstats") then
		
		local DataTable = DataModule.PlayerTable

		local PlayersTable = DataTable[player.Name]

		local Data = {
			Donuts = player.leaderstats.Donuts.Value;
			BiteBucks = player.BiteBucks.Value;
			Bites = player.leaderstats.Bites.Value;
			Islands = PlayersTable.Islands;
			Gamepasses = PlayersTable.Gamepasses;
		}
		local playerid = "Player_" .. player.UserId
		local success, err = pcall(function()
			playerData:SetAsync(playerid,Data)
		end)
		if success then
			print("data saved!")
		else
			print("data faield to save!")
		end
	end
end)