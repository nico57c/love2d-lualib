-- LoveTools/Timer.lua
module("LoveTools.Timer", package.seeall)

require "Math/Timer"

local Timer={}

function Timer.initialize(from, to, inc, incMs)
  local obj={timer=Ncr7.mtTimer.new(from, to, inc), incMs=incMs or 1000, time=nil, id=nil}
  return Ncr7.tObject.New._object(Timer, obj)
end

function new(from, to, inc, incMs)
  return Timer.initialize(from, to, inc, incMs)
end

function Timer:setId(id)
  self.id = id
  return self
end

function Timer:getId()
  return self.id
end

function Timer:getTimer()
  return self.timer
end

function Timer:setTimer(timer)
  self.timer = timer
  return self
end

function Timer:getIncMs()
  return self.incMs
end

function Timer:setIncMs(incMs)
  self.incMs = incMs
  return self
end

function Timer:bootstrap()
  self._global['Container']:reg('Love.draw'):push(self);
end

function Timer:draw()
  if nil==self.time then
    self.time=love.timer.getTime()*1000
    return
  end

  local cTime = love.timer.getTime()*1000
  local bTime = cTime-self.time
  if bTime >= self.incMs then
    self.time = cTime
    self.timer:next(math.floor(bTime/self.incMs))
  end
end
