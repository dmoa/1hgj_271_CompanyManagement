la = love.audio
ld = love.data
le = love.event
lfile = love.filesystem
lf = love.font
lg = love.graphics
li = love.image
lj = love.joystick
lk = love.keyboard
lm = love.math
lmouse = love.mouse
lp = love.physics
lsound = love.sound
lsys = love.system
lth = love.thread
lt = love.timer
ltouch = love.touch
lv = love.video
lw = love.window

lg.setDefaultFilter("nearest", "nearest", 1)
lg.setLineStyle('rough')

splash = require "libs/splash"

function love.draw() splash:update() end
splash:startSplashScreen("start_screen.png", "", 1500, 500, 0, {}, function()


push = require "libs/push"
gameWidth, gameHeight = 1000, 1000
windowL = 1000
lw.setMode(windowL, windowL, {borderless = false})
push:setupScreen(gameWidth, gameHeight, windowL, windowL, {fullscreen = false, resizable = true, borderless = false})

screen = require "libs/shack"
screen:setDimensions(push:getDimensions())

input = require "libs/Input"
require "libs/AABB"

player = require "Player"
workers = require "Workers"

font = lg.newFont(50)
score = 0
scoreText = lg.newText(font, score)


function love.draw()
    screen:apply()
    push:start()

    
    workers:draw()
    player:draw()
    lg.draw(scoreText, 0, 0)

    push:finish()
end

function love.update(dt)
    screen:update(dt)

    for _, w in ipairs(workers.howWell) do
        score = score + dt * w * 1
    end
    
    scoreText:set("Money: "..math.floor(score))
    if score / 5 > math.pow(#workers.positions, 2) then
        workers:addWorker()
    end

    workers:update(dt)
    player:update(dt)
end

function love.keypressed(key)
    if key == "escape" then le.quit() end
    if key == "return" and lk.isDown("lalt") then push:switchFullscreen() end
end

function love.resize(w, h)
  push:resize(w, h)
  loadingScreen.angle = 0
  lg.clear()
end

end)