local MapGenerator = require "MapGenerator"

local MapRenderer = {}
MapRenderer.__index = MapRenderer

function MapRenderer:new()
    local ins = setmetatable({}, self)
    ins.mapGen = MapGenerator:new()
    ins.mapGen:generateRooms()
    ins.mapGen:generateColliders()
    return ins
end

function MapRenderer:drawMap()
    for k,v in ipairs(self.mapGen.rooms) do
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.rectangle("line", v.x, v.y, CELL_SIZEX, CELL_SIZEY)
    end

end
function MapRenderer:drawColliders()
    for k,v in ipairs(self.mapGen.colliders) do
        love.graphics.setColor(255, 0, 0, 255)
        love.graphics.rectangle("fill", v.x, v.y, CELL_SIZEX, CELL_SIZEY)
    end
end


function MapRenderer:generateMap()
    self.mapGen:generateRooms()
    self.mapGen:generateColliders()
end

return MapRenderer