-- Tests/Hud.lua
module("LoveMenu.Tests.Menu", package.seeall)

require "Tools/Container"
require "LoveMenu/Menu"
require "LoveMenu/Page"
require "LoveMenu/PageObject"
require "LoveMenu/Bootstrap"

local consoleBootstrap = LoveMenu.Bootstrap.initConfig()

function consoleBootstrap:load()
  self.menu = LoveMenu.Menu.new()
  
  local page1 = LoveMenu.Page.new('page1')
  local page2 = LoveMenu.Page.new('page2')
        page2:setVisible(false)
          
  local pageObject = LoveMenu.PageObject.new('page1_obj1',page1):setWidth(300):setHeight(50):setFontType('font')
  pageObject:setTogglePage(page2)
  pageObject:setPos(Ncr7.mtPosition.new(200,200))
  pageObject:setText('Mon objet 1, page 1')
  page1:addObject(pageObject)
  
  pageObject = pageObject:clone()
  pageObject:setTogglePage(page2)
  pageObject:getPos():addOffsets(0,70)
  pageObject:setId('page1_obj2')
  pageObject:setText('Mon objet 2, page 1')
  page1:addObject(pageObject)
  
  pageObject = LoveMenu.PageObject.new('page2_obj1',page2):setWidth(300):setHeight(50):setFontType('font')
  pageObject:setTogglePage(page1)
  pageObject:setPos(Ncr7.mtPosition.new(200,200))
  pageObject:setId('page2_obj1')
  pageObject:setText('Mon objet 1, page 2')
  page2:addObject(pageObject)
  
  pageObject = pageObject:clone()
  pageObject:setTogglePage(page1)
  pageObject:getPos():addOffsets(0,70)
  pageObject:setId('page2_obj2')
  pageObject:setText('Mon objet 2, page 2')
  page2:addObject(pageObject)

  
  self.menu:setPage(page1)
  self.menu:setPage(page2)
  self.menu:enableMouse()
end
