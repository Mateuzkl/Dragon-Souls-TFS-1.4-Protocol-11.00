function onUse(cid, item, frompos, item2, topos)

if item.actionid == 333 then
doTeleportThing(cid,{x=121, y=311, z=7})
doSendMagicEffect(getPlayerPosition(cid),50)
end
end