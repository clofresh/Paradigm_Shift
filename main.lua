require "player.lua"
require "npc.lua"

love.filesystem.require("camera.lua")

function load()
  player = Player.new(100, 300)
  badguy = BadGuy.new(400, 300)
end

function update(dt)
  player:update(dt)
  badguy:update(dt)
end

function draw()
  player:draw()
  badguy:draw()
  getCamera():setOrigin(player:get_x() - 150, player:get_y() - 275)
end

function keypressed(key) 
	if key == love.key_tab then
		love.system.restart() 
	end
end


camera.lateInit()

