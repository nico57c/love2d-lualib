-- Tests/Console.lua
module("LoveConsole.Tests.Console", package.seeall)

require "Tools/Container"
require "LoveConsole/Console"
require "LoveConsole/Commands/Config"
require "LoveConsole/Commands/Default"
require "LoveConsole/Bootstrap"

local consoleBootstrap = LoveConsole.Bootstrap.initConfig()

function consoleBootstrap:load()
  self.console=LoveConsole.Console.new({path='/lib/LoveConsole/VeraMono.ttf'},
                                       nil,
                                       {cmds={config=LoveConsole.CmdConfig,default=LoveConsole.CmdDefault}})
end

