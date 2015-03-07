-- Tools/String.lua
module("Ncr7.tString", package.seeall)


function chars(str)
  local t = {}
  for c in str:gmatch(".") do
    t[#t+1] = c
  end
  return t
end