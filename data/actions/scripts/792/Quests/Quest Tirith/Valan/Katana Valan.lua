function onUse(cid, item, frompos, item2, topos)
piece1pos = {x=438, y=234, z=14, stackpos=1}

eng1 = {x=438, y=234, z=14, stackpos=1}

getpiece1 = getThingfromPos(piece1pos)

if item.uid == 2412 and item.itemid == 3900 and getpiece1.itemid == 2412 then

doCreateItem(5068,1,eng1)
doCreateItem(5069,1,eng1)
doTeleportThing(cid,{x=439, y=238, z=15})
doSendMagicEffect(topos,10)
doSendAnimatedText(topos, "Wooow!", TEXTCOLOR_ORANGE)
doRemoveItem(item.uid,1)
end
end