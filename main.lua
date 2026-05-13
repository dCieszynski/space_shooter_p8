--main--
function _init()
	the_world = world:new()
	the_hud = hud:new()
	the_spawner = spawner:new({spawn_rate=120})
	the_world:add_entity(the_spawner)
end

function _update()
	the_world:update()
end

function _draw()
	cls()
	the_world:draw()
	the_hud:draw()
end
