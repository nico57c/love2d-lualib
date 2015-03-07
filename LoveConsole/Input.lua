-- LoveConsole/Input.lua
module("LoveConsole.Input", package.seeall)

require "Tools/Object"
require "LoveConsole/Commands/Default"

local Input = {}

function Input.initialize()
  local obj = {
     limitedInput = true,
     history = {},
     selected = 1,
     line = {},
     cursor = 1,
     complete_next = nil,
     commands = {},
     complete_base = _G,
     console=nil,
  }
  --LoveConsole.Input.set_default_hooks(obj)
  return Ncr7.tObject.New._object(Input, obj)
end

function new(console, cmdClasses)
  cmdClasses = cmdClasses or { default=LoveConsole.CmdDefault }
  local input = Input.initialize()
  input.console = console
  input:initCommands(cmdClasses)
  return input
end

function purge_history(history, cmd)
	for i = #history,1,-1 do
		if history[i] == cmd then
			table.remove(history, i)
		end
	end
end

function Input:initCommands(cmdClasses)
  for key,cmdClass in pairs(cmdClasses) do
    local cmdInstance = cmdClass.new('ref_' .. key)
    cmdInstance:setOutput(self.console:getOutput())
    cmdInstance:setInput(self)
    cmdInstance:setConsole(self.console)
    self.commands[key] = cmdInstance
  end
end

function Input:setlimitedInput(setLimitInput)
  if(setLimitInput) then
    self.limitedInput = true 
  else
    self.limitedInput = false
  end
end

function Input:keypressed(key)
--	if key ~= 'tab' then self.complete_next = nil end
  for cmdKey,cmd in pairs(self.commands) do
    cmd:keypressed(key)
  end
end

function Input:textinput(text)
  if(not self.console:isFocused()) then return end
  
  local matchKey = nil
  if(self.limitedInput) then
    matchKey = text:match('[a-zA-Z0-9 /?_-.\'"|+><$!\\():}{_.-]*')
  else
    matchKey = text
  end
  if matchKey ~= nil and matchKey:len() > 0 and matchKey:len() < 2 then   --if code > 31 and code < 256 then
    table.insert(self.line, self.cursor, text)
    self.cursor = self.cursor + 1
  end
end

function Input:execCommand()
  
  local command = table.concat(self.line)
  local args = {}
  local detectFct = true
  local detectArgs = -1
  
  -- Set line history :
  LoveConsole.Input.purge_history(self.history, command)
  self.history[#self.history+1] = command
  
  -- Detect fonction command + args :
  command = ""
  for key,str in pairs(self.line) do
    if(str == " ") then
      detectFct=false
      detectArgs= detectArgs+1
    elseif(detectArgs>=0) then
      if(args[detectArgs]~=nil) then
        args[detectArgs] = args[detectArgs] .. str
      else
        args[detectArgs] = str
      end
    elseif(detectFct) then
      command = command .. str
    end
  end
  
  -- Retinit line + command :
  self.selected = #self.history+1
  self.cursor = 1
  self.line = {}
  self.console:getOutput():push(self.console._prompt, command)
  
  local test = false
  for key,cmd in pairs(self.commands) do
    if(cmd:isValidCommand(command)) then
      cmd:setArgs(args)
      cmd:exec(command)
      test=true
    end
  end
  if(false==test)then
    -- Message d'erreur
  end
end

function Input:current()
	return table.concat(self.line)
end

-- cursor position relative to the current line content
function Input:pos()
	return self.cursor - #self.line
end

function Input:setPos(cursor)
  self.cursor=cursor
  return self
end
