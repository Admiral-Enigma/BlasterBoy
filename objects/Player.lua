local WALKSPEED = 200

local Player = {}
Player.__index = Player

function Player:new(x, y)
    local ins = setmetatable({}, self)
    ins.sprite = love.graphics.newImage('assets/happyboi.png')
    ins.x = x
    ins.y = y
    ins.width = 16
    ins.height = 16
    return ins
end

function Player:draw()
    love.graphics.setColor(255,255,255, 255)
    love.graphics.draw(self.sprite, self.x, self.y)
end

function Player:setPosition(x, y)
    self.x = x
    self.y = y
end

function Player:update(dt)
    
    local dx, dy = 0, 0
    if love.keyboard.isDown('w') then
        dy = -WALKSPEED * dt
    elseif love.keyboard.isDown('s') then
        dy = WALKSPEED * dt
    end

    if love.keyboard.isDown('d') then
        dx = WALKSPEED * dt
    elseif love.keyboard.isDown('a') then
        dx = -WALKSPEED * dt
    end

    -- We moving
    if dx ~= 0 or dy ~= 0 then
        self.x, self.y, _, _ = world:move(self, self.x + dx, self.y + dy)
    end
end

return Player