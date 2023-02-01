player = {}

player.x = 100
player.y = 100
player.speed = 0.5
player.direction = "right_idle"
player.image = love.graphics.newImage(fox)
player.spriteSheet = love.graphics.newImage("assets/sprites/fox/FoxSpriteSheet.png")
player.grid = anim8.newGrid(96, 96, player.spriteSheet:getWidth(), player.spriteSheet:getHeight())
player.animations = {}
player.animations.idle = anim8.newAnimation(player.grid('1-4', 1), 0.2)
player.animations.run = anim8.newAnimation(player.grid('1-8', 3), 0.1)
player.animations.sleep = anim8.newAnimation(player.grid('1-6', 6), 0.2)

return player