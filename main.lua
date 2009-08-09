love.filesystem.require "camera.lua"
love.filesystem.require "player.lua"
love.filesystem.require "npc.lua"
love.filesystem.require "environment.lua"

function load()
  local font = love.graphics.newFont(love.default_font, 12) 
  love.graphics.setFont(font) 
  
  local environment = Environment.new(love.graphics.getWidth()*1.5, love.graphics.getHeight())
  environment:setGravity(0, 500)

  entities = {
    ["environment"] = environment,
    player = Player.new(environment.world, 100, 300),
    badguy = BadGuy.new(environment.world, 400, 300)
  }

  entities.camera = ChaseCam.new(entities.player, environment)

	environment.world:setCallback(collision) 
  text = ""
end

function update(dt)
  for name, entity in pairs(entities) do
    entity:update(dt)
  end
end

function draw()
  for name, entity in pairs(entities) do
    entity:draw()
  end
  love.graphics.draw(text, 50, 50) 
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

camera.lateInit()

