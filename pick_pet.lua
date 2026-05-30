-- // AUTO PICK PET (TRUE CLEAN NO MISS 💀)

local player = game.Players.LocalPlayer

-- 🔥 GLOBAL CONTROL
getgenv().Allegiant = {
	Enabled = true
}

local remote = game.ReplicatedStorage.GameEvents:WaitForChild("PetsService")

local events = game.ReplicatedStorage.GameEvents
local cooldownEvent = events:WaitForChild("PetCooldownsUpdated")
local requestCooldown = events:WaitForChild("RequestPetCooldowns")

-- ======================
-- UID TARGET
-- ======================

local TargetUID = {
	["6435cb45-463a-41df-a5b4-0e452b5033cd"] = true,
	["27eb39cb-8612-456c-99da-ef2bf108df1d"] = true,
	["fb1ed7bc-4d18-44ef-88bb-8b2c1b6980fe"] = true,
	["26064a29-ca27-41d7-83af-ca18b591cee7"] = true,
	["7ae0900c-b3f3-4e61-b3f7-70a50ca978bd"] = true,
	["0ceb1788-aab4-4c46-a7fc-7b727406aad1"] = true,
	["5233097b-f27c-4363-9146-1f59f6fa866e"] = true,
	["b0d1ee43-2be1-4373-ab7d-03b6fc8b2515"] = true,
	["fb256ff4-a970-457d-abb7-ced0e89b1ba0"] = true,
	["9ca952ce-cae3-4f9c-97bf-3796f4171da0"] = true,
	["85883da7-c238-4fcc-9001-a12166462f1e"] = true,
	["f671f21d-c19a-4766-8c13-d57cdf6c8905"] = true,
}

-- ======================
-- MEMORY
-- ======================

local cache = {}
local lastSeen = {}
local processing = {}

-- ======================
-- REQUEST AWAL
-- ======================

requestCooldown:FireServer()

-- ======================
-- SAVE DATA SERVER
-- ======================

local function saveData(petID, time)
	local cleanID = tostring(petID):gsub("[{}]", "")
	if not TargetUID[cleanID] then return end
	
	cache[cleanID] = tonumber(time) or 0
	lastSeen[cleanID] = tick()
end

-- ======================
-- EVENT LISTENER
-- ======================

cooldownEvent.OnClientEvent:Connect(function(...)
	
	local args = {...}
	
	if #args == 2 and typeof(args[1]) ~= "table" then
		saveData(args[1], args[2])
		
	elseif #args == 1 and typeof(args[1]) == "table" then
		for petID, time in pairs(args[1]) do
			saveData(petID, time)
		end
	end
	
end)

-- ======================
-- MAIN LOOP (SMART 💀)
-- ======================

task.spawn(function()
	while true do
		
		-- 🔥 OFF = MATI TOTAL
		if not getgenv().Allegiant.Enabled then
			task.wait(2)
			continue
		end
		
		task.wait(1)
		
		for cleanID, time in pairs(cache) do
			
			-- ======================
			-- DETECT STUCK
			-- ======================
			
			local isStuck = false
			
			if tick() - (lastSeen[cleanID] or 0) > 4 then
				isStuck = true
			end
			
			-- ======================
			-- DEBUG (OPTIONAL)
			-- ======================
			
			if getgenv().Allegiant.Enabled and time <= 0 then
				print("🟡 READY:", cleanID)
			end
			
			-- ======================
			-- ACTION
			-- ======================
			
			if getgenv().Allegiant.Enabled and isStuck and not processing[cleanID] then
				
				processing[cleanID] = true
				
				if getgenv().Allegiant.Enabled then
					print("💀 STUCK → PICK:", cleanID)
				end
				
				task.spawn(function()
					
					for i = 1,10 do
						
						pcall(function()
							remote:FireServer("UnequipPet", "{"..cleanID.."}")
						end)
						
						task.wait(0.1)
						
					end
					
					task.wait(1.5)
					processing[cleanID] = nil
					
				end)
				
			end
			
		end
		
	end
end)

-- ======================
-- AUTO REFRESH (SMART)
-- ======================

task.spawn(function()
	while true do
		
		if getgenv().Allegiant.Enabled then
			requestCooldown:FireServer()
		end
		
		task.wait(5)
	end
end)