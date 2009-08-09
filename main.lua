love.filesystem.require "camera.lua"
love.filesystem.require "player.lua"
love.filesystem.require "npc.lua"
love.filesystem.require "environment.lua"

function load()
  local environment = Environment.new(love.graphics.getWidth()*1.5, love.graphics.getHeight())
  environment:setGravity(0, 500)

  local player = Player.new(environment.world, 100, 300)

  entities = {
    ["environment"] = environment,
    ["player"] = player,
    badguy = BadGuy.new(environment.world, 400, 300),
    camera = ChaseCam.new(player, environment)
  }

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
end

function keypressed(key) 
	if key == love.key_tab then
		love.system.restart() 
	end
end



camera.lateInit()

