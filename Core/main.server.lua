if not plugin then
	return
end

local Plugin = script.Parent.Parent

local Roact = require(Plugin.Libs.Roact)

local JumpToAction = require(Plugin.Core.Components.JumpToAction)

local DataSource = require(Plugin.Core.DataSource)

local CoreGui = game:GetService("CoreGui")

local GUI_NAME = "JumpToActionGui"

local function main()
	local gui
	local handle
	local dataSource

	-- Maybe unmount the component if it exists
	local function onCloseGui()
		if handle then
			Roact.unmount(handle)
			handle = nil
		end

		if gui then
			gui.Enabled = false
		end
	end

	local function onClosePlugin()
		onCloseGui()

		if dataSource then
			dataSource:destroy()
			dataSource = nil
		end
	end

	-- If we already have an existing gui (such as if the plugin reloaded)
	-- Then destroy it
	gui = CoreGui:FindFirstChild(GUI_NAME)
	if gui then
		gui:Destroy()
	end

	-- Create a new screen gui for the plugin
	gui = Instance.new("ScreenGui")
	gui.Name = GUI_NAME
	gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	gui.Enabled = false

	-- When the gui gets destroyed, close the plugin
	gui.AncestryChanged:connect(function(child, parent)
		if child == gui and parent == nil then
			onClosePlugin()
		end
	end)

	gui.Parent = CoreGui

	dataSource = DataSource.new()

	-- Start plugin on key press
	local action = plugin:CreatePluginAction("JumpToAction_Open", "Open jump to action", "Open the jump to action menu")
	action.Triggered:connect(function()
		-- Toggle gui open
		if handle then
			onCloseGui()
		else
			local component = Roact.createElement(JumpToAction, {
				dataSource = dataSource,
			})
			gui.Enabled = true
			handle = Roact.mount(component, gui, "JumpToAction")
		end
	end)
end

main()
