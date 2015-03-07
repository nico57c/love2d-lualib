-- LoveConsole/Bootstrap.lua
module("LoveConsole.Bootstrap", package.seeall)

require "Tools/Object"
require "LoveConsole/Console"

local Bootstrap = {}

function Bootstrap.initialize()
   local obj = { console=nil }
   return Ncr7.tObject.New._object(Bootstrap, obj)
end

function new()
  return Bootstrap.initialize()
end

function initConfig()
  -- Ncr7Container Love2D functions
  local bootstrap=LoveConsole.Bootstrap.new()
  bootstrap._global['Container']:reg('Love.load'):push(bootstrap);
  bootstrap._global['Container']:reg('Love.draw'):push(bootstrap);
  bootstrap._global['Container']:reg('Love.textinput'):push(bootstrap);
  bootstrap._global['Container']:reg('Love.keypressed'):push(bootstrap);
  return bootstrap
end


function Bootstrap:load()
  self.console=LoveConsole.Console.new()
end

function Bootstrap:draw()
  -- Voir où placer ces deux lignes
  love.keyboard.setKeyRepeat(150, 50)
  love.graphics.setBackgroundColor(34,34,34)
  self.console:draw(0, love.graphics.getHeight()/3)
end

function Bootstrap:textinput(text)
  self.console:textinput(text)
end

function Bootstrap:keypressed(key)
  self.console:keypressed(key)
end

function Bootstrap:getConsole()
  return self.console
end

function Bootstrap:setConsole(console)
  self.console=console
  return self
end
