function onUse(cid, item, frompos, item2, topos)
gatepos1 = {x=460, y=239, z=13, stackpos=1}
gatepos2 = {x=460, y=239, z=13, stackpos=1}

getgate1 = getThingfromPos(gatepos1)
getgate2 = getThingfromPos(gatepos2)

if item.uid == 60023 and item.itemid == 1945 then
doRemoveItem(getgate1.uid,1)
doSendMagicEffect(getPlayerPosition(cid),13)
doPlayerSendTextMessage(cid,22,"get hear on something open.")
doTransformItem(item.uid,item.itemid+1)

elseif item.uid == 60023 and item.itemid == 1946 then
doSendMagicEffect(getPlayerPosition(cid),13)
doPlayerSendTextMessage(cid,22,"get hear on something close.")
doCreateItem(3390,1,gatepos2)
doTransformItem(item.uid,item.itemid-1)
else
doPlayerSendCancel(cid,"Sorry not possible.")
end
return 1
end