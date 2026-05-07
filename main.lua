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