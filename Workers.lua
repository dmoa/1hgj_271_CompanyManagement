local Workers = {
    image = lg.newImage("worker.png"),
    positions = {},
    orientations = {},
    possibleO = {0, math.rad(90), math.rad(180), math.rad(270)},
    howWell = {}
}

function Workers:draw()
    for i, pos in ipairs(self.positions) do
        
        if self.howWell[i] > 1 then
            lg.setColor(0, 1, 0)
        elseif self.howWell[i] > 0 then
            lg.setColor(1, 0.5, 0)
        else
            lg.setColor(1, 0, 0)
        end

        lg.rectangle("fill", pos.x, pos.y, self.image:getWidth(), self.image:getHeight())
        lg.setColor(1, 1, 1)
        lg.draw(self.image, pos.x + self.image:getWidth() / 2, pos.y + self.image:getHeight() / 2, self.orientations[i], 1, 1, self.image:getWidth() / 2, self.image:getHeight() / 2)
    end
end

function Workers:update(dt)
    for i, w in ipairs(self.howWell) do
        self.howWell[i] = self.howWell[i] - dt * 0.25

        if AABB(player.x, player.y, player.image:getWidth(), player.image:getHeight(), self.positions[i].x, self.positions[i].y, self.image:getWidth(), self.image:getHeight()) then
            self.howWell[i] = 2
        end
    end
end

function Workers:addWorker()
    for i = 0, 5 do
        local newX = love.math.random(0, gameWidth - self.image:getWidth())
        local newY = love.math.random(0, gameWidth - self.image:getHeight())
        
        for _, pos in ipairs(self.positions) do
            if AABB(newX, newY, self.image:getWidth(), self.image:getHeight(), pos.x, pos.y, self.image:getWidth(), self.image:getHeight()) then
                break
            end
        end

        table.insert(self.positions, {x = newX, y = newY})
        table.insert(self.orientations, self.possibleO[math.floor(love.math.random(#self.possibleO) + 1)])
        table.insert(self.howWell, 2)
        break

    end
end

Workers:addWorker()

return Workers