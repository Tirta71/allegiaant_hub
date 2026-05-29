-- // FORCE TOKEN DISPLAY + FORMAT KOMA

local player = game:GetService("Players").LocalPlayer

local label = player:WaitForChild("PlayerGui")
	:WaitForChild("TradeTokenCurrency_UI")
	:WaitForChild("TradeTokens")
	:WaitForChild("TextLabel1")

local RunService = game:GetService("RunService")

local fakeAmount = 99999999

-- fungsi format koma
local function formatNumber(n)
	return tostring(n):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
end

RunService.RenderStepped:Connect(function()
	label.Text = formatNumber(fakeAmount)
end)