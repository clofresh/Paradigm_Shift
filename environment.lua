Environment = {}
Environment.__index = Environment

function Environment.new(w, h)
  local properties = {
    id = "ground",
    world = love.physics.newWorld(w, h),
    width = w,
    height = h,
    text = ""
  }

	properties.ground = love.physics.newBody(properties.world, 0, 0, 0)
	properties.ground_shape = love.physics.newRectangleShape(properties.ground, 512, 512, 1024, 50)
  properties.ground_shape:setData(properties.id)

	properties.world:setCallback(
	  function (shape1, shape2, contact)
  	  return Environment.collision(properties, shape1, shape2, contact)
	  end
	) 

  love.graphics.setFont(love.graphics.newFont(love.default_font, 12)) 

  setmetatable(properties, Environment)
  return properties
end

function Environment:get_id()
  return self.id
end

function Environment:setGravity(gx, gy)
  self.world:setGravity(gx, gy)
end

function Environment:update(dt)
  self.world:update(dt)
end

function Environment:draw(dt)
	love.graphics.polygon(love.draw_line, self.ground_shape:getPoints())
  love.graphics.draw(self.text, 50, 50) 
end

function Environment.collision(self, shape1, shape2, contact) 
    
   local f, r = contact:getFriction(), contact:getRestitution() 
   local s = contact:getSeparation() 
   local px, py = contact:getPosition() 
   local vx, vy = contact:getVelocity() 
   local nx, ny = contact:getNormal() 
 
   self.text = "Last Collision:\n" 
   self.text = self.text .. "Shapes: " .. shape1 .. " and " .. shape2 .. "\n" 
   self.text = self.text .. "Position: " .. px .. "," .. py .. "\n" 
   self.text = self.text .. "Velocity: " .. vx .. "," .. vy .. "\n" 
   self.text = self.text .. "Normal: " .. nx .. "," .. ny .. "\n" 
   self.text = self.text .. "Friction: " .. f .. "\n" 
   self.text = self.text .. "Restitution: " .. r .. "\n" 
   self.text = self.text .. "Separation: " .. s .. "\n" 
   
  for i, entity_id in ipairs({shape1, shape2}) do
    entity = EntityManager.entities[entity_id]
    if entity and entity["set_can_jump"] then
      entity:set_can_jump(1)
    end
  end
end 

ChaseCam = {}
ChaseCam.__index = ChaseCam

function ChaseCam.new(to_follow, environment)
  local properties = {
    id = 'chasecam',
    ["to_follow"] = to_follow,
    ["environment"] = environment
  }

  setmetatable(properties, ChaseCam)
  return properties
end

function ChaseCam:get_id()
  return self.id
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




EntityManager = {
  entities = {},

  update = function(dt)
    for name, entity in pairs(EntityManager.entities) do
      entity:update(dt)
    end
  end,
  
  draw = function()
    for name, entity in pairs(EntityManager.entities) do
      entity:draw()
    end
  end

}










