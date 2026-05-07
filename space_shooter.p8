pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
--main--
function _init()
	the_world = world:new()
	the_player = player:new({x=64, y=120, sprite=1})
	the_enemy = enemy:new({x=64, y=10, sprite=3})
	the_world:add_entity(the_player)
	the_world:add_entity(the_enemy)
end

function _update()
	the_world:update()
end

function _draw()
	cls()
	the_world:draw()
end
-->8
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
-->8
--world--
world = {}

function world:new(obj)
	obj = obj or {}
	setmetatable(obj, self)
	self.__index = self
	obj.entities = {}
	return obj
end

function world:update()
 for e in all(self.entities) do
  if e.alive then e:update() end
 	end
 	for e in all(self.entities) do
  	if e.alive and e.is_enemy then
  		for b in all(self.entities) do
   		if b.alive and b.is_bullet and e:overlaps(b) then
    	 	e.alive = false
      	b.alive = false
    	end
  	end
  	if e:overlaps(the_player) then
      	the_player.alive = false
  	end
		end
	end
 for e in all(self.entities) do
  if not e.alive then del(self.entities, e) end
 end
end

function world:draw()
	for e in all(self.entities) do
			if e.alive then e:draw() end
	end
end

function world:add_entity(entity)
	add(self.entities, entity)
end

function world:check_overlaps(a, group)
  for b in all(group) do
    if b.alive and a:overlaps(b) then
      return b
    end
  end
end

-->8
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
-->8
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
-->8
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
__gfx__
00000000000000000000000008000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000880000000000088088088000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000cc0000000000088888888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700000cccc000000000008888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700080c77c08000aa000088aa880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700cccccccc000aa00000888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000cccccccc0000000000888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000cccccc00000000000088000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
