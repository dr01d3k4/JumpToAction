-- Because there is no way for plugins to know they're being deleted, CoreGui gets flooded with old UIs
-- Run this to delete all the unnecessary ones
local whitelist = {
	JumpToActionGui = true,
	["Rojo 0.4.12 UI"] = true,
}

for _, o in ipairs(game:GetService("CoreGui"):GetChildren()) do
	if not whitelist[o.Name] then
		o:Destroy()
	end
end
