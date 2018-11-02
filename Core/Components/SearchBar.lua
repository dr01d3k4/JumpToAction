local Plugin = script.Parent.Parent.Parent

local Roact = require(Plugin.Libs.Roact)

local SearchBar = Roact.PureComponent:extend("SearchBar")

function SearchBar:init()
	self.textBoxRef = Roact.createRef()

	self.captureFocus = function()
		if self.textBoxRef and self.textBoxRef.current then
			self.textBoxRef.current:CaptureFocus()
		end
	end

	self.onBackgroundClicked = function()
		self.captureFocus()
	end

	self.onTextChanged = function(rbx)
		-- Don't send changed event before we've mounted
		if self.hasMounted then
			self.props.onTextChanged(rbx.Text)
		end
	end

	self.onFocusLost = function(rbx, enterPressed)
		if enterPressed then
			self.props.onEnterPressed()

			-- Refocus
			-- TODO: Likely remove this once pressing enter does something
			-- If no action was selected, then we should refocus
			-- If it was selected, then lose focus (though the gui would likely close too)
			self.captureFocus()
		end
	end
end

function SearchBar:didMount()
	-- Need to use spawn for it to actually work for some reason
	spawn(self.captureFocus)

	self.hasMounted = true
end

function SearchBar:render()
	local props = self.props

	local searchTerm = props.searchTerm

	local padding = UDim.new(0, 4)

	return Roact.createElement("TextButton", {
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, 0),

		AutoButtonColor = false,
		Text = "",

		[Roact.Event.Activated] = self.onBackgroundClicked,
	}, {
		UIPadding = Roact.createElement("UIPadding", {
			PaddingTop = padding,
			PaddingBottom = padding,
			PaddingLeft = padding,
			PaddingRight = padding,
		}),

		TextBox = Roact.createElement("TextBox", {
			[Roact.Ref] = self.textBoxRef,
			[Roact.Change.Text] = self.onTextChanged,
			[Roact.Event.FocusLost] = self.onFocusLost,

			BackgroundTransparency = 1,

			Text = searchTerm,

			ClearTextOnFocus = false,
			Font = Enum.Font.SourceSans,
			TextSize = 16,
			TextXAlignment = Enum.TextXAlignment.Left,
			-- TODO: Setup theming
			TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText),

			PlaceholderText = "Type a thing!",
			PlaceholderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.DimmedText),

			Size = UDim2.new(1, 0, 1, 0),
		})
	})
end

return SearchBar
