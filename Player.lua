local Player = {
    image = lg.newImage("player.png"),
    x = love.math.random(gameWidth / 2),
    y = love.math.random(gameHeight / 2),
    xv = 150,
    yv = 150
}


function Player:draw()
    lg.draw(self.image, self.x, self.y)
end

function Player:update(dt)
    if input.right() then
        self.x = self.x + self.xv * dt
    end
    if input.left() then
        self.x = self.x - self.xv * dt
    end
    if input.down() then
        self.y = self.y + self.yv * dt
    end
    if input.up() then
        self.y = self.y - self.yv * dt
    end
    if self.x < 0 then self.x = 0 end
    if self.y < 0 then self.y = 0 end
    if self.x + self.image:getWidth() > gameWidth then self.x = gameWidth - self.image:getWidth() end
    if self.y + self.image:getHeight() > gameHeight then self.y = gameHeight - self.image:getHeight() end
end

return Player