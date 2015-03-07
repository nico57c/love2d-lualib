-- Bootstrap
package.path = package.path .. ";" .. "./?.lua" .. ";" ..
               love.filesystem.getWorkingDirectory() .. "/Tests/vendor/?.lua" .. ";" ..
               love.filesystem.getWorkingDirectory() .. "/Tests/?.lua" .. ";" ..
               love.filesystem.getWorkingDirectory() .. "/Tests/lib/?.lua" .. ";" ..
               love.filesystem.getWorkingDirectory() .. "/Tests/vendor/?" .. ";" ..
               love.filesystem.getWorkingDirectory() .. "/Tests/?" .. ";" ..
               love.filesystem.getWorkingDirectory() .. "/Tests/lib/?" .. ";" 
               
require "Tools/Container"
local love2Dcontainers = {'Love.load','Love.draw','Love.keypressed','Love.textinput'}
local _G = Ncr7.tObject.getGlobal()
_G.Container = Ncr7.tContainer.new()
_G.Container:init(love2Dcontainers)
-- End (bootstrap)

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

