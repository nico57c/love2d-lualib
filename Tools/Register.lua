-- Tools/Register.lua
module("Ncr7.tRegister", package.seeall)

require "Tools/Object"

local Register = {}

function Register.initialize(name)
   local obj = { data={}, name= name or 'default' }
   return Ncr7.tObject.New._object(Register, obj)
end
  
function Register:set(key,value)
  self.data[key] = value
  return self
end

function Register:has(key)
  return self.data[key] ~= nil
end

function Register:get(key)
  return self.data[key]
end

function Register:push(value)
  self.data[#self.data+1] = value
  return self
end

function Register:remove(key)
  self.data[key] = nil
end

function Register:createRegister(key)
  self.data[key] = Ncr7.tRegister.new()
  return self.data[key]
end

function Register:getData()
  return self.data
end

function Register:getName()
  return self.name
end

function new()
  return Register.initialize()
end