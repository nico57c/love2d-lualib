-- Math/Clock.lua
module("Ncr7.mtTimeClock", package.seeall)

require "Tools/Object"

local TimeClock={}

function TimeClock.initialize()
  local obj={timer=nil, times={}}
  return Ncr7.tObject.New._object(Timer, obj)
end

function TimeClock:setTimer(timer)
  self.timer = timer
  return self
end

function TimeClock:getTimer()
  return self.timer
end

function TimeClock:punch()
  self.times[#self.times+1] = self.timer:current()
end