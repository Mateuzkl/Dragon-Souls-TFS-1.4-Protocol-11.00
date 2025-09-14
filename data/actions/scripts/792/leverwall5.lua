function onUse(cid, item, frompos, item2, topos)
wall1 = {x=179, y=645, z=7, stackpos=1}
getwall1 = getThingfromPos(wall1)

if item.uid == 7075 and item.itemid == 1945 then
doRemoveItem(getwall1.uid,1498)
doSendAnimatedText(topos, "Open!", TEXTCOLOR_LIGHTBLUE)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
doTransformItem(item.uid,item.itemid+1)
elseif item.uid == 7075 and item.itemid == 1946 then
doSendAnimatedText(topos, "Close!", TEXTCOLOR_RED)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_RED)
doTransformItem(item.uid,item.itemid-1) 
doCreateItem(1498,1,wall1)
end

return 1
end