if not plugin then
	return
end

local CoreGui = game:GetService("CoreGui")

local GUI_NAME = "JumpToActionGui"

local function main()
	print("Running jump to action plugin!")

	local gui = CoreGui:FindFirstChild(GUI_NAME)
	if gui then
		print("Found previous gui, destroying")
		gui:Destroy()
	end

	gui = Instance.new("ScreenGui")
	gui.Name = GUI_NAME

	gui.AncestryChanged:connect(function(child, parent)
		if child == gui and parent == nil then
			print("Got gui will be destroyed!")
		end
	end)

	gui.Parent = CoreGui

	local action = plugin:CreatePluginAction("JumpToAction_Open", "Open jump to action", "Open the jump to action menu")

	action.Triggered:connect(function()
		print("Running jump to action menu")
	end)
end

main()
