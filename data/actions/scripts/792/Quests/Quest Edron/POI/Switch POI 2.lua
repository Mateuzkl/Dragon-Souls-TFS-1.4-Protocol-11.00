function onUse(cid, item, frompos, item2, topos)
piece1pos = {x=618, y=644, z=10, stackpos=1}
rockpos = {x=618, y=644, z=10, stackpos=1}
rockpos2 = {x=603, y=626, z=11, stackpos=1}
getpiece1 = getThingfromPos(piece1pos)

if item.actionid == 106 and item.itemid == 1945 and getpiece1.itemid == 3375 then
doRemoveItem(getpiece1.uid,1)
doCreateItem(5070,1,rockpos2)
doSendMagicEffect(getPlayerPosition(cid),2)
doPlayerSendTextMessage(cid,22,"get hear on something open.")
doTransformItem(item.uid,item.itemid+1)
elseif item.actionid == 106 and item.itemid == 1946 then
doPlayerSendTextMessage(cid,22,"get hear on something open.")
doTransformItem(item.uid,item.itemid-0)
else
doPlayerSendTextMessage(cid,22,"Sorry, not possible.")
end
return 1
end
