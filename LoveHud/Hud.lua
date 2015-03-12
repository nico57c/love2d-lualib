-- LoveHud/Hud.lua
module("LoveHud.Hud", package.seeall)

require "LovePainter/Border"
require "Tools/Object"
require "Math/Position"
require "Math/Polygon"
require "LoveHud/HudObject"

local Hud = {}

function Hud.initialize(pos,id)
  local obj = LoveHud.Hud.getObj(pos, id)  -- Extends Hud attributes
  return Ncr7.tObject.New._object(Hud, obj)
end

function new(x,y,width,height,id)
  local hud = Hud.initialize(Ncr7.mtPosition.new(x or 0, y or 0), id)
  hud:setWidth(width):setHeight(height)
  hud:update()
  return hud
end

function getClass()
  return Ncr7.tObject.deepcopy(Hud)
end

function getObj(pos,id)
  return { pos=pos or nil, height= nil, width= nil, 
           polygon={obj=Ncr7.mtPolygon.new(pos or nil), border= LovePainter.Border.new()},
           background={color={love.graphics.getColor()}, img=nil, align={'center','center'}, position=nil, _aPos=nil}, id=id or nil,
           torender={polygon=true,background=true}, objects={}, hidden=false
         }
end

function Hud:draw()
  if self.hidden then
    return
  end
  
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
  
  for key,hudObj in pairs(self.objects) do
    hudObj:draw()
  end 
end

function Hud:addObject(object)
  self.objects[#self.objects+1] = object
  return self
end

function Hud:getObject(index)
  return self.objects[index]
end

function Hud:getObjects()
  return self.objects
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

function Hud:setVisible(visible)
  if true == visible then
    self.hidden = false
  else
    self.hidden = true
  end
end

function Hud:isVisible()
  if(self.hidden) then
    return false
  else
    return true
  end
end

