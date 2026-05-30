getgenv().Allegiant = {
	Enabled = true
}

-- 🔔 NOTIF
loadstring(game:HttpGet("https://raw.githubusercontent.com/Tirta71/allegiaant_hub/main/notify.lua"))()(
	"⚡ Allegiant Hub",
	"Auto Pick Loaded Successfully",
	5
)

-- 🎮 UI (toggle)
loadstring(game:HttpGet("https://raw.githubusercontent.com/Tirta71/allegiaant_hub/main/ui.lua"))()

-- 💀 SYSTEM
loadstring(game:HttpGet("https://raw.githubusercontent.com/Tirta71/allegiaant_hub/main/pick_pet.lua"))()