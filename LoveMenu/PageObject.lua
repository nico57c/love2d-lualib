-- LoveMenu/PageObject.lua
module("LoveMenu.PageObject", package.seeall)

require "Tools/Object"
require "Tools/String"
require "Math/Position"
require "LoveHud/HudObject"

-- Extends HudObject class
local PageObject = LoveHud.HudObject.getClass()

function PageObject.initialize(id, page)
  local obj = LoveHud.HudObject.getObj(id, page)  -- Extends HudObject attributes
  obj.linkedPage = nil
  obj.linkedPageObjects = {}
  return Ncr7.tObject.New._object(PageObject, obj)
end

function new(id, page)
  return PageObject.initialize(id, page)
end

function PageObject:clone()
  local newPageObject = LoveMenu.PageObject.new();
  newPageObject.id=self.id
  newPageObject.pos=self.pos:clone()
  newPageObject.height=self.height
  newPageObject.width=self.width
  newPageObject.background.color=self.background.color
  newPageObject.font.file=self.font.file
  newPageObject.font.size=self.font.size
  newPageObject.font.fileContent=self.font.fileContent
  newPageObject.font.type=self.font.type
  newPageObject.text.value=self.text.value
  newPageObject.text.pos=self.text.pos:clone()
  newPageObject.text.color=self.text.color
  newPageObject.object=self.object
  newPageObject.hidden=self.hidden
  newPageObject.parent=self.parent
  newPageObject.linkedPage=self.parent
  newPageObject.linkedPageObjects = {}
  return newPageObject
end

function PageObject:setTogglePage(linkedPage)
  self.linkedPage = linkedPage
  return self
end

function PageObject:togglePage()
  if(nil~=self.linkedPage) then
    if(true==self.linkedPage:isVisible()) then
      self.linkedPage:setVisible(false)
      self.parent:setVisible(true)
    else
      self.parent:setVisible(false)
      self.linkedPage:setVisible(true)
    end
  end
end

function PageObject:toggleObjects()
  for key,pageObject in self.linkedPageObjects do
    if(pageObject:isVisible()) then
      pageObject:setVisible(false)
    else
      pageObject:setVisible(true)
    end
  end
end

function PageObject:onMouseClick(event)
  if(event.button=='l') then
    self:togglePage()
  end
  return true
end

function PageObject:onMouseOver(event)
  self:toggleObjects()
  return true
end

