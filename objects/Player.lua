local WALKSPEED = 200

local Player = {}
Player.__index = Player

function Player:new(x, y)
    local ins = setmetatable({}, self)
    ins.sprite = love.graphics.newImage('assets/happyboi.png')
    ins.x = x
    ins.y = y
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
    if love.keyboard.isDown('w') then
        self.y = self.y - WALKSPEED * dt
    elseif love.keyboard.isDown('s') then
        self.y = self.y + WALKSPEED * dt
    end

    if love.keyboard.isDown('d') then
        self.x = self.x + WALKSPEED * dt
    elseif love.keyboard.isDown('a') then
        self.x = self.x - WALKSPEED * dt
    end
end

return Player