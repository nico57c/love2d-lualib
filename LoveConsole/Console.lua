-- LoveConsole/Console.lua
module("LoveConsole.Console", package.seeall)

require "LoveConsole/Input"
require "LoveConsole/Output"
require "Tools/Object"

local Console = {}

function Console.initialize()
  local obj = { _out=nil, _in=nil, _prompt="] ", prompt1="] ", prompt2=" ", focused=true }
  return Ncr7.tObject.New._object(Console, obj)
end

function new(fontP, outputP, inputP)
  local console=Console.initialize();
  
  if(outputP~=nil)then
    console._out=LoveConsole.Output.new(fontP, outputP.linePadding, outputP.width, outputP.height)
  else
    console._out=LoveConsole.Output.new(fontP)
  end
  if(inputP~=nil)then
    console._in=LoveConsole.Input.new(console, inputP.cmds)
  else
    console._in=LoveConsole.Input.new(console)
  end
  return console
end

function Console:getOutput()
  return self._out
end

function Console:getInput()
  return self._in
end

function Console:print(...)
	local n_args, s = select('#', ...), {...}
	for i = 1,n_args do
		s[i] = (s[i] == nil) and "nil" or tostring(s[i])
	end
	if n_args == 0 then s = {" "} end
	self._out:push(table.concat(s, "    "))
end

function Console:togglePrompt()
  if(self.prompt1 == self._prompt) then
    self._prompt = self.prompt2
  else
    self._prompt = self.prompt1
  end
end

function Console:draw(ox,oy)
  if(false == self.focused) then return end
	assert(ox and oy)
	local inp = table.concat({self._prompt, self._in:current()}, '')
	local n = self._out:push(inp)
	self._out:draw(ox, oy, self._in:pos())
	self._out:pop(n)
end

function Console:isFocused()
  return self.focused
end

function Console:focus()
	self.focused = true
end

function Console:unfocus()
	self.focused = false
end

function Console:keypressed(...)
	self._in:keypressed(...)
end

function Console:textinput(...)
  self._in:textinput(...)
end
