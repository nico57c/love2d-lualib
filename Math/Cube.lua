-- Math/Position.lua
module("Ncr7.mtCube", package.seeall)

require "Tools/Object"
require "Math/Polygon"

local Cube={}

function Cube.initialize()
  local obj={
    polygon=nil, id=nil, size=50
  }
  return Ncr7.tObject.New(Cube,obj)
end

function new()
  return Cube.initialize()
end

function Cube:clone()
  local cube=Ncr7.mtCube.new()
  cube.polygon=self.polygon
  return cube
end

function Cube:setId(id)
  self.id=id
  return self
end

function Cube:getId()
  return self.id
end

function Cube:setSize(size)
  self.size=size
  return self
end

function Cube:getSize()
  return self.size
end

function Cube:getPolygon()
  return self.polygon
end

-- refresh polygon
function Cube:updatePolygon()
  
  return self
end
