local WALKSPEED = 800
local FRICTION = 9
local MAX_SPEED = 900
local CROSSHAIR_ORBIT = 20

local Player = {}
Player.__index = Player

function Player:new(x, y)
    local ins = setmetatable({}, self)
    ins.sprite = love.graphics.newImage('assets/happyboi.png')
    ins.x = x
    ins.y = y
    ins.vx = 0
    ins.vy = 0
    ins.aimX = x
    ins.aimY = y
    ins.width = 16
    ins.height = 16
    return ins
end

function Player:draw()
    love.graphics.setColor(255,255,255, 255)
    love.graphics.draw(self.sprite, self.x, self.y)
    
    -- Crosshair
    love.graphics.setColor(255, 255, 255)
    love.graphics.circle("fill", self.aimX, self.aimY, 5)
end

function Player:setPosition(x, y)
    self.x = x
    self.y = y
end

function Player:update(dt)
    local angle = 0
    

    local cX,cY = Globals.Camera:worldCoords(love.mouse.getPosition())
    cX = cX / Globals.scale
    cY = cY / Globals.scale
    
    angle = math.atan2(self.y + 8 - cY ,self.x + 8 - cX)
    angle = angle + math.pi

    self.aimX = CROSSHAIR_ORBIT * math.cos(angle) + self.x + 8
    self.aimY = CROSSHAIR_ORBIT * math.sin(angle) + self.y + 8


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

function math.dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end
return Player