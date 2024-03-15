
--// Services \\--
local TweenService = game:GetService("TweenService")
local RepStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

--// Replicated Storage Variables \\--
local Assets = RepStorage:FindFirstChild("Assets")
local Remotes = RepStorage:FindFirstChild("Remotes")

--// Player Variables \\--
local Player = Players.LocalPlayer
local PlayerGUI = Player.PlayerGui

local GameplayUI = PlayerGUI:FindFirstChild("GameplayUI")
local PlayerUI = PlayerGUI:FindFirstChild("PlayerUI")

local BitesAmnt = PlayerUI.BitesAmount
local BitesBar = PlayerUI.BitesBar
local Adder = BitesBar.Adder

local Sm2 = GameplayUI.Sm2


--// Functions \\--

--[[Function below fills a bar based
	on how much bite bucks the player
	needs to buy the next island
	]]--
local function UpdateBiteBar(MaxBiteBucks,BiteBucks)
	local MaxBiteBucks = MaxBiteBucks
	local BiteBucks = BiteBucks
	local fillRatio = BiteBucks / MaxBiteBucks

	local fillSize = UDim2.new(fillRatio, 0, 1, 0)
	local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear)
	TweenService:Create(Adder, tweenInfo, {Size = fillSize}):Play()
end

repeat wait() until Player.Character -- waiting for character cuz we in a locally local script 


local BiteBucks = Player:FindFirstChild("BiteBucks")

--[[Using Run service to constantly have UI updated]]--
game["Run Service"].RenderStepped:Connect(function()
	BitesAmnt.Text = tostring(BiteBucks.Value).." BiteBucks"
	
	if (5000-BiteBucks.Value) <= 0 then
		Sm2.Text = "You have reached enough to go to the next Island!"
	else
		Sm2.Text = tostring(5000-BiteBucks.Value).." to unlock the next island"
	end
	
	if BiteBucks.Value <= 5000 then
		UpdateBiteBar(5000, BiteBucks.Value)
	end
end)