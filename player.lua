love.filesystem.require "animation.lua"

Player = {}
Player.__index = Player
Player.camera_x_offset = -150
Player.camera_y_offset = -275

function Player.new(world, x, y)
  local properties = {
    body = love.physics.newBody(world, x, y),
    speed = 100.0,
    direction = 1,
    actions = {}    
  }
  properties.bounding_box = love.physics.newRectangleShape(properties.body, 17, 32)
  properties.body:setMassFromShapes()

  setmetatable(properties, Player)
  return properties
end

function Player:get_x()
  return self.body:getX()
end

function Player:get_y()
  return self.body:getY()
end

function Player:set_x(val)
  return self.body:setX(val)
end

function Player:set_y(val)
  return self.body:setY(val)
end

function Player:get_camera_x()
  return self:get_x() + Player.camera_x_offset
end

function Player:get_camera_y()
  return self:get_y() + Player.camera_y_offset
end

function Player:update(dt)
  local next_actions = {}
  local velocity = {0.01, 0.01} -- Fixes a bug where you can't move until you hit reset
  
  if love.keyboard.isDown(love.key_a) then
    velocity[1] = -1 * self.speed
    next_actions["walking"] = true
    self.direction = -1
  elseif love.keyboard.isDown(love.key_d) then
    velocity[1] = self.speed
    next_actions["walking"] = true
    self.direction = 1
  end

  if love.keyboard.isDown(love.key_w) then
    velocity[2] = -1 * self.speed
    next_actions["walking"] = true
  elseif love.keyboard.isDown(love.key_s) then
    velocity[2] = self.speed
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

  self.body:setVelocity(unpack(velocity))
  self.image:update(dt)
end

function Player:draw()
  love.graphics.draw(self.image, self:get_x(), self:get_y(), 0, self.direction, 1)
  
  -- Draw player's coordinate axis for debugging
  -- love.graphics.line(self:get_x() - 100, self:get_y(), self:get_x() + 100, self:get_y())
  -- love.graphics.line(self:get_x(), self:get_y() - 100, self:get_x(), self:get_y() + 100)
end

