--player--
player = entity:new({
	speed=1,
	shooting=false,
	bullet_timer=0,
})

function player:new(obj)
	obj = obj or {}
	setmetatable(obj, self)
	self.__index = self
	return obj
end	

function player:update()
	self:movement()
	self:handle_shooting()
end

function player:draw()
	spr(self.sprite, self.x, self.y)
end

function player:movement()
	local dx=0
 local dy=0
 if (btn(0)) then dx=-1 end
 if (btn(1)) then dx= 1 end
 if (btn(2)) then dy=-1 end
 if (btn(3)) then dy= 1 end
		self.x += dx * self.speed
		self.y += dy * self.speed
 if (btn(4)) then self.shooting = true end
end

function player:handle_shooting()
	if (self.shooting and self.bullet_timer == 0) then
		the_world:add_entity(bullet:new({
		x = self.x,
		y = self.y-4,
		sprite = 2,
		}))
		self.bullet_timer=10
	end
	self.shooting = false
	if (self.bullet_timer > 0) then
		self.bullet_timer -= 1
	end
end