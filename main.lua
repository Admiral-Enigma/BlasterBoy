-- Dependencies
local Camera = require 'lib.hump.camera'
Timer = require "lib.hump.timer"
Globals = require 'Globals'
local Player = require 'objects.Player'
local bump = require 'lib.bump'
local Enemy = require 'objects.Enemy'

-- Objects
local MapRenderer = require 'MapRenderer'
local map
local cam
local player

local enemy

-- Debug vars
local drawCol = true

function love.load () 
    love.graphics.setDefaultFilter('nearest', 'nearest', 0)
    
    world = bump.newWorld()
    map = MapRenderer:new()
    cam = Camera(0,0)
    
    local firstRoomCords = map:getFirstRoomCenter()
    player = Player:new(firstRoomCords.x, firstRoomCords.y)
    world:add(player, player.x, player.y, player.width, player.height)

    enemy = Enemy:new(player.x, player.y)
    world:add(enemy, enemy.x, enemy.y, enemy.width, enemy.height)
end

function love.update (dt)
    Timer.update(dt)
    player:update(dt)
    enemy:update(dt)
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
    enemy:draw()

    cam:detach()
end

function love.keypressed( key, scancode, isrepeat )
    if key == "r" then
        map:generateMap()
        local firstRoomCords = map:getFirstRoomCenter()
        player:setPosition(firstRoomCords.x, firstRoomCords.y)
        world:update(player, player.x, player.y, player.width, player.height)
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