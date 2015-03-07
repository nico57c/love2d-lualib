-- Tools/Object.lua
module("Ncr7.tObject", package.seeall)

New = {}
function New._object(class, o, metatable)
  local o = o or {}
  o._global=_G
  if(nil~=metatable) then
    setmetatable(o, table.merge(metatable,{ __index = class } ) )
  else
    setmetatable(o, { __index = class })
  end
  return o
end
  
New._mt = {}
function New._mt.__index(table, key)
   --local class = _G[key]
   local class = key
   return type(class.initialize) == 'function' and class.initialize or function() return New._object(class) end
end

setmetatable(New,New._mt)

function deepcopy(o, seen)
  seen = seen or {}
  if o == nil then return nil end
  if seen[o] then return seen[o] end

  local no
  if type(o) == 'table' then
    no = {}
    seen[o] = no

    for k, v in next, o, nil do
      no[deepcopy(k, seen)] = deepcopy(v, seen)
    end
    setmetatable(no, deepcopy(getmetatable(o), seen))
  else -- number, string, boolean, etc
    no = o
  end
  return no
end

function getGlobal()
  return _G
end

function setGobal(global)
  _G = global
end

function _NULL_() end