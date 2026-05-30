local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

return function(Title, Text, Duration)

	Duration = Duration or 5

	local gui = Instance.new("ScreenGui")
	gui.Name = "AllegiantNotification"
	gui.ResetOnSpawn = false
	gui.Parent = CoreGui

	local frame = Instance.new("Frame")
	frame.Parent = gui
	frame.Size = UDim2.new(0, 320, 0, 85)
	frame.Position = UDim2.new(1, 350, 1, -120)
	frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
	frame.BorderSizePixel = 0

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0,12)
	corner.Parent = frame

	local stroke = Instance.new("UIStroke")
	stroke.Parent = frame
	stroke.Color = Color3.fromRGB(255,170,0)
	stroke.Thickness = 1.5

	local titleLabel = Instance.new("TextLabel")
	titleLabel.Parent = frame
	titleLabel.BackgroundTransparency = 1
	titleLabel.Position = UDim2.new(0,15,0,8)
	titleLabel.Size = UDim2.new(1,-20,0,22)
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextSize = 16
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.TextColor3 = Color3.fromRGB(255,170,0)
	titleLabel.Text = Title

	local descLabel = Instance.new("TextLabel")
	descLabel.Parent = frame
	descLabel.BackgroundTransparency = 1
	descLabel.Position = UDim2.new(0,15,0,32)
	descLabel.Size = UDim2.new(1,-25,0,35)
	descLabel.Font = Enum.Font.Gotham
	descLabel.TextSize = 13
	descLabel.TextWrapped = true
	descLabel.TextXAlignment = Enum.TextXAlignment.Left
	descLabel.TextYAlignment = Enum.TextYAlignment.Top
	descLabel.TextColor3 = Color3.fromRGB(255,255,255)
	descLabel.Text = Text

	local barBG = Instance.new("Frame")
	barBG.Parent = frame
	barBG.Size = UDim2.new(1,0,0,3)
	barBG.Position = UDim2.new(0,0,1,-3)
	barBG.BorderSizePixel = 0
	barBG.BackgroundColor3 = Color3.fromRGB(40,40,40)

	local bar = Instance.new("Frame")
	bar.Parent = barBG
	bar.Size = UDim2.new(1,0,1,0)
	bar.BorderSizePixel = 0
	bar.BackgroundColor3 = Color3.fromRGB(255,170,0)

	TweenService:Create(
		frame,
		TweenInfo.new(0.4, Enum.EasingStyle.Quint),
		{
			Position = UDim2.new(1,-340,1,-120)
		}
	):Play()

	TweenService:Create(
		bar,
		TweenInfo.new(Duration, Enum.EasingStyle.Linear),
		{
			Size = UDim2.new(0,0,1,0)
		}
	):Play()

	task.delay(Duration,function()

		local tween = TweenService:Create(
			frame,
			TweenInfo.new(0.4, Enum.EasingStyle.Quint),
			{
				Position = UDim2.new(1,350,1,-120)
			}
		)

		tween:Play()
		tween.Completed:Wait()

		gui:Destroy()

	end)

end