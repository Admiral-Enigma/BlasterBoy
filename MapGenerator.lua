CELL_SIZEX = 64
CELL_SIZEY = 64
local ROOM_COUNT = 64
local START_X = 0
local START_Y = 0

local MapGenerator = {}
MapGenerator.__index = MapGenerator

function MapGenerator:new()              
    local ins = setmetatable({}, self)
    ins.rooms = {}
    ins.colliders = {}
    ins.areas = {}
    ins.lastX = START_X
    ins.lastY = START_Y
    ins.lastDir = 0
    return ins
end

function MapGenerator:generateRooms()
    self:clearVars()
    
    for i=1,ROOM_COUNT do
        local direction = love.math.random(1, 4)
        
        if direction == self.lastDir then
            direction = love.math.random(1, 4)
        end

        if direction == 1 then
            -- north
            local x, y = self.lastX, self.lastY - CELL_SIZEY
            self:addRoom(x, y)
        elseif direction == 2 then
            -- east
            local x, y = self.lastX + CELL_SIZEX, self.lastY
            self:addRoom(x, y)
        elseif direction == 3 then
            -- south
            local x, y = self.lastX, self.lastY + CELL_SIZEY
            self:addRoom(x, y)
        elseif direction == 4 then
            -- west
            local x, y = self.lastX - CELL_SIZEX, self.lastY
            self:addRoom(x, y)
        end
    end
end

function MapGenerator:generateColliders()
    self:resetColliders()
    for _,v in ipairs(self.rooms) do
        if self:hasRoom(v.x, v.y - CELL_SIZEY) == false then
            -- north
            local x, y = v.x, v.y - CELL_SIZEY
            self:addCollider(x, y)
        end
        if self:hasRoom(v.x + CELL_SIZEX, v.y) == false then
            -- east
            local x, y = v.x + CELL_SIZEX, v.y
            self:addCollider(x, y)
        end
        
        if self:hasRoom(v.x, v.y + CELL_SIZEY) == false then
            -- south
            local x, y = v.x, v.y + CELL_SIZEY
            self:addCollider(x, y)
        end
        
        if self:hasRoom(v.x - CELL_SIZEX, v.y) == false then
            -- west
            local x, y = v.x - CELL_SIZEX, v.y
            self:addCollider(x, y)
        end
    end
end

-- Squares for now
function MapGenerator:generateAreas()
    self.areas = {}
    for k,v in ipairs(self.rooms) do 
        if self:canHaveArea(v.x, v.y) then
            table.insert( self.areas, {x = v.x, y = v.y})
        end
    end

    for _,v in ipairs(self.areas) do
        local enemy = Globals.EntityFactory:createEntity("Enemy", v.x, v.y)
        world:add(enemy, enemy.x, enemy.y, enemy.width, enemy.height)
    end
end

function MapGenerator:addRoom(x, y)
    if self:hasRoom(x, y) == false then
        self:resetLastPos(x, y, direction)
        table.insert(self.rooms,{x = x, y = y})
    end 
end

function MapGenerator:addCollider(x, y)
    local collider = {x = x, y = y, w = CELL_SIZEX, h = CELL_SIZEY, typeID = 'wall'}
    table.insert(self.colliders, collider)
    world:add(collider, collider.x, collider.y, collider.w, collider.h)
end

function MapGenerator:hasRoom(x, y)
    local has = false
    for _,v in ipairs(self.rooms) do
        if v.x == x then
            if v.y == y then
                has = true
            end
        end
    end
    return has
end

function MapGenerator:canHaveArea(x, y)
    local can = false
    if self:hasRoom(x, y) and self:hasRoom(x + CELL_SIZEX, y) and self:hasRoom(x, y + CELL_SIZEY) and self:hasRoom(x + CELL_SIZEX, y + CELL_SIZEY) then
        can = true
        for _,v in ipairs(self.areas) do
            if v.x == x and v.y == y then
                can = false
            end
            if v.x + CELL_SIZEX == x or v.x - CELL_SIZEX == x or v.y + CELL_SIZEY == y or v.y - CELL_SIZEY == y then
                print("banan")
                can = false
            end
        end
    end
    return can
end

function MapGenerator:clearVars()
    self.rooms = {}
    self.lastX = START_X
    self.lastY = START_Y
    self.lastDir = 0
end

function MapGenerator:resetColliders()
    for k,v in ipairs(self.colliders) do
        world:remove(v)
    end
    self.colliders = {}
end

function MapGenerator:resetLastPos(x, y, dir)
    self.lastX = x
    self.lastY = y
    self.lastDir = dir
end

return MapGenerator
