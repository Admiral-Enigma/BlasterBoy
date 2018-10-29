local WALKSPEED = 800
local FRICTION = 9
local MAX_SPEED = 900

local lume = require "lib.lume"

local Player = {}
Player.__index = Player

function Player:new(x, y)
    local ins = setmetatable({}, self)
    ins.sprite = love.graphics.newImage('assets/happyboi.png')
    ins.crosshair = love.graphics.newImage('assets/crosshair.png')
    ins.x = x
    ins.y = y
    ins.vx = 0
    ins.vy = 0
    ins.aimX = x
    ins.aimY = y
    ins.aimAngle = 1
    ins.width = 16
    ins.height = 16
    ins.camX = ins.x
    ins.camY = ins.y
    ins.typeID = 'player'
    return ins
end

function Player:draw()
    love.graphics.setColor(255,255,255, 255)
    love.graphics.draw(self.sprite, self.x, self.y)
    
    -- Crosshair
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(self.crosshair, self.aimX - self.crosshair:getWidth() / 2, self.aimY - self.crosshair:getHeight() / 2)
end

function Player:setPosition(x, y)
    self.x = x
    self.y = y
    world:update(self, self.x, self.y, self.width, self.height)
end

function Player:update(dt)
    local angle = 0


    local mouseX,mouseY = Globals.Camera:worldCoords(love.mouse.getPosition())
    mouseX = mouseX / Globals.scale
    mouseY = mouseY / Globals.scale
    local tempCamX = mean(self.x, self.x, mouseX)
    local tempCamY = mean(self.y, self.y, mouseY)
    self.camX = lume.lerp(self.camX, tempCamX, 0.1)
    self.camY = lume.lerp(self.camY, tempCamY, 0.1)

    self.aimX = mouseX
    self.aimY = mouseY

    -- We moving
    if self.vx ~= 0 or self.vy ~= 0 then
        self.x, self.y, _, _ = world:move(self, self.x + self.vx * dt, self.y + self.vy * dt, playerFilter)
    end

    self.vx = self.vx * (1 - math.min(dt * FRICTION, 1))
    self.vy = self.vy * (1 - math.min(dt * FRICTION, 1))

    -- Input
    if love.keyboard.isDown('w') and self.vy > -MAX_SPEED then
        self.vy = self.vy - WALKSPEED * dt
    elseif love.keyboard.isDown('s') and self.vy < MAX_SPEED then
        self.vy = self.vy + WALKSPEED * dt
    end

    if love.keyboard.isDown('d') and self.vx < MAX_SPEED then
        self.vx = self.vx + WALKSPEED * dt
    elseif love.keyboard.isDown('a') and self.vx > -MAX_SPEED then
        self.vx = self.vx - WALKSPEED * dt
    end
end

playerFilter = function(item, other)
    if other.typeID == 'bullet' then return 'cross' 
    else return 'slide' end
end

function Player:mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        Globals.EntityFactory:createEntity("Bullet", self.x + self.width / 2, self.y + self.height / 2, self.aimAngle)
    end
end

function distance ( x1, y1, x2, y2 )
    local dx = x1 - x2
    local dy = y1 - y2
    return math.sqrt ( dx * dx + dy * dy )
  end

return Player