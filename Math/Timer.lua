-- Math/Timer.lua
module("Ncr7.mtTimer", package.seeall)

require "Tools/Object"

local Timer={}

function Timer.initialize(from, to, inc)
  local obj={from=from or 0, to=to or 60, time=from or 0, index=0, inc=inc or 1, halt=true, loop=false}
  return Ncr7.tObject.New._object(Timer, obj)
end

function new(from, to, inc)
  return Timer.initialize(from, to, inc)
end

function Timer:current()
  return self.time
end

function Timer:getIndex()
  return self.index
end

-- Return true if timer is not finished
-- Return false if timer is finished
function Timer:valid()
  if (self.from>self.to and self.time<=self.to) or
     (self.from<self.to and self.time>=self.to) then
    return false
  elseif(self.from==self.to) then
    return false
  end
  
  return true
end

--[[
 disabled-loop : while(:next()){ ... :current() }
 enabled-loop : while(!:next()){ ... :current() }
]]--
function Timer:next(loops)
  if self.halt then
    return nil
  end
  
  if(nil==loops) then
    loops = 1
  else
    loops = math.floor(loops)
  end
  
  if self:valid() then
    if self.from>self.to then
      self.time=self.time-(self.inc * loops)
      self.index=self.index+1
    elseif self.from<self.to then
      self.time=self.time+(self.inc * loops)
      self.index=self.index+1
    end
  end
  
  if self.loop then
    if false==self:valid() then
      local result=math.floor((self.inc * loops)/math.abs(self.to-self.from))+1
      self:rewind():start()
      return result
    else
      return 0
    end
  elseif(false==self:valid()) then
    return 0
  else
    return 1
  end
end

function Timer:rewind()
  self.time=self.from
  self.index=0
  self.halt=true
  return self
end

function Timer:start()
  self.halt=false
  return self
end

function Timer:stop()
  self.halt=true
  return self
end

function Timer:pause()
  if self.halt then
    self.halt=false
  else
    self.halt=true
  end
  return self
end

function Timer:toString(format,length)
  local timeStr = string.gsub(string.format("%" .. length .. "i",self:current())," ", "0")
  return string.gsub(format, "c([1-9]*)", function(index) return string.sub(timeStr, index,index) end )
end

function Timer:enableLoop()  
  self.loop = true
  return self
end

function Timer:disableLoop()
  self.loop = false
  return self
end
