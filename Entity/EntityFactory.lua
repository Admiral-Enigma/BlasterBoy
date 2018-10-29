local EntityFactory = {}
EntityFactory.__index = EntityFactory

local entityTemplates = require 'Entity.EntityTemplates'

function EntityFactory:new()
    local ins = setmetatable({}, self)
    ins.pool = {}
    ins.count = 0
    return ins
end

function EntityFactory:createEntity(template, ...)
    local entity
    print(entityTemplates[template])
    entity = entityTemplates[template]:new(...)
    table.insert( self.pool, entity)
    return entity
end

function EntityFactory:update(dt)
    for k,v in ipairs(self.pool) do
        if v.toBeRemoved then
            table.remove( self.pool, k)
        else
            v:update(dt)
        end
    end
    self.count = #self.pool
end

function EntityFactory:draw()
    for k,v in ipairs(self.pool) do
        v:draw()
    end
end

return EntityFactory