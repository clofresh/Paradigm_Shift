require "animation.lua"

Player = {}
Player.__index = Player

function Player.new(x, y)
  local properties = {}
  setmetatable(properties, Player)
  properties.x = x
  properties.y = y
  properties.direction = 1
  properties.actions = {}
  
  return properties
end

function Player:update(dt)
  local next_actions = {}
  
  if love.keyboard.isDown(love.key_a) then
    self.x = self.x - (100 * dt)
    next_actions["walking"] = true
    self.direction = -1
  elseif love.keyboard.isDown(love.key_d) then
    self.x = self.x + (100 * dt)
    next_actions["walking"] = true
    self.direction = 1
  end

  if love.keyboard.isDown(love.key_w) then
    self.y = self.y - (100 * dt)
    next_actions["walking"] = true
  elseif love.keyboard.isDown(love.key_s) then
    self.y = self.y + (100 * dt)
    next_actions["walking"] = true
  end
  
  if love.keyboard.isDown(love.key_space) then
    next_actions["punching"] = true
  else
    self.actions["punching"]  = false
  end

  if next_actions["punching"] then
    if not self.actions["punching"] then
      self.image = animation.getAnimation("punching")
      self.actions["punching"] = true
    end
  elseif next_actions["walking"] then
    if self.actions["standing"] then
      self.image = animation.getAnimation("walking")
      self.actions["walking"] = true
      self.actions["standing"] = false
    end
  else
    self.image = animation.getAnimation("standing")
    self.actions["standing"] = true
    self.actions["walking"] =  false
  end
    
  self.image:update(dt)
end

function Player:draw()
  love.graphics.draw(self.image, self.x, self.y, 0, self.direction, 1)
  
  -- Draw player's coordinate axis for debugging
  -- love.graphics.line(self.x - 100, self.y, self.x + 100, self.y)
  -- love.graphics.line(self.x, self.y - 100, self.x, self.y + 100)
end

