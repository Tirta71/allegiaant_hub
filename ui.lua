local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()

local Window = Library:CreateWindow({
   Name = "Allegiaant Hub",
   LoadingTitle = "Grow A Garden",
   LoadingSubtitle = "Loading..."
})

local Tab = Window:CreateTab("Main", 4483362458)

Tab:CreateButton({
   Name = "Test Button",
   Callback = function()
      print("clicked")
   end,
})

Tab:CreateToggle({
   Name = "Auto Buy",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().AutoBuy = Value
   end,
})