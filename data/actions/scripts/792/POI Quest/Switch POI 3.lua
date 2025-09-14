function onUse(cid, item, frompos, item2, topos)
piece1pos = {x=650, y=639, z=11, stackpos=1}
rockpos = {x=650, y=639, z=11, stackpos=1}
rockpos2 = {x=601, y=647, z=12, stackpos=1}
getpiece1 = getThingfromPos(piece1pos)

if item.uid == 5103 and item.itemid == 1945 and getpiece1.itemid == 1354 then
doRemoveItem(getpiece1.uid,1)
doCreateItem(5070,1,rockpos2)
doSendMagicEffect(getPlayerPosition(cid),13)
doPlayerSendTextMessage(cid,22,"get hear on something close.")
doTransformItem(item.uid,item.itemid+1)
elseif item.uid == 5103 and item.itemid == 1946 then
doCreateItem(1354,1,rockpos)
doTransformItem(item.uid,item.itemid-1)
else
doPlayerSendTextMessage(cid,22,"Sorry, not possible.")
end
return 1
end
