-- LoveConsole/Command.lua
module("LoveConsole.Command", package.seeall)

require "Tools/Object"

local Command = {}

function Command.initialize(refid)
  local obj = LoveConsole.Command.getObj(refid)
  return Ncr7.tObject.New._object(Command, obj)
end

function new(refid)
  return Command.initialize(refid)
end

function getClass()
  return Ncr7.tObject.deepcopy(Command)
end

function getObj(refid)
  return { refId=refid, console=nil, output=nil, input=nil, args=nil }
end

function Command:setRefId(refId)
  self.refId=refId
  return self
end

function Command:getRefId()
  return self.refId
end

function Command:setFctDescr(fctName,fctDescr)
  self.fct = {}
  self.fct.refId = self.refId
  self.fct.name = fctName
  self.fct.descr = fctDescr
  return self
end

function Command:getFctDescr()
  return self.fct
end

function Command:isValidCommand(txtCommand)
  if(self.fct.name~=nil and txtCommand==self.fct.name) then
    return true
  else
    return false
  end
end

function Command:keypressed(key)
  -- print('keypressed must be set')
end

function Command:exec(command)
  -- print('exec must be set')
end

function Command:setArgs(args)  
  self.args=args
  return self
end

function Command:setArg(name,value)  
  self.args[name]=value
  return self
end

function Command:getArg(name)
  if(nil~=self.args[name])then
    return self.args[name]
  else
    return nil
  end
end

function Command:getArgs()
  return self.args
end

function Command:setConsole(console)
  self.console = console
  return self
end

function Command:getConsole()
  return self.console
end

function Command:setOutput(output)
  self.output = output
  return self
end

function Command:getOutput()
  return self.output
end

function Command:setInput(input)
  self.input = input
  return self
end

function Command:getInput()
  return self.input
end

