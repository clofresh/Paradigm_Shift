love.filesystem.require "animation.lua"

Player = {}
Player.__index = Player
Player.camera_x_offset = -150
Player.camera_y_offset = -275

function Player.new(world, x, y)
  local properties = {
    id = "player",
    body = love.physics.newBody(world, x, y),
    speed = 10000,
    jump = 5000000,
    can_jump = nil,
    direction = 1,
    actions = {}    
  }
  properties.bounding_box = love.physics.newRectangleShape(properties.body, 17, 32)
  properties.bounding_box:setFriction(1)
  properties.bounding_box:setRestitution(0.05)
  properties.bounding_box:setData(properties.id)
  properties.body:setMassFromShapes()
--  properties.fist = love.physics.newBody(world, x + 10, y - 5)
--  properties.fist:setMass(0, 0, 5, 0)
--[[
  properties.arm = love.physics.newPrismaticJoint(
    properties.body,
    properties.fist, 
    properties.body:getX() + 10, 
    properties.body:getY() - 5, 
    properties.body:getX() + 20, 
    properties.body:getY() - 5
  )

]]--

  setmetatable(properties, Player)
  return properties
end

function Player:get_id()
  return self.id
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

function Player:get_can_jump()
  return self.can_jump
end

function Player:set_can_jump(val)
  self.can_jump = val
end

function Player:update(dt)
  local next_actions = {}
  
  if love.keyboard.isDown(love.key_a) then
    next_actions["walking"] = true
    self.direction = -1
  elseif love.keyboard.isDown(love.key_d) then
    self.body:applyImpulse(self.speed, 0)
    next_actions["walking"] = true
    self.direction = 1
  end

  if love.keyboard.isDown(love.key_w) and self:get_can_jump() then
    next_actions["jumping"] = true

    vx, vy = self.body:getVelocity()
    self.body:applyImpulse(0, -1 * self.jump)
    self:set_can_jump(nil)

  elseif love.keyboard.isDown(love.key_s) then
    -- nothing
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
      self.fist:applyForce(100 * self.direction, 0)
    end
  elseif next_actions["walking"] then
    self.body:applyImpulse(self.direction * self.speed, 0)
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
  love.graphics.draw(self.image, self:get_x(), self:get_y(), 0, self.direction, 1)
--  love.graphics.circle(love.draw_fill, self.fist:getX(), self.fist:getY(), 5)
  
  -- Draw player's coordinate axis for debugging
  -- love.graphics.line(self:get_x() - 100, self:get_y(), self:get_x() + 100, self:get_y())
  -- love.graphics.line(self:get_x(), self:get_y() - 100, self:get_x(), self:get_y() + 100)
end

