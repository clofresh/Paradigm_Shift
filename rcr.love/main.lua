Player = {}
Player.__index = Player

function Player.new(x, y)
  local properties = {}
  setmetatable(properties, Player)
  properties.x = x
  properties.y = y
  properties.direction = 1
  return properties
end

function Player:update(dt)
  local keys_pressed = {}
  
  if love.keyboard.isDown(love.key_a) then
    self.x = self.x - (100 * dt)
    table.insert(keys_pressed, love.key_a)
    self.direction = -1
  elseif love.keyboard.isDown(love.key_d) then
    self.x = self.x + (100 * dt)
    table.insert(keys_pressed, love.key_d)
    self.direction = 1
  end

  if love.keyboard.isDown(love.key_w) then
    self.y = self.y - (100 * dt)
    table.insert(keys_pressed, love.key_w)
  elseif love.keyboard.isDown(love.key_s) then
    self.y = self.y + (100 * dt)
    table.insert(keys_pressed, love.key_s)
  end
  
  if table.getn(keys_pressed) > 0 then
    if self.animation == "standing" then
      self.image = love.graphics.newAnimation(unpack(Animations["walking"]))
      self.animation = "walking"
    end
  else
    self.image = Animations["standing"][1]
    self.animation = "standing"
    
    if self.direction == -1 then
      -- weird workaround because negative scaling on an image
      -- behaves differently from negative scaling an animation
      self.image:setCenter(24, self.image:getHeight() / 2)
    else
      self.image:setCenter(
        self.image:getWidth() / 2, 
        self.image:getHeight() / 2
      )
    end
  end
  
  self.image:update(dt)
end

function Player:draw()
  love.graphics.draw(self.image, self.x, self.y, 0, self.direction, 1)
  
  -- Draw player's coordinate axis for debugging
  -- love.graphics.line(self.x - 100, self.y, self.x + 100, self.y)
  -- love.graphics.line(self.x, self.y - 100, self.x, self.y + 100)
end



function load()
  Animations = {
    ["standing"] = {love.graphics.newImage("standing.png"), 17, 32, 0.1},
    ["walking"]  = {love.graphics.newImage("walking.png"),  17, 32, 0.1},
    ["running"]  = {love.graphics.newImage("running.png"),  22, 32, 0.1}
  }

  player = Player.new(400, 300)
end

function update(dt)
  player:update(dt)
end

function draw()
  player:draw()
end


