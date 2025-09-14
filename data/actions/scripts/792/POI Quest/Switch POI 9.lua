function onUse(cid, item, frompos, item2, topos)
piece1pos = {x=616, y=629, z=13, stackpos=1}
piece2pos = {x=618, y=629, z=13, stackpos=1}
rockpos = {x=619, y=629, z=13, stackpos=1}
rockpos2 = {x=621, y=630, z=13, stackpos=1}
rockpos3 = {x=616, y=629, z=13, stackpos=1}
rockpos4 = {x=618, y=629, z=13, stackpos=1}
getpiece1 = getThingfromPos(piece1pos)
getpiece2 = getThingfromPos(piece2pos)

if item.uid == 5109 and item.itemid == 1945 and getpiece1.itemid == 3392 and getpiece2.itemid == 3392 then
doRemoveItem(getpiece1.uid,1)
doRemoveItem(getpiece2.uid,1)
doCreateItem(5070,1,rockpos2)
doCreateItem(3393,1,rockpos3)
doCreateItem(3393,1,rockpos4)
doSendMagicEffect(getPlayerPosition(cid),13)
doPlayerSendTextMessage(cid,22,"get hear on something close.")
doTransformItem(item.uid,item.itemid+1)
elseif item.uid == 5109 and item.itemid == 1946 then
doCreateItem(1354,1,rockpos)
doTransformItem(item.uid,item.itemid-1)
else
doPlayerSendTextMessage(cid,22,"Sorry, not possible.")
end
return 1
end
