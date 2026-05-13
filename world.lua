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
			the_hud:add_score(10)
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
			if e.alive and not e.world_entity then e:draw() end
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
