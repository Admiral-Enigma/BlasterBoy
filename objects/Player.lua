local WALKSPEED = 800
local FRICTION = 9
local MAX_SPEED = 900
local CROSSHAIR_ORBIT = 30
local CAMERA_OFFSET = 15
local CAMERA_CUTOFF = 30


local Bullet = require "objects.Bullet"
local bullet = nil
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
    return ins
end

function Player:draw()
    love.graphics.setColor(255,255,255, 255)
    love.graphics.draw(self.sprite, self.x, self.y)
    
    -- Crosshair
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(self.crosshair, self.aimX, self.aimY)
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

    angle = math.atan2(self.y + 8 - mouseY ,self.x + 8 - mouseX)
    angle = angle + math.pi
    self.aimAngle = angle

    --self.aimX = CROSSHAIR_ORBIT * math.cos(angle) + self.x
    --self.aimY = CROSSHAIR_ORBIT * math.sin(angle) + self.y]]

    local distFromMouse = distance(self.x, self.y, mouseX, mouseY)
    local r = (distFromMouse / 2 - CAMERA_OFFSET) / distFromMouse
    print(distFromMouse)

    if distFromMouse < CAMERA_CUTOFF then
        self.camX = self.x
        self.camY = self.y
    else 
        self.camX = r * mouseX + (1 - r)  * self.x
        self.camY = r * mouseY + (1 - r)  * self.y
    end

    self.aimX = mouseX
    self.aimY = mouseY

    -- We moving
    if self.vx ~= 0 or self.vy ~= 0 then
        self.x, self.y, _, _ = world:move(self, self.x + self.vx * dt, self.y + self.vy * dt)
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

function Player:mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        Globals.BulletsManager:createBullet(self.x + self.width / 2, self.y + self.height / 2, self.aimAngle)
    end
end

function distance ( x1, y1, x2, y2 )
    local dx = x1 - x2
    local dy = y1 - y2
    return math.sqrt ( dx * dx + dy * dy )
  end

return Player