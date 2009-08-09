Environment = {}
Environment.__index = Environment

function Environment.new(w, h)
  local properties = {
    world = love.physics.newWorld(w, h),
    width = w,
    height = h
  }

	properties.ground = love.physics.newBody(properties.world, 0, 0, 0)
	properties.ground_shape = love.physics.newRectangleShape(properties.ground, 512, 512, 1024, 50)
  properties.ground_shape:setData("Ground")

  setmetatable(properties, Environment)
  return properties
end

function Environment:setGravity(gx, gy)
  self.world:setGravity(gx, gy)
end

function Environment:update(dt)
  self.world:update(dt)
end

function Environment:draw(dt)
	love.graphics.polygon(love.draw_line, self.ground_shape:getPoints())
end



ChaseCam = {}
ChaseCam.__index = ChaseCam

function ChaseCam.new(to_follow, environment)
  local properties = {
    ["to_follow"] = to_follow,
    ["environment"] = environment
  }

  setmetatable(properties, ChaseCam)
  return properties
end

function ChaseCam:update(dt)
--  getCamera():setOrigin(entities.player:get_camera_x(), entities.player:get_camera_y())
  
  local cx = self.to_follow:get_camera_x()
  local cy = self.to_follow:get_camera_y()

  if cx < 0 then 
    cx = 0
  elseif cx + love.graphics.getWidth() > self.environment.width then 
    cx = self.environment.width - love.graphics.getWidth()
  end
  
  if cy < 0 then 
    cy = 0
  elseif cy + love.graphics.getHeight() > self.environment.height then 
    cy = self.environment.height - love.graphics.getHeight()
  end
  
  getCamera():setOrigin(cx, cy)
end

function ChaseCam:draw(dt)
end

