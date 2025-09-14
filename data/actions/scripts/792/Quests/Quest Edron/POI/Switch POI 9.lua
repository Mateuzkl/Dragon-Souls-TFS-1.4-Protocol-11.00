function onUse(cid, item, frompos, item2, topos)
piece1pos = {x=616, y=629, z=13, stackpos=2}
piece2pos = {x=618, y=629, z=13, stackpos=2}
getpiece1 = getThingfromPos(piece1pos)
getpiece2 = getThingfromPos(piece2pos)

if item.actionid == 113 and item.itemid == 1945 then
doRemoveItem(getpiece1.uid,1)
doRemoveItem(getpiece2.uid,1)
doSendMagicEffect(getPlayerPosition(cid),13)
doPlayerSendTextMessage(cid,22,"get hear on something open.")
doTransformItem(item.uid,item.itemid+1)
elseif item.actionid == 113 and item.itemid == 1946 then
doPlayerSendTextMessage(cid,22,"get hear on something open.")
doTransformItem(item.uid,item.itemid-0)
else
doPlayerSendTextMessage(cid,22,"Sorry, not possible.")
end
return 1
end
