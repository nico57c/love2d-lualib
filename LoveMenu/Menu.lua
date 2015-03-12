-- LovePage/Page.lua
module("LoveMenu.Menu", package.seeall)

require "LoveMenu/Page"
require "LoveMenu/PageObject"
require "Math/Position"

local Menu = {}

function Menu.initialize(id)
  local obj = { id=id or nil, pages={}, mouseEnabled = true, hidden=false, customCursor=nil }
  return Ncr7.tObject.New._object(Menu, obj)
end

function new(id)
  local menu = Menu.initialize(id)
  return menu
end

function Menu:setPage(page)
  self.pages[page:getId()] = page
  return self
end

function Menu:getPage(id)
  return self.pages[id]
end

function Menu:draw()
  if self.hidden then
    return
  end
  
  if(self:mouseIsEnabled()) then
    love.mouse.setVisible(true)
    if(nil==self.customCursor) then
      love.mouse.setCursor(love.mouse.getSystemCursor("ibeam"))
    else
      love.mouse.setCursor(self.customCursor)
    end
  else
    love.mouse.setVisible(false)
  end
  
  -- Draw :
  for key,page in pairs(self.pages) do
    if(page:isVisible()) then
      page:draw()
    end
  end
  
  return self
end

function Menu:mousereleased(mouseevent)
  if(false==self:mouseIsEnabled()) then
    return
  end
  
  local indexObjects={}
  for key,page in pairs(self.pages) do
    if(true==page:isVisible()) then
      for pObjKey,pObj in pairs(page.objects) do
        indexObjects[#indexObjects+1]=pObj
      end
    end
  end
  
  for key,pObj in pairs(indexObjects) do
    if( true==pObj:isVisible() and 
        ( pObj:getPos():getX() <= mouseevent.x and (pObj:getPos():getX()+pObj:getWidth()) >= mouseevent.x) and
        ( pObj:getPos():getY() <= mouseevent.y and (pObj:getPos():getY()+pObj:getHeight()) >= mouseevent.y ) ) then
      if(false==pObj:onMouseClick(mouseevent))then
        break
      end
    end
  end
end

function Menu:enableMouse()
  self.mouseEnabled = true
  return self
end

function Menu:disableMouse()
  self.mouseEnabled = false
  return self
end

function Menu:mouseIsEnabled()
  return self.mouseEnabled
end

function Menu:setVisible(visible)
  if true == visible then
    self.hidden = false
  else
    self.hidden = true
  end
  return self
end

function Menu:isVisible()
    if(true==self.hidden)then
      return false
    else
      return true
    end
end

function Menu:setVisiblePage(id,visible)
  self.pages[id]:setVisible(visible)
  return self
end

function Menu:isVisiblePage(id)
  if(nil==id) then
    local result = {}
    for key,hud in pairs(self.pages) do
      result[key]=hud:isHidden()
    end
    return result
  else
    return self.pages[id]:isVisible()
  end
end




