local entityTemplates = {}

local Bullet = require 'Entity.entities.Bullet'
local Enemy = require 'Entity.entities.Enemy'

entityTemplates["Enemy"] = Enemy
entityTemplates["Bullet"] = Bullet

return entityTemplates