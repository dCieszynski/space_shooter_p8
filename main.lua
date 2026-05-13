--main--
function _init()
	the_world = world:new()
	the_player = player:new({x=64, y=120, sprite=1})
	the_world:add_entity(the_player)
	the_spawner = spawner:new({spawn_rate=120, enemy_type=3})
	the_world:add_entity(the_spawner)
end

function _update()
	the_world:update()
end

function _draw()
	cls()
	the_world:draw()
end