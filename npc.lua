love.filesystem.require "animation.lua"

BadGuy = {}
BadGuy.__index = BadGuy

function BadGuy.new(world, x, y)
  local properties = {
    id = "badguy",
    body = love.physics.newBody(world, x, y),
    direction = 1,
    actions = {}    
  }
  properties.bounding_box = love.physics.newRectangleShape(properties.body, 17, 32)
  properties.bounding_box:setData(properties.id)
  properties.body:setMassFromShapes()

  setmetatable(properties, BadGuy)
  return properties
end

function BadGuy:get_x()
  return self.body:getX()
end

function BadGuy:get_y()
  return self.body:getY()
end

function BadGuy:set_x(val)
  return self.body:setX(val)
end

function BadGuy:set_y(val)
  return self.body:setY(val)
end

function BadGuy:get_id()
  return self.id
end

function BadGuy:update(dt)
  self.image = animation.getAnimation("standing")
  self.image:update(dt)
end

function BadGuy:draw(dt)
  love.graphics.draw(self.image, self:get_x(), self:get_y(), 0, self.direction, 1)
end

