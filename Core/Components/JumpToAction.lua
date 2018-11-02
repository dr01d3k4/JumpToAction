local Plugin = script.Parent.Parent.Parent

local Roact = require(Plugin.Libs.Roact)

local SearchBar = require(Plugin.Core.Components.SearchBar)

local JumpToAction = Roact.PureComponent:extend("JumpToAction")

-- TODO: Set up constants somewhere
local OFFSET_FROM_TOP = 4
local WIDTH = 400
local HEIGHT = 16 + (2 * 4) + (2 * 4) -- text size + 2*textPaddign + 2*searchBarPadding

function JumpToAction:init()
	self.state = {
		searchTerm = "",
	}

	self.onTextChanged = function(newText)
		self:setState({
			searchTerm = newText,
		})
	end

	self.onEnterPressed = function()
		print("Enter pressed")
	end
end

function JumpToAction:render()
	local state = self.state
	-- local props = self.props

	local searchTerm = state.searchTerm

	-- Use this if we want clicking outside the list to close it
	--[[
	local onClose = props.onClose

	return Roact.createElement("TextButton", {
		AutoButtonColor = false,
		Text = "",
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 0, 0, 0),
		Size = UDim2.new(1, 0, 1, 0),

		[Roact.Event.Activated] = function()
			print("Got click!")
			onClose()
		end,

		-- TODO: Fix this, probably have to listen to text box as that will have focus
		[Roact.Event.InputBegan] = function(rbx, inputObject)
			if inputObject.UserInputType == Enum.UserInputType.Keyboard and inputObject.KeyCode == Enum.KeyCode.Escape then
				print("Got escape")
				onClose()
			end
		end,
	}, {
		-- Have a top level button
		Background = Roact.createElement("TextButton", {
			AutoButtonColor = false,
			Text = "",
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(0.5, 0),
			Position = UDim2.new(0.5, 0, 0, OFFSET_FROM_TOP),
			Size = UDim2.new(0, WIDTH, 0, HEIGHT),
		}, {
			Frame = Roact.createElement("Frame", {
				Size = UDim2.new(1, 0, 1, 0),
			})
		})
	})]]

	local padding = UDim.new(0, 4)

	return Roact.createElement("Frame", {
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.new(0.5, 0, 0, OFFSET_FROM_TOP),
		Size = UDim2.new(0, WIDTH, 0, HEIGHT),
		BorderSizePixel = 0,
	}, {
		UIPadding = Roact.createElement("UIPadding", {
			PaddingTop = padding,
			PaddingBottom = padding,
			PaddingLeft = padding,
			PaddingRight = padding,
		}),

		SearchBar = Roact.createElement(SearchBar, {
			searchTerm = searchTerm,
			onTextChanged = self.onTextChanged,
			onEnterPressed = self.onEnterPressed,
		})
	})
end

return JumpToAction
