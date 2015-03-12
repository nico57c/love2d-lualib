-- LoveMenu/Page.lua
module("LoveMenu.Page", package.seeall)

require "Tools/Object"
require "Tools/String"
require "Math/Position"
require "LoveHud/Hud"

-- Extends Hud class
local Page = LoveHud.Hud.getClass()

function Page.initializeid(pos, id)
  local obj = LoveHud.Hud.getObj(pos, id)  -- Extends Hud attributes
  return Ncr7.tObject.New._object(Page, obj)
end

function new(id, pos, width, height)
  local page = Page.initialize(Ncr7.mtPosition.new(x or 0, y or 0), id)
  page:setWidth(width):setHeight(height)
  page:update()
  return page
end
