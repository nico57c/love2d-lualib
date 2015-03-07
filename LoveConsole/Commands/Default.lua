-- LoveConsole/Commands/Default.lua
module("LoveConsole.CmdDefault", package.seeall)

require "Tools/Object"
require "Tools/String"
require "LoveConsole/Command"

-- Extends Command class
local CmdDefault = LoveConsole.Command.getClass()

function CmdDefault.initialize(refid)
  local obj = LoveConsole.Command.getObj(refid)  -- Extends Command attributes
  return Ncr7.tObject.New._object(CmdDefault, obj)
end

function new(refid)
  local cmdDefault = CmdDefault.initialize(refid)
  cmdDefault.fct = { id = 'cmdDefault', name = 'default' }
  return cmdDefault
end

function CmdDefault:keypressed(key)
  if('return' == key) then
    self:_return()
  elseif('backspace' == key) then
    self:_backspace()
  elseif('delete' == key) then
    self:_delete()
  elseif('left' == key) then
    self:_left()
  elseif('right' == key) then
    self:_right()
  elseif('up' == key) then
    self:_up()
  elseif('down' == key) then
    self:_down()
  elseif('home' == key) then
    self:_home()
  elseif key == 'escape' then
    self:_escape()
  end
  return self
end

function CmdDefault:isValidCommand(txtCmd)
  if('clear'==txtCmd or 'exit'==txtCmd or 'quit'==txtCmd) then
    return true
  else
    return false
  end
end

function CmdDefault:exec(txtCmd)
  if('clear'==txtCmd) then
    self:_clear()
  elseif('exit'==txtCmd or 'quit'==txtCmd) then
    self:_exit()
  end
end

function CmdDefault:_return()
  self.input:execCommand()
end

function CmdDefault:_delete()
  table.remove(self.input.line, self.input.cursor)
end

function CmdDefault:_backspace()
  self.input.cursor = math.max(1, self.input.cursor - 1)
  table.remove(self.input.line, self.input.cursor)
end

function CmdDefault:_left()
  self.input.cursor = math.max(1, self.input.cursor - 1)
end

function CmdDefault:_right()
  self.input.cursor = math.min(#self.input.line+1, self.input.cursor + 1)
end

function CmdDefault:_up()
  if(#self.input.history>0) then
    self.input.selected = math.max(1, self.input.selected-1)
    self.input.line = Ncr7.tString.chars(self.input.history[self.input.selected] or "")
    self.input.cursor = #self.input.line + 1
  end
end

function CmdDefault:_down()
  self.input.selected = math.min(#self.input.history+1, self.input.selected + 1)
  self.input.line = Ncr7.tString.chars(self.input.history[self.input.selected] or "")
  self.input.cursor = #self.input.line + 1
end

function CmdDefault:_home()
  self.input.cursor = 1
end

function CmdDefault:_clear()
  self.output:clear()
end

function CmdDefault:_escape()
  if(true == self.console:isFocused()) then
    self.console:unfocus()
    return
  else
    self.console:focus()
  end 
end

function CmdDefault:_exit()
  os.exit()
end
