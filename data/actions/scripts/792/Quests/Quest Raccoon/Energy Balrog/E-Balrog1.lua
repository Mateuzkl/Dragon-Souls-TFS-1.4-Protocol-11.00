function onUse(cid, item, frompos, item2, topos)

doTeleportThing(cid,{x=204, y=58, z=10})
doPlayerSendTextMessage(cid,22,"You enterning in room of energy balrog.")
doSendMagicEffect(topos,10)
doSendMagicEffect(getPlayerPosition(cid),10)
end