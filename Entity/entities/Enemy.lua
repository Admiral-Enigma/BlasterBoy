local WALKSPEED = 20
local MOVEMENT_TIMER = 2

local Enemy = {}
Enemy.__index = Enemy

function Enemy:new(x, y)
    local ins = setmetatable({}, self)
    ins.sprite = love.graphics.newImage('assets/happyboi.png')
    ins.x = x
    ins.y = y
    ins.width = 16
    ins.height = 16
    ins.angle = 1
    ins.stopped = true
    ins.typeID = 'enemy'
    Timer.every(MOVEMENT_TIMER, function() ins:newDirection() end)    
    return ins
end

function Enemy:draw()
    love.graphics.setColor(255,0,0, 255)
    love.graphics.draw(self.sprite, self.x, self.y)
end

enemyFilter = function(item, other)
    if other.typeID == 'bullet' then return 'cross' 
    else return 'slide' end
end


function Enemy:update(dt)
    local dx, dy = 0, 0
    --enemy.x = enemy.x + math.cos(enemy.angle) * dt * enemy.speed
    --enemy.y = enemy.y + math.sin(enemy.angle) * dt * enemy.speed
    dx = math.cos(self.angle) * WALKSPEED * dt 
    dy = math.sin(self.angle) * WALKSPEED * dt 

    if not self.stopped then
        self.x, self.y, _, _ = world:move(self, self.x + dx, self.y + dy, enemyFilter)
    end
end

function Enemy:newDirection()
    self.stopped = not self.stopped
    local direction = love.math.random(1, 4)

    if direction == 1 then
        self.angle = math.deg(0)
    else
        self.angle = math.deg(direction * 90)
    end
end

return Enemy