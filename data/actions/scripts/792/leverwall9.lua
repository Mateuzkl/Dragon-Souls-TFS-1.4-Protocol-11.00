function onUse(cid, item, frompos, item2, topos)
wall1 = {x=121, y=601, z=7, stackpos=1}
getwall1 = getThingfromPos(wall1)

if item.uid == 7079 and item.itemid == 1945 then
doRemoveItem(getwall1.uid,1138)
doSendAnimatedText(topos, "Open!", TEXTCOLOR_LIGHTBLUE)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
doPlayerSendTextMessage(cid,22,"Você removeu uma Parede.")
doTransformItem(item.uid,item.itemid+1)
elseif item.uid == 7079 and item.itemid == 1946 then
doSendAnimatedText(topos, "Close!", TEXTCOLOR_RED)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_RED)
doTransformItem(item.uid,item.itemid-1) 
doCreateItem(1138,1,wall1)
end

return 1
end