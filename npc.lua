require "animation.lua"

BadGuy = {}
BadGuy.__index = BadGuy

function BadGuy.new(x, y)
  local properties = {}
  setmetatable(properties, BadGuy)
  properties.x = x
  properties.y = y
  properties.direction = 1
  properties.actions = {}
  
  return properties
end

function BadGuy:update(dt)
  self.image = animation.getAnimation("standing")
  
  self.image:update(dt)
end

function BadGuy:draw(dt)
  love.graphics.draw(self.image, self.x, self.y, 0, self.direction, 1)
end

