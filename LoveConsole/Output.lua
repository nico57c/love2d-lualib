-- LoveConsole/Output.lua
module("LoveConsole.Output", package.seeall)

require "Tools/Object"
require "LoveConsole/Cursor"

local Output = {}

function Output.initialize()
   local obj = {
      width=nil, height=nil,
      spacing=nil, lines={},
      char_width =nil, char_height=nil,
      line={height=nil, per_screen=nil, padding=0},
      font={path=nil,size=0,obj=nil,color=nil}, chars_per_line=nil,
      cursor=nil
   }
   return Ncr7.tObject.New._object(Output, obj)
end

function new(fontP, linePadding, width, height)
  local output=Output.initialize()
  return output:init(fontP, linePadding, width, height);
end

function Output:init(fontP, linePadding, width, height)
  
  if(nil ~= fontP and nil ~= fontP.size) then
    self.font.size = fontP.size
  else
    self.font.size = 14
  end
  if(nil ~= fontP and nil ~= fontP.color) then
    self.font.color = fontP.color
  else
    self.font.color = {love.graphics.getColor()}
  end
  if(nil ~= fontP and nil ~= fontP.path) then
	 self.font.obj = love.graphics.newFont(fontP.path, self.font.size)
	else
	 self.font.obj = love.graphics.getFont()
	end
	
  self.width = width or love.graphics.getWidth()
  self.height = height or love.graphics.getHeight()
  
  self.char_width  = self.font.obj:getWidth("_")
  self.char_height = self.font.obj:getHeight("|")
  self.chars_per_line = math.floor(self.width / self.char_width) - 1
  
	self.line.padding = linePadding or 4
	self.line.height = self.char_height + self.line.padding
	self.line.per_screen = math.floor(self.height / self.line.height) - 1
	self.cursor = LoveConsole.Cursor.new()
	self.cursor:setLineHeight(self.line.height):setCharSize(self.char_width, self.char_height)
	return self
end

function Output:reset()
  return self:init()
end

function Output:clear()
  self.lines={}
  return self
end

function Output:getCursor()
  return self.cursor
end

function Output:draw(ox, oy, cursor_pos)
	assert(ox and oy)
	love.graphics.setColor(unpack(self.font.color))
	love.graphics.setFont(self.font.obj)
	
	local lines_to_display = self.line.per_screen - math.floor((self.height - oy) / self.line.height)
	for i = #self.lines, math.max(1, #self.lines - lines_to_display), -1 do
		love.graphics.print(self.lines[i], ox, oy - (#self.lines - i + 1) * self.line.height)
	end
  
	-- calculate cursor offsets
	if(cursor_pos) then
    cursor_pos = self.lines[#self.lines]:len() + cursor_pos - 1
  	self.cursor:setX(ox):setY(oy):setCharOffset(cursor_pos % self.chars_per_line)
  	           :setLineOffset(math.floor(cursor_pos / self.chars_per_line))
  	self.cursor:draw()
	end
	
  love.graphics.rectangle('fill', ox, oy, self.width, 1)
end

function Output:push(...)
	local str = table.concat{...}
	local added = 0
	-- split newlines
	for line in str:gmatch("[^\n]+") do
		-- wrap lines
		while line:len() > self.chars_per_line do
			self.lines[#self.lines + 1] = line:sub(1, self.chars_per_line)
			line = line:sub(self.chars_per_line+1)
			added = added + 1
		end
		self.lines[#self.lines+1] = line
		added = added + 1
	end
	return added
end

function Output:pop(n)
	local n = n or 1
	if n < 1 then return nil end
	return table.remove(self.lines, self:pop(n-1))
end

function Output:push_char(c, ...)
	if not c then return end
	local line = self.lines[#self.lines]
	if line:len() + 1 < self.chars_per_line then
		line = line .. c
	else
		line = c
	end
  
	self.lines[#self.lines] = line
	return self:push_char(...)
end

function Output:setFont(fontSize, fontColor, fontPath)
  if(nil~=fontSize) then
    self.font.size=fontSize
  end
  if(nil~=fontColor) then
    self.font.color=fontColor
  end
  if(nil~=fontPath) then
    self.font.path=fontPath
    self.font.obj=love.graphics.newFont(self.font.path, self.font.size)
  else
    self.font.obj=love.graphics.getFont(self.font.size)
  end
  
  self.char_width  = self.font.obj:getWidth("_")
  self.char_height = self.font.obj:getHeight("|")
  self.chars_per_line = math.floor(self.width / self.char_width) - 1
  self.cursor:setCharSize(self.char_width, self.char_height)
  return self
end

function Output:setLinePadding(padding)
  if(nil~=padding) then
    self.line.height=self.char_height + padding
    self.line.padding=padding
    self.cursor:setLineHeight(self.line.height)
  end
  self.line.per_screen = math.floor(self.height / self.line.height) - 1
  return self
end
