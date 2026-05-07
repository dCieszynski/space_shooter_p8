--entity--
entity = {
	x=0,
	y=0,
	w=8, 
	h=8,
	alive = true,
	sprite=0,
}

function entity:new(obj)
	obj = obj or {}
	setmetatable(obj, self)
	self.__index = self
	return obj
end

function entity:overlaps(other)
	return
		self.x < other.x + other.w and
		self.x + self.w > other.x and
		self.y < other.y + other.h and
		self.y + self.h > other.y
end