--bullet--
bullet = entity:new({
	speed=2,
	dir=1,
	is_bullet=true,
})

function bullet:new(obj)
	obj = obj or {}
	setmetatable(obj, self)
	self.__index = self
	return obj
end

function bullet:update()
	self.y -= self.dir * self.speed
 if self.y < -8 then
 	self.alive = false
 end
end

function bullet:draw()
	spr(self.sprite, self.x, self.y)
end