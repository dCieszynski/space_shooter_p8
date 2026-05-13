enemy_strafe = enemy:new({
    vx = 1,
    shoot_timer = 0,
    shoot_rate = 20,
    burst_size = 2,
    burst_delay = 8,
    burst_count = 0,
    burst_timer = 0,
    in_burst = false,
    score = 30,
    sprite = 5,
})

function enemy_strafe:new(obj)
    obj = obj or {}
    setmetatable(obj, self)
    self.__index = self
    obj.vx = (flr(rnd(2)) == 0) and 1 or -1
    return obj
end

function enemy_strafe:update()
    self.x += self.vx
    if self.x < 0 or self.x > 120 then
        self.vx = -self.vx
    end
    self.y += self.dir*self.speed
    if self.y > 136 then self.alive = false end
    local player_x = the_world.player.x
    if abs(player_x - self.x) < 32 then
        self:try_shoot()
    end
end

function enemy_strafe:try_shoot()
    if self.in_burst then
        self.burst_timer += 1
        if self.burst_timer >= self.burst_delay then
            self.burst_timer = 0
            self:fire()
            self.burst_count += 1
            if self.burst_count >= self.burst_size then
                self.in_burst = false
                self.shoot_timer = 0
            end
        end
    else
        self.shoot_timer += 1
        if self.shoot_timer >= self.shoot_rate then
            self.in_burst = true
            self.burst_count = 1
            self.burst_timer = 0
            self:fire()
        end
    end
end

function enemy_strafe:fire()
    local b = bullet:new({x=self.x, y=self.y+8, dir=-1, is_enemy_bullet=true, sprite=0})
    the_world:add_entity(b)
end