getgenv().AutoBuy = false

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Remove old UI
pcall(function()
    PlayerGui:FindFirstChild("AllegiaantHub"):Destroy()
end)

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AllegiaantHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Main Frame
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 420, 0, 260)
Main.Position = UDim2.new(0.5, -210, 0.5, -130)
Main.BackgroundColor3 = Color3.fromRGB(18,18,18)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

Instance.new("UICorner", Main).CornerRadius = UDim.new(0,12)

-- Shadow
local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(40,40,40)
Stroke.Thickness = 1.5
Stroke.Parent = Main

-- Topbar
local Topbar = Instance.new("Frame")
Topbar.Size = UDim2.new(1,0,0,40)
Topbar.BackgroundColor3 = Color3.fromRGB(24,24,24)
Topbar.BorderSizePixel = 0
Topbar.Parent = Main

Instance.new("UICorner", Topbar).CornerRadius = UDim.new(0,12)

-- Fix corner bottom
local Fix = Instance.new("Frame")
Fix.Size = UDim2.new(1,0,0,12)
Fix.Position = UDim2.new(0,0,1,-12)
Fix.BackgroundColor3 = Color3.fromRGB(24,24,24)
Fix.BorderSizePixel = 0
Fix.Parent = Topbar

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,1,0)
Title.BackgroundTransparency = 1
Title.Text = "Allegiaant Hub"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = Topbar

-- Content
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1,-20,1,-60)
Content.Position = UDim2.new(0,10,0,50)
Content.BackgroundTransparency = 1
Content.Parent = Main

-- Auto Buy Button
local AutoBuy = Instance.new("TextButton")
AutoBuy.Size = UDim2.new(1,0,0,45)
AutoBuy.BackgroundColor3 = Color3.fromRGB(30,30,30)
AutoBuy.Text = "Auto Buy : OFF"
AutoBuy.TextColor3 = Color3.fromRGB(255,255,255)
AutoBuy.Font = Enum.Font.GothamBold
AutoBuy.TextSize = 15
AutoBuy.Parent = Content

Instance.new("UICorner", AutoBuy).CornerRadius = UDim.new(0,10)

-- Tween Hover
local function Hover(Button)
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button,TweenInfo.new(0.15),{
            BackgroundColor3 = Color3.fromRGB(40,40,40)
        }):Play()
    end)

    Button.MouseLeave:Connect(function()
        TweenService:Create(Button,TweenInfo.new(0.15),{
            BackgroundColor3 = Color3.fromRGB(30,30,30)
        }):Play()
    end)
end

Hover(AutoBuy)

-- Toggle
AutoBuy.MouseButton1Click:Connect(function()
    getgenv().AutoBuy = not getgenv().AutoBuy

    if getgenv().AutoBuy then
        AutoBuy.Text = "Auto Buy : ON"
    else
        AutoBuy.Text = "Auto Buy : OFF"
    end
end)

-- Dragging
local dragging
local dragInput
local dragStart
local startPos

local UIS = game:GetService("UserInputService")

local function update(input)
    local delta = input.Position - dragStart
    Main.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

Topbar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Topbar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)