-- Bootstrap
package.path = package.path .. ";" .. "./?.lua" .. ";" 

require "Tools/Container"
local love2Dcontainer = Ncr7.tContainer.bootstrap('/')
-- End (bootstrap)

-- Load modules
require "LoveConsole/Tests/Console"
require "LoveHud/Tests/Hud"
require "LoveMenu/Tests/Menu"

-- End (Load modules)

-- Exec programme
function love.load()
  table.foreach(_G.Container:reg('Love.load'):getData(), 
    function(k,v)
      if('table' == type(v)) then
        v:load()
      else
        v()
      end
    end)
end

function love.draw()
  table.foreach(_G.Container:reg('Love.draw'):getData(),
    function(k,v)
      if('table' == type(v)) then
        v:draw()
      else
        v()
      end
    end)
end

function love.keypressed( key )
  table.foreach(_G.Container:reg('Love.keypressed'):getData(),
    function(k,v)
      if('table' == type(v)) then
        v:keypressed(key)
      else
        v(key)
      end
    end)
end

function love.textinput( text )
  table.foreach(_G.Container:reg('Love.textinput'):getData(),
    function(k,v)
      if('table' == type(v)) then
        v:textinput(text)
      else
        v(text)
      end
    end)
end
-- End (Exec programme)

