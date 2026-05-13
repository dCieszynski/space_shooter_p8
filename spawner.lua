spawner = {
    x = 0,
    y = 0,
    spawn_rate = 60, -- frames between spawns
    timer = 0,
    enemy_type = 3, -- type of enemy to spawn
}

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
    the_world:add_entity(enemy:new({
        x = self.x,
        y = self.y,
        sprite = self.enemy_type,
    }))
end