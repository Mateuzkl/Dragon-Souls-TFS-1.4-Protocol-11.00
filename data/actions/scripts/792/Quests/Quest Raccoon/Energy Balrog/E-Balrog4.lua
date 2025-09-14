function onUse(cid, item, frompos, item2, topos)

doTeleportThing(cid,{x=186, y=98, z=10})
doPlayerSendTextMessage(cid,22,"You leaving to another dimension.")
doSendMagicEffect(topos,10)
doSendMagicEffect(getPlayerPosition(cid),10)
end