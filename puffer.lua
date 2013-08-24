Puffer = {}

function Puffer.create()
	local puffer = {
		x = 400,
		y = 300,
		angle = 0,
		size = 20,
		speed = 0
	}

	setmetatable(puffer, {__index = Puffer})

	return puffer
end

function Puffer:update()
	self.x = self.x + math.cos(self.angle) * self.speed * delta
	self.y = self.y + math.sin(self.angle) * self.speed * delta

	local mindis = math.huge
    local minidx = nil
    for i, bubble in pairs(bubbles) do
		local dis = math.distance(self.x, self.y, bubble.x, bubble.y)
		if dis < mindis then
			mindis = dis
			minidx = i
		end
    end

    if minidx then
    	self.speed = math.min(self.speed + 5 * delta, 100)
    	self.angle = math.anglerp(self.angle, math.direction(self.x, self.y, bubbles[minidx].x, bubbles[minidx].y), .05)
    else
    	self.speed = math.max(self.speed - 5 * delta, 0)
    end
end

function Puffer:draw()
	love.graphics.setColor(255, 255, 0)
	love.graphics.circle('fill', self.x, self.y, self.size)
end