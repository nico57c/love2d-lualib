-- LoveConsole/Cursor.lua
module("LoveConsole.Cursor", package.seeall)

require "Tools/Object"

local Cursor = {}

function Cursor.initialize()
  local obj = { x= 0, y= 0, 
                char={offset=0,width=0,height=0}, line={offset=0,height=0},
                form='rect', hidden=false, color=nil }
  return Ncr7.tObject.New._object(Cursor, obj)
end

-- Parameters : x= x or 0, y= y or 0, height= height or 0, width= width or 0, offset= offset or 0
-- Return Cursor
function new()
  local cursor=Cursor.initialize()
  cursor.color={love.graphics.getColor()}
  cursor.color[4]=cursor.color[4]/3
  return cursor
end

function Cursor:getWidth()
  return self.width
end

function Cursor:getHeight()
  return self.height
end

function Cursor:getX()
  return self.x
end

function Cursor:getY()
  return self.y
end

function Cursor:setY(y)
  self.y=y
  return self
end

function Cursor:setX(x)
  self.x=x
  return self
end

function Cursor:setCharSize(width, height)
  self.char.width=width
  self.char.height=height
  return self
end

function Cursor:setCharOffset(offset)
  self.char.offset=offset
  return self
end

function Cursor:setLineHeight(height)
  self.line.height=height
  return self
end

function Cursor:setLineOffset(offset)
  self.line.offset=offset
  return self
end

function Cursor:draw()
  if(self.hidden) then return end
  
  local x = 0 local y = 0 local height = 0 local width = 0
  if(self.form == 'rect') then
    width = self.char.width + 1
    height = self.char.height + 1
    x = self.x + self.char.width * self.char.offset
    y = self.y - self.line.height * self.line.offset - self.line.height
  elseif(self.form == 'line') then
    width = self.char.width + 2
    height = 2
    x = self.x + self.char.width * self.char.offset
    y = self.y - self.line.height * self.line.offset - 5
  end
  
  love.graphics.setColor(unpack(self.color))
  love.graphics.rectangle('fill', x, y, width, height)
  
  return self
end

function Cursor:setForm(form)
  self.form=form
  return self
end

function Cursor:setColor(color)
  self.color=color
  return self
end

function Cursor:setHidden(hidden)
  self.hidden = hidden
  return self
end

function Cursor:isHidden()
  return self.hidden
end

  