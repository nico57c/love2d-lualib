-- Math/Clock.lua
module("Ncr7.mtTimeClock", package.seeall)

require "Tools/Object"
require "Math/Timer"

local TimeClock={}

function TimeClock.initialize(activeMs)
  local obj={timers={h=nil,m=nil,s=nil,ms=nil}, times={}, halt=false, activeMs=activeMs}
  obj.timers.h = Ncr7.mtTimer.new(0,23,1):enableLoop()  -- max 24h
  obj.timers.m = Ncr7.mtTimer.new(0,59,1):enableLoop()  -- max 60m
  obj.timers.s = Ncr7.mtTimer.new(0,59,1):enableLoop()  -- max 60s
  obj.timers.ms = Ncr7.mtTimer.new(0,999,1):enableLoop() -- max 1000ms
  
  return Ncr7.tObject.New._object(TimeClock, obj)
end

function new(activeMs)
  return TimeClock.initialize(activeMs or false)
end

function TimeClock:rewind()
  self.timers.h:rewind()
  self.timers.m:rewind()
  self.timers.s:rewind()
  self.timers.ms:rewind()
  return self
end

function TimeClock:start()
  self.halt=false
  self.timers.ms:start()
  self.timers.s:start()
  self.timers.m:start()
  self.timers.h:start()
  return self
end

function TimeClock:stop()
  self.halt=true
  self.timers.ms:stop()
  self.timers.s:stop()
  self.timers.m:stop()
  self.timers.h:stop()
  return self
end

function TimeClock:pause()
  if self.halt then
    self.halt=false
  else
    self.halt=true
  end
  self.timers.ms:pause()
  self.timers.s:pause()
  self.timers.m:pause()
  self.timers.h:pause()
  return self
end

function TimeClock:next(loops)
  if self.halt then
    return self
  end
  
  -- ms + s
  if self.activeMs then
    loops=self.timers.ms:next(loops)
    if loops>=1 then
      loops=self.timers.s:next(loops)
    end
  else
    loops=self.timers.s:next()
  end
  
  -- mn
  if loops>=1 then
    loops=self.timers.m:next(loops)
  end
  
  -- h
  if loops>=1 then
    self.timers.h:next(loops)
  end
  
  return self
end

function TimeClock:toString(formatH, formatM, formatS,  formatMS)
  local formatH = formatH or "c1c2:"
  local formatM = formatM or "c1c2."
  local formatS = formatS or "c1c2 "
  local formatMS = formatMS or "c1c2c3"
  
  if self.activeMs then
    return self.timers.h:toString(formatH,2) .. self.timers.m:toString(formatM,2) .. self.timers.s:toString(formatS,2) .. self.timers.ms:toString(formatMS,3)
  else
    return self.timers.h:toString(formatH,2) .. self.timers.m:toString(formatM,2) .. self.timers.s:toString(formatS,2)
  end
end

function TimeClock:punch()
  self.times[#self.times+1] = {h=self.timers.h:current(), m=self.timers.m:current(), s=self.timers.s:current(), ms=self.timers.ms:current()}
  return self.times[#self.times]
end
