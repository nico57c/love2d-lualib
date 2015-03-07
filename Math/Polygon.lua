-- Math/Position.lua
module("Ncr7.mtPolygon", package.seeall)

require "Tools/Object"


local Polygon={}

function Polygon.initialize(pcenter)
  local obj={
    vertices={absolutes={},relatives={}},
    points={absolutes={},relatives={}},
    center=pcenter or nil
  }
  return Ncr7.tObject.New._object(Polygon, obj)
end

function new(pcenter)
  return Polygon.initialize(pcenter)
end

function Polygon:getVerticesR()
  return self.vertices.relatives
end

function Polygon:getVerticesA()
  return self.vertices.absolutes
end

function Polygon:setVerticesA(positions)
  self.vertices.absolutes=positions
  return self
end

function Polygon:addVerticeA(position)
  self.vertices.absolutes[#self.vertices.absolutes+1] = position
  return self 
end

function Polygon:addVerticeR(position)
  self.vertices.relatives[#self.vertices.relatives+1] = position
  return self
end

function Polygon:setVerticesR(positions)
  self.vertices.relatives=positions
  return self
end

function Polygon:setCenter(position)
  self.center=position
  return self
end

function Polygon:getCenter()
  return self.center
end

function Polygon:translateOnAxis(axis, distance)
  
end

function Polygon:rotateOnAxis(axis, distance)
  
end

-- Don't forget : calculVerticesR2A if you want absolute pos.
function Polygon:scaleInPx(offset)
  local offsets = {x=0,y=0,z=0}
  for key, pos in pairs(self.vertices.relatives) do
      if(0<pos:getX() and 0<pos:getY() and 0<pos:getZ()) then
        offsets.x=offset
        offsets.y=offset
        offsets.z=offset
      elseif(0>pos:getX() and 0>pos:getY() and 0>pos:getZ()) then
        offsets.x=0-offset
        offsets.y=0-offset
        offsets.z=0-offset
      elseif(0>pos:getX() and 0>pos:getY()) then
        offsets.x=offset
        offsets.y=offset
        offsets.z=offset
      elseif(0<pos:getX() and 0<pos:getY()) then
        offsets.x=0-offset
        offsets.y=0-offset
        offsets.z=offset
      end
      pos:addOffsets(offsets.x,offsets.y,offsets.z)
  end
  return self
end

function Polygon:scale(ratio)
  for key, pos in pairs(self.vertices.relatives) do
      pos:setX(pos:getX()*ratio)
      pos:setY(pos:getY()*ratio)
      pos:setZ(pos:getZ()*ratio)
  end
  return self
end

function Polygon:calculVerticesA2R()
  self.vertices.relatives = {}
  if(self.center==nil) then
    for key,vertice in pairs(self.vertices.absolutes) do
      self.vertices.relatives[#self.vertices.relatives+1] = vertice:clone()
    end
  else
    for key,vertice in pairs(self.vertices.absolutes) do
      self.vertices.relatives[#self.vertices.relatives+1] = vertice:clone():addOffsets(0-self.center:getX(),0-self.center:getY(),0-self.center:getZ())
    end
  end
  return self
end

function Polygon:calculVerticesR2A()
  self.vertices.absolutes = {}
  if(self.center==nil) then
    for key,vertice in pairs(self.vertices.relatives) do
      self.vertices.absolutes[#self.vertices.absolutes+1] = vertice:clone()
    end
  else
    for key,vertice in pairs(self.vertices.relatives) do
      self.vertices.absolutes[#self.vertices.absolutes+1] = vertice:clone():addOffsets(self.center:getX(),self.center:getY(),self.center:getZ())
    end
  end
  return self
end

function Polygon:calculPoints(withZ)
  self.points.absolutes={}
  self.points.relatives={}
  for key,pos in pairs(self.vertices.absolutes) do
    self.points.absolutes[#self.points.absolutes+1]=pos:getX()
    self.points.absolutes[#self.points.absolutes+1]=pos:getY()
    if(true==withZ) then
      self.points.absolutes[#self.points.absolutes+1]=pos:getZ()
    end
  end
  for key,pos in pairs(self.vertices.relatives) do
    if(self.center==nil) then
      self.points.relatives[#self.points.relatives+1]=pos:getX()
      self.points.relatives[#self.points.relatives+1]=pos:getY()
      if(true==withZ) then
        self.points.relatives[#self.points.relatives+1]=pos:getZ()
      end
    else
      self.points.relatives[#self.points.relatives+1]=pos:getX()-self.center:getX()
      self.points.relatives[#self.points.relatives+1]=pos:getY()-self.center:getY()
      if(true==withZ) then
        self.points.relatives[#self.points.relatives+1]=pos:getZ()-self.center:getZ()
      end
    end
  end
  return self.points
end

function Polygon:getPoints()
  return self.points
end

function Polygon:update()
  self:calculPoints()
end