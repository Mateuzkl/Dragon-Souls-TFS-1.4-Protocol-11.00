function onUse(cid, item, frompos, item2, topos)
piece1pos = {x=608, y=642, z=10, stackpos=1}
rockpos = {x=608, y=642, z=10, stackpos=1}
rockpos2 = {x=577, y=627, z=11, stackpos=1}
getpiece1 = getThingfromPos(piece1pos)

if item.uid == 5101 and item.itemid == 1945 and getpiece1.itemid == 3409 then
doRemoveItem(getpiece1.uid,1)
doCreateItem(5070,1,rockpos2)
doSendMagicEffect(getPlayerPosition(cid),2)
doPlayerSendTextMessage(cid,22,"get hear on something close.")
doTransformItem(item.uid,item.itemid+1)
elseif item.uid == 5101 and item.itemid == 1946 then
doCreateItem(3409,1,rockpos)
doTransformItem(item.uid,item.itemid-1)
else
doPlayerSendTextMessage(cid,22,"Sorry, not possible.")
end
return 1
end
