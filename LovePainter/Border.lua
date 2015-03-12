-- LovePainter/Border
--[[
TODO draw line type "double".
]]--

module("LovePainter.Border", package.seeall)

require "Tools/Object"

local Border = {}


function Border.initialize(style,width,color)
  local obj = { width= width or 1, color=color or {love.graphics.getColor()}, style=style or 'solid', hidden=false, corner={type='curves', radius=0.15},
                calculPoints=nil
              }
  return Ncr7.tObject.New._object(Border, obj)
end

function new(style,width,color)
  return Border.initialize();
end

function Border:setVisible(visible)
  if(true == visible) then
    self.hidden = false
  else
    self.hidden = true
  end
  return self
end

function Border:setWidth(width)
  self.width=width
  return self
end

function Border:getWidth()
  return self.width
end

function Border:setColor(color)
  self.color = color
  return self
end

function Border:getColor()
  return self.color
end

function Border:setStyle(style)
  if(style == 'solid' or
     style == 'dotted' or
     style == 'dashed' or
     style == 'double' or
     style == 'ridge' or
     style == 'outset' ) then
    self.style = style
  else
    self.style = 'solid'
  end
  return self
end

function Border:getStyle()
  return self.style
end

function Border:setCornerRadius(ratio)
  self.corner.radius = ratio
  return self
end

function Border:setCornerType(type)
  self.corner.type = type
  return self
end

function Border:getCornerType()
  return self.corner.type
end

function Border:forceUpdate()
  self.calculPoints=nil
  return self
end

function Border:draw(points, angle)
  love.graphics.setLineJoin('bevel')
  love.graphics.setLineStyle('rough')
  love.graphics.setLineWidth(self.width)
  
  if(false==self.hidden) then
    if(self.style == 'solid' or
       self.style == 'dotted' or
       self.style == 'dashed' or
       self.style == 'double' or
       self.style == 'ridge' or
       self.style == 'outset' ) then
      
      if(nil ~= self:getCornerType()) then
        self:drawWithCorner(points, self:getCornerType())
      else
        self:drawWithoutCorner(points)
      end
      
    end
  end
end

function Border:drawWithCorner(points, typeOfCorner)
  if('curves' == typeOfCorner) then
    if(self.calculPoints==nil) then
      self.calculPoints=self:generatePointsCornerCurves(points)
    end
    self:drawCornerCurves(self.calculPoints,true)
  end
end

