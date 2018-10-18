-- Dependencies
local Camera = require 'lib.hump.camera'


-- Objects
local MapRenderer = require 'MapRenderer'
local map
local cam
-- TEST
local player = {}
player.speed = 200

-- Constants
local CAM_ZOOM = 1


local drawCol = true

function love.load () 
    love.graphics.setDefaultFilter('nearest', 'nearest', 0)
    map = MapRenderer:new()
    cam = Camera(0,0)

    player.sprite = love.graphics.newImage('assets/happyboi.png')
    player.x = 64
    player.y = 64


end

function love.update (dt)
    local scale = 4
    if love.keyboard.isDown('w') then
        player.y = player.y - player.speed * dt
    elseif love.keyboard.isDown('s') then
        player.y = player.y + player.speed * dt
    end

    if love.keyboard.isDown('d') then
        player.x = player.x + player.speed * dt
    elseif love.keyboard.isDown('a') then
        player.x = player.x - player.speed * dt
    end
    cam:lockX(player.x * scale + 8) -- times scale + half of player width
    cam:lockY(player.y * scale + 8)
end

function love.draw ()
    cam:attach()
    love.graphics.scale(4, 4)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.circle("fill", 0, 0, 5)
    if drawCol then
        map:drawColliders()
    end
    map:drawMap()

    love.graphics.draw(player.sprite, player.x, player.y)

    cam:detach()
end

function love.keypressed( key, scancode, isrepeat )
    if key == "r" then
        map:generateMap()
    end
    if key == "p" then
        drawCol = not drawCol
    end
end