p1 = {}
p2 = {}
env = {}
physics = {}
debug = true

function love.load()
  env.width = love.graphics.getWidth()
  env.height = love.graphics.getHeight()
  env.collideDown = 100

  physics.fallMultiplier = 80
  physics.lowJumpMultiplier = 60
  physics.grav = -15

  p1.xpos = 300
  p1.ypos = 300
  p1.xvel = 0
  p1.yvel = 0
  p1.height = 32
  p1.width = 32
  p1.grounded = false
  p1.img = love.graphics.newImage("assets/player.png")
end

function love.update(dt)
  p1.xvel = 0
  if love.keyboard.isDown('a') then
    p1.xvel = -200
  end
  if love.keyboard.isDown('d') then
    p1.xvel = p1.xvel + 200
  end
  if love.keyboard.isDown('w') and p1.grounded then
    p1.yvel = 400
  end
  p1.yvel = p1.yvel + physics.grav
  if p1.yvel < 0 then
    p1.yvel = p1.yvel + physics.grav * (physics.fallMultiplier - 1) * dt
  elseif p1.yvel > 0 and not love.keyboard.isDown('w') then
    p1.yvel = p1.yvel + physics.grav * (physics.lowJumpMultiplier - 1) * dt
  end
  movePlayer(p1, dt)
end

function love.draw()
  love.graphics.rectangle("fill", 0, env.height, env.width, -env.collideDown)
  love.graphics.draw(p1.img, math.floor(p1.xpos+0.5), math.floor(env.height-p1.ypos+0.5))

  if debug then
    love.graphics.circle("fill", p1.xpos, env.height-p1.ypos, 5)
    love.graphics.print("x: "..math.floor(p1.xpos+0.5),0,0)
  end
end

function movePlayer(player, dt)
  player.xpos = player.xpos + player.xvel * dt
  player.ypos = player.ypos + player.yvel * dt
  if player.ypos - player.height <= env.collideDown then
    player.ypos = env.collideDown + player.height
    player.yvel = 0
    player.grounded = true
  else
    player.grounded = false
  end
end
