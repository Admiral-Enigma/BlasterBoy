-- Dependencies
local Camera = require 'lib.hump.camera'
require 'utils'
Timer = require "lib.hump.timer"
Globals = require 'Globals'
local Player = require 'Entity.entities.Player'
local bump = require 'lib.bump'
local EntityFactory = require 'Entity.EntityFactory'

-- Objects
local MapRenderer = require 'MapRenderer'
local map
local player


function love.load() 
    love.graphics.setDefaultFilter('nearest', 'nearest', 0)
    
    world = bump.newWorld()
    Globals.Camera = Camera(0,0)
    Globals.EntityFactory = EntityFactory:new()
    map = MapRenderer:new()
    
    local firstRoomCords = map:getFirstRoomCenter()
    player = Player:new(firstRoomCords.x, firstRoomCords.y)
    world:add(player, player.x, player.y, player.width, player.height)


end

function love.update(dt)
    Timer.update(dt)
    player:update(dt)
    Globals.EntityFactory:update(dt)
    Globals.Camera:lockX(player.camX * Globals.scale + 8) -- times scale + half of player width
    Globals.Camera:lockY(player.camY * Globals.scale + 8)
end

function love.draw()
    Globals.Camera:attach()
    love.graphics.scale(Globals.scale, Globals.scale)


    map:drawMap()
    
    if Globals.debug then map:drawDebugging() end

    Globals.EntityFactory:draw()
    player:draw()
    Globals.Camera:detach()

    -- Debugging UI
    if Globals.debug then drawDebug() end
end

function love.mousepressed(x, y, button, istouch, presses)
    player:mousepressed(x, y, button, istouch, presses)
end

function love.keypressed( key, scancode, isrepeat )
    if key == "r" then
        map:generateMap()
        local firstRoomCords = map:getFirstRoomCenter()
        player:setPosition(firstRoomCords.x, firstRoomCords.y)
    end

    -- DEBUG
    if key == "p" then
        Globals.debug = not Globals.debug
    end

    if key == "escape" then
        love.event.quit()
    end

    if key == "z" then
        if Globals.scale == 4 then
            Globals.scale = 1
        else
            Globals.scale = 4
        end
    end
end