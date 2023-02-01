local idle_time = 0
local time_before_sleep = 1800

function love.reset_idle_time()
    idle_time = 0
end

function love.load()
	--libraries
    anim8 = require("libraries/anim8")
	gamera = require("libraries/gamera")

	--modules
	grid = require("drawing/grid")
    input_management = require("input_management/input_management")
    player = require("player/player")

	--love settings
    height = 600
    width = 800 
    love.window.setMode(width, height, {resizable=false, vsync=false})
    love.window.setTitle("Little Fox")
    love.window.height = height
    love.window.width = width
    love.graphics.setBackgroundColor(0.1, 0.1, 0.1)
	love.graphics.setDefaultFilter( 'nearest', 'nearest' )

	--load background
	background = {}
	background.middleground = love.graphics.newImage("assets/backgrounds/forest/middleground (z 0).png")
	--load sounds
    bg_music = love.audio.newSource("assets/sounds/music/a-robust-crew.mp3", "stream")
    bg_music:play()

	--create camera
	local cam = gamera.new(0,0,2000,2000)

end

function love.update(dt)
    idle_time = idle_time + 1
    player.direction = manage_input.check_keyboard_input()
    if (player.direction == "up" and (player.y - player.speed) > 0) then
        player.y = player.y - player.speed
    end
    if (player.direction == "down" and (player.y + player.speed) < love.window.height - 64) then
        player.y = player.y + player.speed
    end
    if (player.direction == "left" and (player.x - player.speed) > 0) then
        player.x = player.x - player.speed
    end
    if (player.direction == "right" and (player.x + player.speed) < love.window.width - 80) then
        player.x = player.x + player.speed
    end
    if (player.direction ~= "left_idle" and direction ~= "right_idle") then
        love.reset_idle_time()
    end
    if ((player.direction == "right" or player.direction == "left") and idle_time < time_before_sleep) then
        player.animations.run:update(dt)
    elseif ((player.direction == "left_idle" or player.direction == "right_idle") and idle_time < time_before_sleep) then
        player.animations.idle:update(dt)
    elseif (idle_time > time_before_sleep) then
        player.animations.sleep:update(dt)
    end
end

local function drawCameraView(l,t,w,h)
	love.graphics.draw(background.middleground, -100, 130, 0, 0.2, 0.2)
	if (player.direction == "right") then
        player.animations.run:draw(player.spriteSheet, player.x, player.y)
    elseif (player.direction == "left") then
        player.animations.run:draw(player.spriteSheet, player.x, player.y, 0, -1, 1, 96, 0)
    elseif (player.direction == "right_idle" and idle_time < time_before_sleep) then
        player.animations.idle:draw(player.spriteSheet, player.x, player.y)
    elseif (player.direction == "left_idle" and idle_time < time_before_sleep) then
        player.animations.idle:draw(player.spriteSheet, player.x, player.y, 0, -1, 1, 96, 0)
    elseif (idle_time > time_before_sleep and player.direction == "right_idle") then
        player.animations.sleep:draw(player.spriteSheet, player.x, player.y)
    elseif (idle_time > time_before_sleep and player.direction == "left_idle") then
        player.animations.sleep:draw(player.spriteSheet, player.x, player.y, 0, -1, 1, 96, 0)
    end
end

function love.draw()
    --grid.draw()
    --love.graphics.print(direction, 10, 10)
	drawCameraView(0,0,love.window.width,love.window.height)
end