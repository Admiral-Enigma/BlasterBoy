local BULLET_SPEED = 300

local Bullet = {}
Bullet.__index = Bullet

function Bullet:new(x, y, angle)
    local ins = setmetatable({}, self)
    ins.x = x
    ins.y = y
    ins.angle = angle
    ins.radius = 4
    ins.typeID = "bullet"
    ins.dead = false
    world:add(ins, ins.x, ins.y, ins.radius * 2, ins.radius * 2)
    return ins
end

function Bullet:draw()
    love.graphics.setColor(0, 255, 0)
    love.graphics.circle('fill', self.x, self.y, 4)
end

local bulletFilter = function(item, other)
    if other.typeID == 'player' then return 'cross'
    elseif other.typeID == 'wall' then return 'cross' end
end

function Bullet:update(dt)
    local dx, dy
    dx = math.cos( self.angle ) * BULLET_SPEED * dt
    dy = math.sin( self.angle ) * BULLET_SPEED * dt

    self.x, self.y, cols, len = world:move(self, self.x + dx, self.y + dy, bulletFilter)
    
    for i=1,len do
        local other = cols[i].other
        print(other)
        if other.typeID == 'wall' then
            self.dead = true
        end
        print('collided with ' .. tostring(cols[i].other))
    end
end

return Bullet