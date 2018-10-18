-- Dependencies
local Camera = require 'lib.hump.camera'
Globals = require 'Globals'

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
    cam:lockX(player.x * Globals.scale + 8) -- times scale + half of player width
    cam:lockY(player.y * Globals.scale + 8)
end

function love.draw ()
    cam:attach()
    love.graphics.scale(Globals.scale, Globals.scale)

    if drawCol then
        map:drawColliders()
    end
    map:drawMap()

    love.graphics.setColor(255,0,144, 200)
    love.graphics.circle("fill", 0, 0, 5)

    love.graphics.setColor(255,255,255, 255)
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