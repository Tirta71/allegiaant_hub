-- // SEED HUB V2 (MODERN UI)

if _G.SeedHubV2 then return end
_G.SeedHubV2 = true

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer

local BuySeedStock = ReplicatedStorage
	:WaitForChild("GameEvents")
	:WaitForChild("BuySeedStock")

local SeedData = require(ReplicatedStorage.Data.SeedData)

-- SETTINGS
local AutoBuy = false
local DelayPerBuy = 0.4
local RefreshTime = 300

local SelectedSeeds = {}
local ValidSeeds = {}
local Tested = false

-- ================= UI =================

local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "SeedHubV2"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,280,0,350)
main.Position = UDim2.new(0,100,0,200)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
Instance.new("UICorner", main).CornerRadius = UDim.new(0,10)

-- title
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,35)
title.Text = "🌱 Seed Hub V2"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.BackgroundTransparency = 1

-- toggle
local toggle = Instance.new("TextButton", main)
toggle.Size = UDim2.new(0.9,0,0,30)
toggle.Position = UDim2.new(0.05,0,0,40)
toggle.Text = "AUTO: OFF"
toggle.BackgroundColor3 = Color3.fromRGB(35,35,35)
toggle.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", toggle)

-- status
local status = Instance.new("TextLabel", main)
status.Size = UDim2.new(1,0,0,20)
status.Position = UDim2.new(0,0,0,75)
status.Text = "Status: Idle"
status.TextColor3 = Color3.fromRGB(180,180,180)
status.BackgroundTransparency = 1

-- buttons
local selectAll = Instance.new("TextButton", main)
selectAll.Size = UDim2.new(0.45,0,0,25)
selectAll.Position = UDim2.new(0.05,0,0,100)
selectAll.Text = "Select All"
selectAll.BackgroundColor3 = Color3.fromRGB(40,40,40)
selectAll.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", selectAll)

local clearAll = Instance.new("TextButton", main)
clearAll.Size = UDim2.new(0.45,0,0,25)
clearAll.Position = UDim2.new(0.5,0,0,100)
clearAll.Text = "Clear All"
clearAll.BackgroundColor3 = Color3.fromRGB(40,40,40)
clearAll.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", clearAll)

-- scroll
local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(0.9,0,1,-140)
scroll.Position = UDim2.new(0.05,0,0,130)
scroll.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", scroll)

-- ================= SEED LIST =================

for name,_ in pairs(SeedData) do
	local btn = Instance.new("TextButton", scroll)
	btn.Size = UDim2.new(1,0,0,25)
	btn.Text = "[ ] "..name
	btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
	btn.TextColor3 = Color3.new(1,1,1)
	Instance.new("UICorner", btn)

	SelectedSeeds[name] = false

	btn.MouseButton1Click:Connect(function()
		SelectedSeeds[name] = not SelectedSeeds[name]
		btn.Text = (SelectedSeeds[name] and "[✔] " or "[ ] ")..name
	end)
end

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	scroll.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y)
end)

-- ================= BUTTON LOGIC =================

toggle.MouseButton1Click:Connect(function()
	AutoBuy = not AutoBuy
	toggle.Text = "AUTO: "..(AutoBuy and "ON" or "OFF")
end)

selectAll.MouseButton1Click:Connect(function()
	for k,_ in pairs(SelectedSeeds) do
		SelectedSeeds[k] = true
	end
end)

clearAll.MouseButton1Click:Connect(function()
	for k,_ in pairs(SelectedSeeds) do
		SelectedSeeds[k] = false
	end
end)

-- ================= LOGIC =================

local function GetCoins()
	local ls = player:FindFirstChild("leaderstats")
	local coins = ls and ls:FindFirstChild("Coins")
	return coins and coins.Value or 0
end

local function TestSeeds()
	status.Text = "Status: Testing..."
	
	for name,_ in pairs(SeedData) do
		
		if not SelectedSeeds[name] then continue end
		
		local before = GetCoins()

		BuySeedStock:FireServer("Shop", name)
		task.wait(DelayPerBuy)

		if GetCoins() < before then
			ValidSeeds[name] = true
		end
	end

	Tested = true
end

local function BuySeeds()
	status.Text = "Status: Buying..."

	for name,_ in pairs(ValidSeeds) do
		if SelectedSeeds[name] then
			BuySeedStock:FireServer("Shop", name)
			task.wait(DelayPerBuy)
		end
	end

	status.Text = "Status: Done"
end

-- ================= LOOP =================

task.spawn(function()
	while true do
		if AutoBuy then
			if not Tested then
				TestSeeds()
			else
				BuySeeds()
			end
		else
			status.Text = "Status: Idle"
		end

		task.wait(RefreshTime)
	end
end)

-- ================= DRAG =================

local dragging, dragStart, startPos

main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging then
		local delta = input.Position - dragStart
		main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)