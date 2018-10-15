local CELL_SIZEX = 32
local CELL_SIZEY = 32
local ROOM_COUNT = 64

local lastX = 50
local lastY = 50
local lastDir = 0
local hasDrawn = false
local rooms = {}

function love.load () 
    generateRoom()
end

function love.update (dt)

end

function love.draw ()
    for k,v in ipairs(rooms) do
        love.graphics.rectangle("line", v[1], v[2], CELL_SIZEX, CELL_SIZEY)
    end
    -- love.graphics.rectangle("fill", x, y, 16, 16)
end

function love.keypressed( key, scancode, isrepeat )
    if key == "r" then
        generateRoom()
    end
end

function addRoom(x, y)
    resetLastPos(x, y, direction)
    table.insert( rooms, {x, y})
end

function generateRoom()
    rooms = {}
    lastX = 50
    lastY = 50
    lastDir = 0
    for i=1,ROOM_COUNT do 
        local direction = love.math.random(1, 4)
        
        if direction == lastDir then
            direction = love.math.random(1, 4)
        end

        if direction == 1 then
            -- north
            local x, y = lastX, lastY - CELL_SIZEY
            addRoom(x, y)
        elseif direction == 2 then
            -- east
            local x, y = lastX + CELL_SIZEX, lastY
            addRoom(x, y)
        elseif direction == 3 then
            -- south
            local x, y = lastX, lastY + CELL_SIZEY
            addRoom(x, y)
        elseif direction == 4 then
            -- west
            local x, y = lastX - CELL_SIZEX, lastY
            addRoom(x, y)
        end
    end
end

function resetLastPos(x, y, dir)
    lastX = x
    lastY = y
    lastDir = dir
end