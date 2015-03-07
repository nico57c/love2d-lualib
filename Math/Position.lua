-- Math/Position.lua
module("Ncr7.mtPosition", package.seeall)

require "Tools/Object"

local Position={}

function Position.initialize(x,y,z)
  local obj={x=x or 0,y=y or 0,z=z or 0}
  return Ncr7.tObject.New._object(Position, obj)
end

function new(x,y,z)
  if(nil==x) then
    return Position.initialize()
  elseif('table'==type(x)) then
    return Position.initialize(x.x,x.y,x.z)
  else
    return Position.initialize(x,y,z)
  end
end

function Position:setX(x)
  self.x=x
  return self
end

function Position:setY(y)
  self.y=y
  return self
end

function Position:setZ(z)
  self.z=z
  return self
end

function Position:getX()
  return self.x
end

function Position:getY()
  return self.y
end

function Position:getZ()
  return self.z
end

function Position:setPos(position)
  self.x=position.x
  self.y=position.y
  self.z=position.z
  return self
end

function Position:getPos()
  return {x=self.x,y=self.y,z=self.z}
end

function Position:addOffset(offset,axe)
  if('table'==type(offset)) then
    self.x=self.x+offset.x
    self.y=self.y+offset.y
    self.z=self.z+offset.z
  elseif('x'==axe) then
    self.x=self.x+offset
  elseif('y'==axe) then
    self.y=self.y+offset
  elseif('z'==axe) then
    self.z=self.z+offset
  end
  return self
end

function Position:addOffsets(x,y,z)
    self.x=self.x+(x or 0)
    self.y=self.y+(y or 0)
    self.z=self.z+(z or 0)
    return self
end

function Position:clone()
  return Ncr7.mtPosition.new(self)
end
