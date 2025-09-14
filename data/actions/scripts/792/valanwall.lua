function onUse(cid, item, frompos, item2, topos)
wall1 = {x=464, y=252, z=14, stackpos=1}
getwall1 = getThingfromPos(wall1)

if item.uid == 7084 and item.itemid == 1945 then
doRemoveItem(getwall1.uid,1354)
doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
doSendAnimatedText(topos, "Open!", TEXTCOLOR_LIGHTBLUE)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
doPlayerSendTextMessage(cid,22,"Você retirou a Pedra.")
doTransformItem(item.uid,item.itemid+1)
elseif item.uid == 7082 and item.itemid == 1946 then
doTransformItem(item.uid,item.itemid-1)
doSendAnimatedText(topos, "Close!", TEXTCOLOR_RED)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
doPlayerSendTextMessage(cid,22,"Você colocou a Pedra!.") 
doCreateItem(1354,1,wall1)
end

return 1
end