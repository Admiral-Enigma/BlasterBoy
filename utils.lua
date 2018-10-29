function drawDebug()
    love.graphics.setColor(255,255,255, 255)
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
    love.graphics.print("Entities: "..tostring(Globals.EntityFactory.count), 10, 20)
end