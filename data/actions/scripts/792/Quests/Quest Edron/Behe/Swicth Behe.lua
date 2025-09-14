function onUse(cid, item, frompos, item2, topos)
piece1pos = {x=858, y=711, z=15, stackpos=1}
rockpos = {x=858, y=711, z=15, stackpos=1}
getpiece1 = getThingfromPos(piece1pos)

if item.uid == 6055 and item.itemid == 1945 and getpiece1.itemid == 1304 then
doRemoveItem(getpiece1.uid,1)
doSendMagicEffect(getPlayerPosition(cid),2)
doPlayerSendTextMessage(cid,22,"get hear on something close.")
doTransformItem(item.uid,item.itemid+1)
elseif item.uid == 6055 and item.itemid == 1946 then
doCreateItem(1304,1,rockpos)
doTransformItem(item.uid,item.itemid-1)
else
doPlayerSendTextMessage(cid,22,"Sorry, not possible.")
end
return 1
end
