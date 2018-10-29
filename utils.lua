function drawDebug()
    love.graphics.setColor(255,255,255, 255)
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 15)
    love.graphics.print("Entities: "..tostring(Globals.EntityFactory.count), 10, 15 * 2)
    local stats = love.graphics.getStats()
    love.graphics.print("DrawCalls: "..tostring(stats.drawcalls), 10, 15 * 3)

    local str = string.format("Estimated amount of texture memory used: %.2f KB", stats.texturememory / 1024)
    love.graphics.print(str, 10, 15 * 4)
    love.graphics.print("Images loaded: "..tostring(stats.images), 10, 15 * 5)
end

function mean(a, b, c)
    return (a + b + c) / 3
end