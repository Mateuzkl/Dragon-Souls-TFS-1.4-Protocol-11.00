function onUse(cid, item, frompos, item2, topos)
piece1pos = {x=106, y=94, z=9, stackpos=2}
rockpos = {x=106, y=94, z=9, stackpos=2}
rockpos2 = {x=81, y=79, z=9, stackpos=1}
getpiece1 = getThingfromPos(piece1pos)

if item.uid == 3482 and item.itemid == 1945 and getpiece1.itemid == 6284 then
doRemoveItem(getpiece1.uid,1)
doCreateItem(5063,1,rockpos2)
doSendMagicEffect(getPlayerPosition(cid),2)
doPlayerSendTextMessage(cid,22,"get hear on something close.")
doTransformItem(item.uid,item.itemid+1)
elseif item.uid == 3131 and item.itemid == 1946 then
doCreateItem(6284,1,rockpos)
doTransformItem(item.uid,item.itemid-1)
else
doPlayerSendTextMessage(cid,22,"Sorry, not possible.")
end
return 1
end
