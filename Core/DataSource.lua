local DataSource = {}
DataSource.__index = DataSource

function DataSource.new()
	local self = {}
	setmetatable(self, DataSource)
	return self
end

function DataSource:destroy()
end

return DataSource
