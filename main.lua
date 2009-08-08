love.filesystem.require "player.lua"
love.filesystem.require "npc.lua"
love.filesystem.require "camera.lua"

function load()
  world = love.physics.newWorld(love.graphics.getWidth(), love.graphics.getHeight())
  entities = {
    player = Player.new(world, 100, 300),
    badguy = BadGuy.new(world, 400, 300)
  }
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
  getCamera():setOrigin(entities.player:get_camera_x(), entities.player:get_camera_y())
end

function keypressed(key) 
	if key == love.key_tab then
		love.system.restart() 
	end
end


camera.lateInit()

