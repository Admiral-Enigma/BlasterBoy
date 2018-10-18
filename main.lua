local MapRenderer = require "MapRenderer"
local map

function love.load () 
    map = MapRenderer:new()
end

function love.update (dt)

end

function love.draw ()
    map:draw()

end

function love.keypressed( key, scancode, isrepeat )
    if key == "r" then
        map:generateMap()
    end
end