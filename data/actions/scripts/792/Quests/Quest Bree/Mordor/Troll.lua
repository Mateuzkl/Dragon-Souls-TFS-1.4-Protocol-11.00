function onUse(cid, item, frompos, item2, topos)

if item.actionid == 100 then
doTeleportThing(cid,{x=997, y=1796, z=7})
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
doSendMagicEffect(topos,10)
doSendMagicEffect(getPlayerPosition(cid),10)
end
end