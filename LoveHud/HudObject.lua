-- LoveHud/HudObject.lua
module("LoveHud.HudObject", package.seeall)

require "Math/Position"
require "Tools/Object"

local HudObject = {}

function HudObject.initialize()
  local obj = { id=nil, pos=nil, height=nil, width=nil, background={color={love.graphics.getColor()}},
                font={file=nil,size=nil, fileContent=" abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&`'*#=[]\"", type='font'}, 
                text={value=nil,pos=Ncr7.mtPosition.new(0,0),color=nil}, object=nil }
  return Ncr7.tObject.New._object(HudObject, obj)
end

function new()
  return HudObject.initialize()
end

function HudObject:draw()
  if(self.drawExtended(self)) then
    love.graphics.setColor(unpack(self.background.color))
    love.graphics.rectangle('fill', self.pos:getX(), self.pos:getY(), self.width, self.height)
    
    if('image'==self.font.type) then
      font = love.graphics.newImageFont(self.font.file,self.font.fileContent)
    elseif('font'==self.font.type) then
      love.graphics.setColor(unpack(self.text.color))
      love.graphics.setNewFont(self.font.file, self.font.size)
    end
    love.graphics.print(self.text.value, self.pos:getX()+self.text.pos:getX(), self.pos:getY()+self.text.pos:getY())
  end
end

function HudObject:drawExtended(self)
  return true
end

function HudObject:getPos()
  return self.pos
end

function HudObject:setPos(position)
  self.pos = position
  return self
end

function HudObject:moveOnX(offset)
  self.pos:addOffset(offset or 1,'x')
  return self
end

function HudObject:moveOnY(offset)
  self.pos:addOffset(offset or 1,'y')
  return self
end

function HudObject:getWidth()
  return self.width
end

function HudObject:getHeight()
  return self.height
end

function HudObject:setHeight(height)
  self.height=height
  return self
end

function HudObject:setWidth(width)
  self.width=width
  return self
end

function HudObject:getId()
  return self.id
end

function HudObject:setId(id)
  self.id=id
  return self
end

function HudObject:getFont()
  return self.font
end

function HudObject:setFont(font)
  self.font = font
  return self
end

function HudObject:getText()
  return self.text.value
end

function HudObject:setText(text)
  self.text.value=text
  return self
end

function HudObject:getTextPos()
  return self.text.pos
end

function HudObject:setTextPos(pos)
  self.text.pos=pos
  return self
end

function HudObject:getFontType()
  return self.font.type
end

function HudObject:setFontType(textType)
  if(textType=='image')then
    self.font.type='image'
  elseif(textType=='font')then
    self.font.type='font'
  end
  return self
end

function HudObject:getTextColor()
  return self.text.color
end

function HudObject:setTextColor(color)
  self.text.color=color
  return self
end

function HudObject:getBackgroundColor()
  return self.background.color
end

function HudObject:setBackgroundColor(color)
  self.background.color=color
  return self
end

function HudObject:attachObject(object)
  self.object = object
  return self
end

function HudObject:getAttachedObject()
  return self.object
end

function HudObject:clone()
  local newHudObject = LoveHud.HudObject.new();
  newHudObject.id=self.id
  newHudObject.pos=self.pos:clone()
  newHudObject.height=self.height
  newHudObject.width=self.width
  newHudObject.background.color=self.background.color
  newHudObject.font.file=self.font.file
  newHudObject.font.size=self.font.size
  newHudObject.font.fileContent=self.font.fileContent
  newHudObject.font.type=self.font.type
  newHudObject.text.value=self.text.value
  newHudObject.text.pos=self.text.pos:clone()
  newHudObject.text.color=self.text.color
  return newHudObject
end
