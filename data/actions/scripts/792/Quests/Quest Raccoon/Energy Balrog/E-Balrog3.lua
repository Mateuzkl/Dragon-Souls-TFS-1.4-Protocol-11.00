function onUse(cid, item, frompos, item2, topos)

doTeleportThing(cid,{x=238, y=69, z=11})
doPlayerSendTextMessage(cid,22,"You enterning in another dimension.")
doSendMagicEffect(topos,10)
doSendMagicEffect(getPlayerPosition(cid),10)
end