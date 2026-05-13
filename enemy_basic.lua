enemy_basic = enemy:new({
    sprite=4,
    speed=1,
    dir=1,
    is_enemy=true,
    score=20,
    shoot_timer=0,
    shoot_rate=20,
    burst_size=2,
    burst_delay=8,
    burst_count=0,
    burst_timer=0,
    in_burst=false,
})

function enemy_basic:new(obj)
    obj = obj or {}
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function enemy_basic:update()
    self.y += self.dir*self.speed
    if self.y > 136 then self.alive = false end
    local player_x = the_world.player.x
    if self.in_burst or abs(player_x - self.x) < 16 then
        self:try_shoot()
    end
end

function enemy_basic:try_shoot()
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

function enemy_basic:fire()
    local b = bullet:new({x=self.x, y=self.y+8, dir=-1, is_enemy_bullet=true, sprite=0})
    the_world:add_entity(b)
end