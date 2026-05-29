-- // AUTO PICK PET (UI + UID + TOGGLE + NO CD FIX)

local player = game.Players.LocalPlayer
local remote = game.ReplicatedStorage.GameEvents:WaitForChild("PetsService")

local petUI = player.PlayerGui
	:WaitForChild("ActivePetUI")
	.Frame.Main.PetDisplay.ScrollingFrame

-- ======================
-- UID TARGET (PAKAI {})
-- ======================

local TargetUID = {
	["{6435cb45-463a-41df-a5b4-0e452b5033cd}"] = true,
	["{27eb39cb-8612-456c-99da-ef2bf108df1d}"] = true,
	["{fb1ed7bc-4d18-44ef-88bb-8b2c1b6980fe}"] = true,
	["{26064a29-ca27-41d7-83af-ca18b591cee7}"] = true,
	["{7ae0900c-b3f3-4e61-b3f7-70a50ca978bd}"] = true,
	["{0ceb1788-aab4-4c46-a7fc-7b727406aad1}"] = true,
	["{5233097b-f27c-4363-9146-1f59f6fa866e}"] = true,
	["{b0d1ee43-2be1-4373-ab7d-03b6fc8b2515}"] = true,
	["{fb256ff4-a970-457d-abb7-ced0e89b1ba0}"] = true,
	["{9ca952ce-cae3-4f9c-97bf-3796f4171da0}"] = true,
	["{85883da7-c238-4fcc-9001-a12166462f1e}"] = true,
	["{f671f21d-c19a-4766-8c13-d57cdf6c8905}"] = true,
}

-- ======================
-- TOGGLE UI
-- ======================

local enabled = false

local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

local btn = Instance.new("TextButton")
btn.Parent = gui
btn.Size = UDim2.new(0,150,0,40)
btn.Position = UDim2.new(0,20,0,200)
btn.Text = "AUTO PICK: OFF"
btn.BackgroundColor3 = Color3.fromRGB(120,30,30)
btn.TextColor3 = Color3.new(1,1,1)

btn.MouseButton1Click:Connect(function()
	enabled = not enabled
	
	btn.Text = enabled and "AUTO PICK: ON" or "AUTO PICK: OFF"
	btn.BackgroundColor3 = enabled
		and Color3.fromRGB(30,120,30)
		or Color3.fromRGB(120,30,30)
end)

-- ======================
-- MAIN LOOP
-- ======================

task.spawn(function()
	while true do
		
		if enabled then
			
			for _, petFrame in pairs(petUI:GetChildren()) do
				
				if petFrame.Name ~= "PetTemplate" then
					
					local main = petFrame:FindFirstChild("Main")
					
					if main then
						
						local dropdown = petFrame:FindFirstChild("Dropdown")
						
						-- 🔥 CHECK COOLDOWN OBJECT
						local cd = main:FindFirstChild("Cooldowns")
							and main.Cooldowns:FindFirstChild("COOLDOWN_1")
							and main.Cooldowns.COOLDOWN_1:FindFirstChild("COOLDOWN_NAME")
						
						-- ======================
						-- 🔥 FINAL CONDITION
						-- ======================
						
						if dropdown 
							and dropdown.Visible 
							and TargetUID[petFrame.Name]
							and not cd then -- 🔥 NO CD (object ilang)
							
							local petID = petFrame.Name
							
							print("🔥 NO CD → UNEQUIP:", petID)
							
							pcall(function()
								remote:FireServer("UnequipPet", petID)
							end)
							
							task.wait(0.5)
							
						else
							if cd then
								print("⏳ MASIH CD:", petFrame.Name)
							end
						end
						
					end
					
				end
				
			end
			
		end
		
		task.wait(1)
	end
end)