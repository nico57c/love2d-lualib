-- LoveTools/Timer.lua
module("LoveTools.TimeClock", package.seeall)

require "Math/TimeClock"

local TimeClock={}

function TimeClock.initialize(withMs)
  local incMs=1000
  if withMs then
    incMs=1
  end
  local obj={timeclock=Ncr7.mtTimeClock.new(withMs), id=nil, incMs=incMs, time=nil }
  return Ncr7.tObject.New._object(TimeClock, obj)
end

function new(withMs)
  return TimeClock.initialize(withMs or false)
end

function TimeClock:setId(id)
  self.id = id
  return self
end

function TimeClock:getId()
  return self.id
end

function TimeClock:getTimeClock()
  return self.timeclock
end

function TimeClock:setTimeClock(timeclock)
  self.timeclock = timeclock
  return self
end

function TimeClock:bootstrap()
  self._global['Container']:reg('Love.draw'):push(self);
end

function TimeClock:draw()
  if nil==self.time then
    self.time=love.timer.getTime()*1000
    return
  end
  
  local cTime = love.timer.getTime()*1000
  local bTime = cTime-self.time
  if bTime >= self.incMs then
    self.time = cTime
    self.timeclock:next(math.floor(bTime/self.incMs))
  end
end
