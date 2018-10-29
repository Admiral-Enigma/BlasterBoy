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


-- Debug vars
local drawCol = true

function love.load() 
    love.graphics.setDefaultFilter('nearest', 'nearest', 0)
    
    world = bump.newWorld()
    map = MapRenderer:new()
    Globals.Camera = Camera(0,0)
    Globals.EntityFactory = EntityFactory:new()
    
    local firstRoomCords = map:getFirstRoomCenter()
    player = Player:new(firstRoomCords.x, firstRoomCords.y)
    world:add(player, player.x, player.y, player.width, player.height)

    local enemy = Globals.EntityFactory:createEntity("Enemy", player.x, player.y)
    world:add(enemy, enemy.x, enemy.y, enemy.width, enemy.height)
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

    if drawCol then
        map:drawColliders()
    end

    map:drawMap()
    Globals.EntityFactory:draw()
    player:draw()
    Globals.Camera:detach()
    drawDebug()
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
        drawCol = not drawCol
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