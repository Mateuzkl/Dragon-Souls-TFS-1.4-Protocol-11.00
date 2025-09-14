function onUse(cid, item, frompos, item2, topos)

if item.actionid == 2412 and item.itemid == 3900 then
doTeleportThing(cid,{x=486, y=251, z=15})
doPlayerSendTextMessage(cid,24,"Parabéns, você foi transferido para a penultima parte, agora responda as questões que o nossso Deus te passará.")
doSendAnimatedText(getPlayerPosition(cid), "Ready to go!", TEXTCOLOR_ORANGE)
doSendMagicEffect(getPlayerPosition(cid),12)
end
end