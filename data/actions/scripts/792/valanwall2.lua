function onUse(cid, item, frompos, item2, topos)
wall1 = {x=503, y=258, z=13, stackpos=1}
getwall1 = getThingfromPos(wall1)

if item.uid == 7083 and item.itemid == 1945 then
doRemoveItem(getwall1.uid,7181)
doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
doSendAnimatedText(topos, "Open!", TEXTCOLOR_LIGHTBLUE)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
doPlayerSendTextMessage(cid,22,"Você retirou a pedra!.")
doTransformItem(item.uid,item.itemid+1)
elseif item.uid == 7083 and item.itemid == 1946 then
doTransformItem(item.uid,item.itemid-1)
doSendAnimatedText(topos, "Close!", TEXTCOLOR_RED)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
doPlayerSendTextMessage(cid,22,"Você colocou a pedra!.")  
doCreateItem(1354,1,wall1)
end

return 1
end