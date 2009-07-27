require "player.lua"

function load()
  Animations = {
    ["standing"] = {love.graphics.newImage("standing.png"), 17, 32, 0.1},
    ["walking"]  = {love.graphics.newImage("walking.png"),  17, 32, 0.1},
    ["running"]  = {love.graphics.newImage("running.png"),  22, 32, 0.1},
    ["punching"]  = {love.graphics.newImage("punching.png"),  29, 32, 0.1}
  }

  player = Player.new(400, 300)
end

function update(dt)
  player:update(dt)
end

function draw()
  player:draw()
end



function keypressed(key) 
	if key == love.key_tab then
		love.system.restart() 
	end
end


