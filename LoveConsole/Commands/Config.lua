-- LoveConsole/Commands/Config.lua
module("LoveConsole.CmdConfig", package.seeall)

require "Tools/Object"
require "Tools/String"
require "LoveConsole/Command"

-- Extends Command class
local CmdConfig = LoveConsole.Command.getClass()

function CmdConfig.initialize(refid)
  local obj = LoveConsole.Command.getObj(refid)  -- Extends Command attributes
  obj.configArray = {}
  return Ncr7.tObject.New._object(CmdConfig, obj)
end

function new(refid)
  local cmdConfig = CmdConfig.initialize(refid)
  cmdConfig.fct = { id = 'cmdConfig', name = 'config' }
  return cmdConfig
end

function CmdConfig:isValidCommand(txtCommand)
  if('set_config' == txtCommand or
     'get_config' == txtCommand) then
    return true
  else
    return false
  end
end

function CmdConfig:exec(txtCommand)
  if('get_config' == txtCommand) then
    self:_getConfig()
  elseif('set_config' == txtCommand) then
    self:_setConfig()
  else
    return false
  end
end

function CmdConfig:_setConfig()
  local configName = self:getArg(0)
  local configValue = self:getArg(1)
  self.configArray[configName]=configValue
  self.console:print('ok')
end

function CmdConfig:_getConfig()
  local configName = self:getArg(0)
  self.console:print(self.configArray[configName])
end