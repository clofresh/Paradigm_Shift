animation = {}

Animations = {
  ["standing"]  = {love.graphics.newImage("standing.png"),  17, 32, 0.1},
  ["walking"]   = {love.graphics.newImage("walking.png"),   17, 32, 0.1},
  ["running"]   = {love.graphics.newImage("running.png"),   22, 32, 0.1},
  ["punching"]  = {love.graphics.newImage("punching.png"),  29, 32, 0.1}
}

function animation.getAnimation(name)
  return love.graphics.newAnimation(unpack(Animations[name]))
end