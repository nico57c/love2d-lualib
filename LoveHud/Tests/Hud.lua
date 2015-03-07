-- Tests/Hud.lua
module("LoveHud.Tests.Hud", package.seeall)

require "Math/Position"
require "LoveTools/Timer"
require "Tools/Container"
require "LoveHud/Hud"
require "LoveHud/HudObject"
require "LoveHud/Bootstrap"

local consoleBootstrap = LoveHud.Bootstrap.initConfig()

function consoleBootstrap:load()
  self.hud=LoveHud.Hud.new(10,10,love.graphics.getWidth()-20,love.graphics.getHeight()/5)
  
  local hudObject = LoveHud.HudObject.new()
  hudObject:setId('life'):setPos(Ncr7.mtPosition.new(20,20)):setFontType('font')
  hudObject:setWidth(70):setHeight(32):setTextPos(Ncr7.mtPosition.new(5,10))
  hudObject:setText('100 / 100'):setTextColor({255,0,0})
  self.hud:addHudObject(hudObject)
  
  hudObject=hudObject:clone()
  hudObject:setId('score'):getPos():addOffsets(100,0,0)
  hudObject:setText('0000001')  
  self.hud:addHudObject(hudObject)
  
  hudObject=hudObject:clone()
  hudObject:setId('time1S.inc'):getPos():addOffsets(100,0,0)
  hudObject:setText('  60')
  self.hud:addHudObject(hudObject)
  
  -- START > Timer 1S.inc test :
  
    local timer = LoveTools.Timer.new(60,0,1,1000)
    hudObject:attachObject(timer)
    
    -- Write timer value to HUD
    hudObject.drawExtended = function(self)
      self:setText(self:getAttachedObject():getTimer():current())
      return true
    end
    
    -- Start timer and Attach timer to draw method
    timer:getTimer():start()
    timer:bootstrap()
  
  -- END > Timer 1S.inc test
  
  
  -- START > Timer 100MS.inc test :
  
    hudObject=hudObject:clone()
    hudObject:setId('time100MS.inc'):getPos():addOffsets(100,0,0)
    hudObject:setText(' 6000')
    self.hud:addHudObject(hudObject)
    local timer = LoveTools.Timer.new(60000,0,1,1)
    hudObject:attachObject(timer)
    
    -- Write timer value to HUD
    hudObject.drawExtended = function(self)
      self:setText(self:getAttachedObject():getTimer():current())
      return true
    end
    
    -- Start timer and Attach timer to draw method
    timer:getTimer():start()
    timer:bootstrap()
  
  -- END > Timer 100MS.inc test
  
  self.hud:update()
end