function Border:drawCornerCurves(complex, drawlines)
  local i=0
  local line={}
  local drawlines = drawlines or true
  if(drawlines) then
    for key,point in pairs(complex.lines) do
      if(i<4) then
        i=i+1
        line[#line+1]=point
      end
      
      if(i>=4) then
        self:drawLine(line, self.style)
        i=0
        line={}
      end
    end
  end
  
  local i=0
  local curve={}
  for key,point in pairs(complex.curves) do
    if(i<6) then
      i=i+1
      curve[#curve+1]=point
    end
    
    if(i>=6) then
      self:drawLine(love.math.newBezierCurve(curve):render(6), self.style)
      i=0
      curve = {}
    end
  end
end

function Border:drawLine(line, style)
  if(self.style == 'solid') then
    love.graphics.line(line)
  elseif(self.style == 'double') then
    --love.graphics.line(line)
    local i=0
    local tmp = {minX=nil, minY=nil, maxX=nil, maxY=nil, pos=Ncr7.mtPosition.new()}
    local polygon = Ncr7.mtPolygon.new();
    
    for key,point in pairs(line) do
      if(i==0) then
        if(nil~=tmp.minX) then
          tmp.minX = math.min(tmp.minX,point)
          tmp.maxX = math.max(tmp.maxX,point)
        else
          tmp.minX = point
          tmp.maxX = point
        end
        tmp.pos:setX(point)
        i=i+1
      elseif(i==1) then
        if(nil~=tmp.minY) then
          tmp.minY = math.min(tmp.minY,point)
          tmp.maxY = math.max(tmp.maxY,point)
        else
          tmp.minY = point
          tmp.maxY = point
        end
        tmp.pos:setY(point)
        polygon:addVerticeA(tmp.pos)
        i=0
        tmp.pos=Ncr7.mtPosition.new()
      end
    end
    
    polygon:setCenter(Ncr7.mtPosition.new(((tmp.maxX-tmp.minX)/2)+tmp.minX,((tmp.maxY-tmp.minY)/2)+tmp.minY,0))
    polygon:calculVerticesA2R():scale(0.9):calculVerticesR2A()
    local points = polygon:calculPoints(false)
    love.graphics.line(points.absolutes)
    
--[[
    for key,point in pairs(line) do
      if(i<4) then
        i=i+1
        segment[#segment+1]=point
      end
      if(i>=4) then
        line[key-3]=line[key-3]+self.width+self.width
        line[key-2]=line[key-2]+self.width+self.width
        line[key-1]=line[key-1]+self.width+self.width
        line[key]=line[key]+self.width+self.width
------
        if((segment[2]==segment[4] and 2>=math.abs(segment[1]-segment[3])) or (segment[1]==segment[3] and 2>=math.abs(segment[2]-segment[4]))) then
        else
          if(segment[1]==segment[3]) then
            line[key-3]=segment[1]+self.width+self.width
            line[key-1]=segment[3]+self.width+self.width
          elseif(segment[2]==segment[4]) then
            line[key-2]=segment[4]+self.width+self.width
            line[key]=segment[4]+self.width+self.width
          else
            line[key-3]=line[key-3]+self.width+self.width
            line[key-2]=line[key-2]+self.width+self.width
            line[key-1]=line[key-1]+self.width+self.width
            line[key]=line[key]+self.width+self.width
          end
        end
------
        i=0
        segment={}
      end
    end
]]--
    --love.graphics.line(line)
  end
end

function Border:generatePointsCornerCurves(points)
  local result = {curves={},lines={}}
  local lines = {}
  local i=0;
  local copyRadius=0;
  local segment = {}
  -- l : longueur, min/max : pos ...
  local tmp = {l=nil,max=0,min=0,x1=0,y1=0,x2=0,y2=0}
  
  -- Search min tmp.l
  for key,point in pairs(points) do
    if(i<4) then
      i=i+1
      segment[#segment+1]=point
    end
    if(i>=4) then
      -- axis x :
      if(segment[1]~=segment[3]) then
        if(tmp.l~=nil)then
          tmp.l = math.min(( math.max(segment[1],segment[3]) - math.min(segment[1],segment[3]) ) * self.corner.radius, tmp.l)
        else
          tmp.l = (math.max(segment[1],segment[3]) - math.min(segment[1],segment[3])) * self.corner.radius
        end
      end
      -- axis y :
      if(segment[2]~=segment[4]) then
        if(tmp.l~=nil)then
          tmp.l = math.min(( math.max(segment[2],segment[4]) - math.min(segment[2],segment[4]) ) * self.corner.radius, tmp.l)
        else
          tmp.l = (math.max(segment[2],segment[4]) - math.min(segment[2],segment[4])) * self.corner.radius
        end
      end
      i=2
      segment={segment[3],segment[4]}
    end
  end
  
  local segment = {}
  local i=0;
  local newPoints = {}
  for key,point in pairs(points) do
    if(i<4) then
      i=i+1
      segment[#segment+1]=point
    end
    if(i>=4) then
      -- axis x :
      if(segment[1]~=segment[3]) then
        tmp.max = math.max(segment[1],segment[3])
        tmp.min = math.min(segment[1],segment[3])
        if(tmp.max == segment[1]) then
          tmp.x1=tmp.max-tmp.l
          tmp.x2=tmp.min+tmp.l
        else
          tmp.x1=tmp.min+tmp.l
          tmp.x2=tmp.max-tmp.l
        end
      else
          tmp.x1=segment[1]
          tmp.x2=segment[3]
      end
      -- axis y :
      if(segment[2]~=segment[4]) then
        tmp.max = math.max(segment[2],segment[4])
        tmp.min = math.min(segment[2],segment[4])
        if(tmp.max == segment[2]) then
          tmp.y1=tmp.max-tmp.l
          tmp.y2=tmp.min+tmp.l
        else
          tmp.y1=tmp.min+tmp.l
          tmp.y2=tmp.max-tmp.l
        end
      else
          tmp.y1=segment[2]
          tmp.y2=segment[4]
      end
      
      newPoints[#newPoints+1]=tmp.x1
      newPoints[#newPoints+1]=tmp.y1
      newPoints[#newPoints+1]=tmp.x2
      newPoints[#newPoints+1]=tmp.y2
      
      lines[#lines+1]=newPoints[#newPoints-3]
      lines[#lines+1]=newPoints[#newPoints-2]
      lines[#lines+1]=newPoints[#newPoints-1]
      lines[#lines+1]=newPoints[#newPoints-0]
      
      newPoints[#newPoints+1]=segment[3]
      newPoints[#newPoints+1]=segment[4]
      
      i=2
      segment={segment[3],segment[4]}
    end
  end
  
  local curves = {}
  for key,point in pairs(newPoints) do
    if(key>2) then
      curves[#curves+1]=point
    end
  end
  curves[#curves+1]=newPoints[1]
  curves[#curves+1]=newPoints[2]
  
  result.curves=curves
  result.lines=lines
  return result
end

