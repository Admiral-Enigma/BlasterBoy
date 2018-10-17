local MapGenerator = require "MapGenerator"

function love.load () 
    map = MapGenerator:new()
    map:generateRooms()
    map:generateColliders()
end

function love.update (dt)

end

function love.draw ()
    for k,v in ipairs(map.rooms) do
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.rectangle("line", v.x, v.y, CELL_SIZEX, CELL_SIZEY)
    end
    for k,v in ipairs(map.colliders) do
        love.graphics.setColor(255, 0, 0, 255)
        love.graphics.rectangle("fill", v.x, v.y, CELL_SIZEX, CELL_SIZEY)
    end

end

function love.keypressed( key, scancode, isrepeat )
    if key == "r" then
        map:generateRooms()
        map:generateColliders()
    end
end