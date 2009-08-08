love.filesystem.require "player.lua"
love.filesystem.require "npc.lua"
--love.filesystem.require "camera.lua"

function load()
  local font = love.graphics.newFont(love.default_font, 12) 
  love.graphics.setFont(font) 

  world = love.physics.newWorld(love.graphics.getWidth(), love.graphics.getHeight())
  world:setGravity(0, 500)
  
  entities = {
    player = Player.new(world, 100, 300),
    badguy = BadGuy.new(world, 400, 300)
  }

	ground = love.physics.newBody(world, 0, 0, 0)
	ground_shape = love.physics.newRectangleShape(ground, 0, 500, 100000, 50)
  ground_shape:setData("Ground")
	world:setCallback(collision) 
  text = ""
end

function update(dt)
  world:update(dt)
  for name, entity in pairs(entities) do
    entity:update(dt)
  end
end

function draw()
  for name, entity in pairs(entities) do
    entity:draw()
  end

	love.graphics.polygon(love.draw_line, ground_shape:getPoints())
  love.graphics.draw(text, 50, 50) 
--  getCamera():setOrigin(entities.player:get_camera_x(), entities.player:get_camera_y())
end

function keypressed(key) 
	if key == love.key_tab then
		love.system.restart() 
	end
end

function collision(a, b, c) 
    
   local f, r = c:getFriction(), c:getRestitution() 
   local s = c:getSeparation() 
   local px, py = c:getPosition() 
   local vx, vy = c:getVelocity() 
   local nx, ny = c:getNormal() 
 
   text = "Last Collision:\n" 
   text = text .. "Shapes: " .. a .. " and " .. b .. "\n" 
   text = text .. "Position: " .. px .. "," .. py .. "\n" 
   text = text .. "Velocity: " .. vx .. "," .. vy .. "\n" 
   text = text .. "Normal: " .. nx .. "," .. ny .. "\n" 
   text = text .. "Friction: " .. f .. "\n" 
   text = text .. "Restitution: " .. r .. "\n" 
   text = text .. "Separation: " .. s .. "\n" 
 
 
  for i, entity_id in ipairs({a, b}) do
    if entities[entity_id] and entities[entity_id]["set_can_jump"] then
      entities[entity_id]:set_can_jump(1)
    end
  end
end 

--camera.lateInit()

