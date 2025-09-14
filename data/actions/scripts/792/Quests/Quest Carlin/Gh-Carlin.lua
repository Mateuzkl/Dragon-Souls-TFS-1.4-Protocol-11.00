function onUse(cid, item, frompos, item2, topos)
piece1pos = {x=71, y=307, z=7, stackpos=1}
rockpos = {x=71, y=307, z=7, stackpos=1}
piece2pos = {x=70, y=307, z=7, stackpos=1}
rockpos2 = {x=70, y=307, z=7, stackpos=1}

getpiece1 = getThingfromPos(piece1pos)
getpiece2 = getThingfromPos(piece2pos)

if item.uid == 10009 and item.itemid == 1945 and getpiece1.itemid == 1544 and getpiece2.itemid == 1544 then
doRemoveItem(getpiece1.uid,1)
doRemoveItem(getpiece2.uid,1)
doPlayerSendTextMessage(cid,22,"get hear on something open.")
doTransformItem(item.uid,item.itemid+1)
elseif item.uid == 10009 and item.itemid == 1946 then
doCreateItem(1544,1,rockpos)
doCreateItem(1544,1,rockpos2)
doPlayerSendTextMessage(cid,22,"get hear on something close.")
doTransformItem(item.uid,item.itemid-1)
else
doPlayerSendTextMessage(cid,22,"Sorry, not possible.")
end
return 1
end
