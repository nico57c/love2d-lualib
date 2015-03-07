-- Math/Timer.lua
module("Ncr7.mtTimer", package.seeall)

require "Tools/Object"

local Timer={}

function Timer.initialize(from, to, inc)
  local obj={from=from or 0, to=to or 60, time=from or 0, key=0, inc=inc or 1, halt=true}
  return Ncr7.tObject.New._object(Timer, obj)
end

function new(from, to, inc)
  return Timer.initialize(from, to, inc)
end

function Timer:current()
  return self.time
end

function Timer:key()
  return self.key
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

function Timer:next(loops)
  if self.halt then
    return self
  end
  
  loops = math.floor(loops) or 1
  if self:valid() then
    if self.from>self.to then
      self.time=self.time-(self.inc * loops)
      self.key=self.key+1
    elseif self.from<self.to then
      self.time=self.time+(self.inc * loops)
      self.key=self.key+1
    end
  end
  return self
end

function Timer:rewind()
  self.time=self.from
  self.key=0
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

