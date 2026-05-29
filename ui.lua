-- // DUPE TOKEN UI + FORCE DISPLAY

local player = game:GetService("Players").LocalPlayer

local label = player.PlayerGui
	:WaitForChild("TradeTokenCurrency_UI")
	:WaitForChild("TradeTokens")
	:WaitForChild("TextLabel1")

local RunService = game:GetService("RunService")

-- ======================
-- GUI
-- ======================

local gui = Instance.new("ScreenGui", player.PlayerGui)

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,260,0,150)
frame.Position = UDim2.new(0.5,-130,0.5,-75)
frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
Instance.new("UICorner", frame)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,30)
title.Text = "💰 Allegiaant Hub"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1

local status = Instance.new("TextLabel", frame)
status.Size = UDim2.new(1,0,0,20)
status.Position = UDim2.new(0,0,0.3,0)
status.Text = "Ready"
status.TextColor3 = Color3.fromRGB(180,180,180)
status.BackgroundTransparency = 1

local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(0.8,0,0,35)
btn.Position = UDim2.new(0.1,0,0.6,0)
btn.Text = "DUPE TOKEN"
btn.BackgroundColor3 = Color3.fromRGB(30,120,30)
btn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", btn)

-- ======================
-- DUPE LOGIC
-- ======================

local active = false
local fakeAmount = 100

btn.MouseButton1Click:Connect(function()
	if active then return end
	active = true
	
	status.Text = "Bypassing..."
	task.wait(0.5)
	
	status.Text = "Injecting..."
	task.wait(0.5)
	
	status.Text = "Success! +25,000"

	-- tambah fake amount
	fakeAmount += 25000

	-- floating text
	local txt = Instance.new("TextLabel", gui)
	txt.Size = UDim2.new(0,150,0,50)
	txt.AnchorPoint = Vector2.new(0.5,0.5)
	txt.Position = UDim2.new(0.5,0,0.3,0)

	txt.Text = "+25,000"
	txt.TextColor3 = Color3.fromRGB(0,255,100)
	txt.TextStrokeTransparency = 0.3
	txt.BackgroundTransparency = 1
	txt.TextScaled = true

	task.spawn(function()
		for i = 1,50 do
			txt.Position = txt.Position - UDim2.new(0,0,0.005,0)
			txt.TextTransparency = i/50
			task.wait(0.02)
		end
		txt:Destroy()
	end)

	task.wait(1)
	active = false
end)

-- ======================
-- FORCE DISPLAY (ANTI BALIK)
-- ======================

RunService.RenderStepped:Connect(function()
	label.Text = tostring(fakeAmount)
end)