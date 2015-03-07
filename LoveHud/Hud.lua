-- LoveHud/Hud.lua
module("LoveHud.Hud", package.seeall)

require "LovePainter/Border"
require "Tools/Object"
require "Math/Position"
require "Math/Polygon"
require "LoveHud/HudObject"

local Hud = {}

function Hud.initialize(pos)
  local obj = { pos= pos or nil, height= nil, width= nil, 
                polygon={obj=Ncr7.mtPolygon.new(pos or nil), border= LovePainter.Border.new()},
                background={color={love.graphics.getColor()}, img=nil, align={'center','center'}, position=nil, _aPos=nil}, id=nil,
                torender={polygon=true,background=true}, hudObjs={}
              }
  return Ncr7.tObject.New._object(Hud, obj)
end

function new(x,y,width,height)
  local hud = Hud.initialize(Ncr7.mtPosition.new(x or 0, y or 0))
  hud:setWidth(width):setHeight(height)
  hud:update()
  return hud
end

function Hud:draw()
  if(self.torender.polygon) then
    love.graphics.setColor(unpack(self.polygon.border.color))
    self.polygon.border:draw(self.polygon.obj:getPoints().absolutes)    
  end
  
  if(self.torender.background) then
    if(nil==self.background.position and nil~=self.background.align) then
    end
    if(nil~=self.background.color) then
      
    end
    if(nil~=self.background.img) then
      
    end
  end
  
  for key,hudObj in pairs(self.hudObjs) do
    hudObj:draw()
  end 
end

function Hud:addHudObject(object)
  self.hudObjs[#self.hudObjs+1] = object
  return self
end

function Hud:getHudObject(index)
  return self.hudObjs[index]
end

function Hud:getHudObjects()
  return self.hudObjs
end

function Hud:getId()
  return self.id
end

function Hud:setId(id)
  self.id=id
  return self
end

function Hud:getPos()
  return self.pos
end

function Hud:setPos(pos)
  self.pos=pos
  self.polygon.obj:setCenter(self.pos)
  return self
end

function Hud:getWidth()
  return self.width
end

function Hud:getHeight()
  return self.height
end

function Hud:setHeight(height)
  self.height=height
  return self
end

function Hud:setWidth(width)
  self.width=width
  return self
end

function Hud:setBackgroundImg(imgPath)
  self.brackground.img=imPath
  return self
end

function Hud:getBackgroundImg()
  return self.background.img
end

function Hud:setBackgroundPosition(pos)
  self.background.position = pos
  return self
end

function Hud:getBackgroundPosition()
  return self.background.position
end

function Hud:setBackgroundAlign(hor, ver)
  self.background.align[1] = hor
  self.background.align[2] = ver
  return self
end

function Hud:getBackgroundAlign()
  return self.background.align
end

function Hud:setColor(color)
  self.background.color=color
  return self
end

function Hud:getColor()
  return self.background.color;
end

function Hud:update()
  self.polygon.obj:setVerticesA({self.pos, self.pos:clone():addOffsets(self.width,0), 
                             self.pos:clone():addOffsets(self.width,self.height), self.pos:clone():addOffsets(0,self.height),
                             self.pos})
  self.polygon.obj:update()
end

function Hud:setBackground(img)
  self.background.img=img
  return self
end

function Hud:moveOnX(offset)
  self.pos:addOffset(offset or 1,'x')
  return self
end

function Hud:moveOnY(offset)
  self.pos:addOffset(offset or 1,'y')
  return self
end

