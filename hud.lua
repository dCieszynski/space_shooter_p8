hud = {
	score = 0,
}

function hud:new(obj)
	obj = obj or {}
	setmetatable(obj, self)
	self.__index = self
	return obj
end

function hud:draw()
	print("Score: "..self.score, 1, 1, 7)
end

function hud:add_score(pts)
	self.score += pts
end