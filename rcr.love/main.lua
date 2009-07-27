require "player.lua"
require "npc.lua"

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
end

function keypressed(key) 
	if key == love.key_tab then
		love.system.restart() 
	end
end


