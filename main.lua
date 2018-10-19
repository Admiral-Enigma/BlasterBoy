-- Dependencies
local Camera = require 'lib.hump.camera'
Globals = require 'Globals'
local Player = require 'objects.Player'

-- Objects
local MapRenderer = require 'MapRenderer'
local map
local cam
-- TEST
local player

-- Constants
local CAM_ZOOM = 1


local drawCol = true

function love.load () 
    love.graphics.setDefaultFilter('nearest', 'nearest', 0)
    map = MapRenderer:new()
    cam = Camera(0,0)

    local firstRoomCords = map:getFirstRoomCenter()
    player = Player:new(firstRoomCords.x, firstRoomCords.y)



end

function love.update (dt)
    player:update(dt)
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

    player:draw()

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