-- LoveMenu/Bootstrap.lua
module("LoveMenu.Bootstrap", package.seeall)

require "Tools/Object"
require "LoveMenu/Menu"

local Bootstrap = {}

function Bootstrap.initialize()
   local obj = { menu=nil }
   return Ncr7.tObject.New._object(Bootstrap, obj)
end

function new()
  return Bootstrap.initialize()
end

function initConfig()
  -- Ncr7Container Love2D functions
  local bootstrap=LoveMenu.Bootstrap.new()
  bootstrap._global['Container']:reg('Love.load'):push(bootstrap);
  bootstrap._global['Container']:reg('Love.draw'):push(bootstrap);
  bootstrap._global['Container']:reg('Love.mousereleased'):push(bootstrap);
  bootstrap._global['Container']:reg('Love.mousemoved'):push(bootstrap);
  return bootstrap
end

function Bootstrap:load()
  self.menu=LoveMenu.Menu.new()
end

function Bootstrap:draw()
  self.menu:draw()
end

function Bootstrap:mousereleased(mouseevent)
  self.menu:mousereleased(mouseevent)
end

function Bootstrap:mousemoved(mouseevent)
  self.menu:mousemoved(mouseevent)
end


function Bootstrap:getMenu()
  return self.menu
end

function Bootstrap:setMenu(menu)
  self.menu=menu
  return self
end
