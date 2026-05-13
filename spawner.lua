spawner = entity:new({
	spawn_rate = 60,
	timer = 0,
	world_entity = true,
})

function spawner:new(obj)
	obj = obj or {}
	setmetatable(obj, self)
	self.__index = self
	return obj
end

function spawner:update()
	self.timer += 1
	if self.timer >= self.spawn_rate then
		self:spawn_enemy()
		self.timer = 0
	end
end

function spawner:spawn_enemy()
	local types = {enemy, enemy_basic, enemy_strafe}
	local t = types[flr(rnd(#types))+1]
	the_world:add_entity(t:new({x=flr(rnd(120)), y=-8}))
end
