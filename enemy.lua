enemy = entity:new({
	speed=1,
	dir=1,
	is_enemy=true,
})

function enemy:new(obj)
	obj = obj or {}
	setmetatable(obj, self)
	self.__index = self
	return obj
end

function enemy:update()
		self.y += self.dir*self.speed
end

function enemy:draw()
	spr(self.sprite, self.x, self.y)
end