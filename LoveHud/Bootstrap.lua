-- LoveHud/Bootstrap.lua
module("LoveHud.Bootstrap", package.seeall)

require "Tools/Object"
require "LoveHud/Hud"

local Bootstrap = {}

function Bootstrap.initialize()
   local obj = { hud=nil }
   return Ncr7.tObject.New._object(Bootstrap, obj)
end

function new()
  return Bootstrap.initialize()
end

function initConfig()
  -- Ncr7Container Love2D functions
  local bootstrap=LoveHud.Bootstrap.new()
  bootstrap._global['Container']:reg('Love.load'):push(bootstrap);
  bootstrap._global['Container']:reg('Love.draw'):push(bootstrap);
  return bootstrap
end

function Bootstrap:load()
  self.hud=LoveHud.Hud.new()
end

function Bootstrap:draw()
  self.hud:draw()
end

function Bootstrap:getHud()
  return self.hud
end

function Bootstrap:setHud(hud)
  self.hud=hud
  return self
end
