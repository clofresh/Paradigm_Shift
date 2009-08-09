love.filesystem.require "camera.lua"
love.filesystem.require "player.lua"
love.filesystem.require "npc.lua"
love.filesystem.require "environment.lua"

function load()
  local environment = Environment.new(love.graphics.getWidth()*1.5, love.graphics.getHeight())
  environment:setGravity(0, 500)

  local player = Player.new(environment.world, 100, 300)

  local entities = {
    ["environment"] = environment,
    ["player"] = player,
    badguy = BadGuy.new(environment.world, 400, 300),
    camera = ChaseCam.new(player, environment)
  }
  
  for name, entity in pairs(entities) do
    EntityManager.entities[name] = entity
  end

end

function update(dt)
  EntityManager.update(dt)
end

function draw()
  EntityManager.draw()
end

function keypressed(key) 
	if key == love.key_tab then
		love.system.restart() 
	end
end



camera.lateInit()

