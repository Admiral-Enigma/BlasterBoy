local lastX = 0
local lastY = 0
local lastDir = 0
local hasDrawn = false

function love.load () 

end

function love.update (dt)

end

function love.draw ()
    if hasDrawn == false then
        -- Generate "random path"
        for i=1,10 do 
            local direction = love.math.random(1, 4)
            
            while (direction == lastDir) do
                direction = love.math.random(1, 4)
            end

            if direction == 1 then
                -- north
                local x, y = lastX, lastY - 16
                love.graphics.rectangle("fill", x, y, 16, 16)
                resetLastPos(x, y, direction)
            elseif direction == 2 then
                -- east
                local x, y = lastX + 16, lastY
                love.graphics.rectangle("fill", x, y, 16, 16)
                resetLastPos(x, y, direction)
            elseif direction == 3 then
                -- south
                local x, y = lastX, lastY + 16
                love.graphics.rectangle("fill", x, y, 16, 16)
                resetLastPos(x, y, direction)
            elseif direction == 4 then
                -- west
                local x, y = lastX - 16, lastY
                love.graphics.rectangle("fill", x, y, 16, 16)
                resetLastPos(x, y, direction)
            end
        end
        lastX = 50
        lastY = 50
    end
end

function resetLastPos(x, y, dir)
    lastX = x
    lastY = y
    lastDir = dir
end