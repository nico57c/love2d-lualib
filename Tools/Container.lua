-- Tools/Container.lua
module("Ncr7.tContainer", package.seeall)

require "Tools/Object"
require "Tools/Register"

local Container = {}

function Container.initialize()
   local obj = { register=Ncr7.tRegister.new() }
   local container = Ncr7.tObject.New._object(Container, obj)
   return container
end

function Container:init(containersName)
  if(nil~=containersName) then
    for value,key in pairs(containersName) do
      self.register:createRegister(key)
    end
  end
end

function Container:reg(key)
  if(key == nil) then
    return self.register
  else
    return self.register:get(key)
  end
end

function Container:setParameter(key,value)
  return self.register:get('Container'):set(key,value)
end

function Container:getParameter(key)
  return self.register:get('Container'):get(key)
end

function new()
  return Container.initialize()
end
