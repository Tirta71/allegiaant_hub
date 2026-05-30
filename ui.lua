-- ======================
-- ALLEGIANT UI (FINAL 💀)
-- ======================

local UIS = game:GetService("UserInputService")

-- 🔥 PASTIKAN GLOBAL ADA
getgenv().Allegiant = getgenv().Allegiant or {
	Enabled = true
}

-- ======================
-- UI BASE
-- ======================

local gui = Instance.new("ScreenGui")
gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,230,0,110)
main.Position = UDim2.new(0,20,0,200)
main.BackgroundColor3 = Color3.fromRGB(18,18,18)

Instance.new("UICorner", main)

-- 🔥 BORDER
local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(255,200,0)
stroke.Thickness = 1.5

-- ======================
-- TITLE
-- ======================

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,25)
title.Text = "⚡ Allegiant Hub"
title.TextColor3 = Color3.fromRGB(255,200,0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14

-- ======================
-- STATUS
-- ======================

local status = Instance.new("TextLabel", main)
status.Position = UDim2.new(0,0,0,30)
status.Size = UDim2.new(1,0,0,20)
status.BackgroundTransparency = 1
status.TextColor3 = Color3.new(1,1,1)
status.Font = Enum.Font.Gotham
status.TextSize = 13

-- ======================
-- BUTTON
-- ======================

local btn = Instance.new("TextButton", main)
btn.Position = UDim2.new(0,15,0,60)
btn.Size = UDim2.new(1,-30,0,30)
btn.Text = "TOGGLE"
btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 13

Instance.new("UICorner", btn)

-- ======================
-- UPDATE UI FUNCTION
-- ======================

local function updateUI()
	
	local state = getgenv().Allegiant.Enabled
	
	status.Text = state and "AUTO PICK: ON" or "AUTO PICK: OFF"
	
	btn.BackgroundColor3 = state
		and Color3.fromRGB(60,120,60)
		or Color3.fromRGB(120,40,40)
		
end

-- INIT STATE
updateUI()

-- ======================
-- TOGGLE LOGIC
-- ======================

btn.MouseButton1Click:Connect(function()
	
	getgenv().Allegiant.Enabled = not getgenv().Allegiant.Enabled
	
	updateUI()
	
end)

-- ======================
-- DRAG SYSTEM 💀
-- ======================

local dragging, dragInput, dragStart, startPos

main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

main.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UIS.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		
		local delta = input.Position - dragStart
		
		main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)