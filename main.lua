-- Dependencies
local Camera = require "lib.hump.camera"


-- Map
local MapRenderer = require "MapRenderer"
local map

local cam
-- TODO: Make some sort of global file
local CAM_ZOOM = 10

function love.load () 
    map = MapRenderer:new()
    cam = Camera(0,0)
    cam:zoomTo(CAM_ZOOM)
end

function love.update (dt)

end

function love.draw ()
    cam:attach()
    map:draw()
    cam:detach()
end

function love.keypressed( key, scancode, isrepeat )
    if key == "r" then
        map:generateMap()
    end
    if key == "p" then
        if cam.scale == CAM_ZOOM then
            cam:zoomTo(1)
        else
            cam:zoomTo(CAM_ZOOM)
        end
    end
end