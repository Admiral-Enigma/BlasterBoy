local MapGenerator = require "MapGenerator"

local MapRenderer = {}
MapRenderer.__index = MapRenderer

function MapRenderer:new()
    local ins = setmetatable({}, self)
    ins.mapGen = MapGenerator:new()
    ins.mapGen:generateRooms()
    ins.mapGen:generateColliders()
    ins.mapGen:generateAreas()
    return ins
end

function MapRenderer:drawMap()
    for k,v in ipairs(self.mapGen.rooms) do
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.rectangle("line", v.x, v.y, CELL_SIZEX, CELL_SIZEY)
    end
end

function MapRenderer:drawDebugging()
    for _,v in ipairs(self.mapGen.areas) do
        love.graphics.setColor(255, 0, 0, 255)
        love.graphics.rectangle("line", v.x, v.y, CELL_SIZEX * 2, CELL_SIZEY * 2)
        love.graphics.setColor(0, 255, 0, 255)
        love.graphics.rectangle("fill", v.x, v.y, CELL_SIZEX * 2, CELL_SIZEY * 2)
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.circle("fill", v.x, v.y, 5)
    end

    for k,v in ipairs(self.mapGen.colliders) do
        love.graphics.setColor(255, 0, 0, 255)
        love.graphics.rectangle("fill", v.x, v.y, CELL_SIZEX, CELL_SIZEY)
    end
end

function MapRenderer:getFirstRoomCenter()
    return {x = self.mapGen.rooms[1].x + CELL_SIZEX / 2, y = self.mapGen.rooms[1].y + CELL_SIZEY / 2}
end

function MapRenderer:generateMap()
    self.mapGen:generateRooms()
    self.mapGen:generateColliders()
    self.mapGen:generateAreas()
end

return MapRenderer