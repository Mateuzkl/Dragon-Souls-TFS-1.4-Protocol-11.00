function onUse(cid, item, frompos, item2, topos)

piecepos1 = {x=444, y=197, z=4, stackpos=2}
piecepos2 = {x=443, y=197, z=4, stackpos=2}
piecepos3 = {x=443, y=198, z=4, stackpos=2}
piecepos4 = {x=443, y=199, z=4, stackpos=2}
piecepos5 = {x=444, y=199, z=4, stackpos=2}

getpiece1 = getThingfromPos(piecepos1)
getpiece2 = getThingfromPos(piecepos2)
getpiece3 = getThingfromPos(piecepos3)
getpiece4 = getThingfromPos(piecepos4)
getpiece5 = getThingfromPos(piecepos5)

if item.itemid == 13661 and item2.itemid == 13663 then
doTransformItem(item2.uid,13662)
doDecayItem(item2.uid)
doTransformItem(item.uid,13660)
doDecayItem(item.uid)
end
end