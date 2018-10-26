local Bullet = require "objects.Bullet"

local BulletsManager = {}
BulletsManager.__index = BulletsManager

function BulletsManager:new()
    local ins = setmetatable({}, self)
    ins.bullets = {}
    return ins
end

function BulletsManager:createBullet(x, y, angle)
    local bullet = Bullet:new(x, y, angle)
    table.insert(self.bullets, bullet)
end

function BulletsManager:update(dt)
    for k,v in ipairs(self.bullets) do
        v:update(dt)
    end

    for k,v in ipairs(self.bullets) do
        if v.dead == true then
            world:remove(v)
            table.remove(self.bullets, k)
        end
    end
end

function BulletsManager:draw()
    for k,v in ipairs(self.bullets) do
        v:draw()
    end
end

return BulletsManager
