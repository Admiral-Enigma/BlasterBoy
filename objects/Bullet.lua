local BULLET_SPEED = 300

local Bullet = {}
Bullet.__index = Bullet

function Bullet:new(x, y, angle)
    local ins = setmetatable({}, self)
    ins.x = x
    ins.y = y
    ins.angle = angle
    print("boom")
    return ins
end

function Bullet:draw()
    love.graphics.setColor(0, 255, 0)
    love.graphics.circle('fill', self.x, self.y, 4)
end

function Bullet:update(dt)
    local dx, dy
    dx = math.cos( self.angle ) * BULLET_SPEED * dt
    dy = math.sin( self.angle ) * BULLET_SPEED * dt

    self.x = self.x + dx
    self.y = self.y + dy

end

return Bullet