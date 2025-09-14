function onUse(cid, item, frompos, item2, topos)
piece1pos = {x=471, y=253, z=13, stackpos=3}
piece2pos = {x=471, y=255, z=13, stackpos=3}
piece3pos = {x=471, y=257, z=13, stackpos=3}
piece4pos = {x=471, y=259, z=13, stackpos=3}
piece5pos = {x=471, y=261, z=13, stackpos=3}
piece6pos = {x=476, y=257, z=13, stackpos=1}
eng1 = {x=471, y=253, z=13, stackpos=1}
eng1 = {x=471, y=253, z=13, stackpos=1}
eng1 = {x=471, y=253, z=13, stackpos=1}
eng2 = {x=471, y=255, z=13, stackpos=2}
eng2 = {x=471, y=255, z=13, stackpos=2}
eng2 = {x=471, y=255, z=13, stackpos=2}
eng3 = {x=471, y=257, z=13, stackpos=3}
eng3 = {x=471, y=257, z=13, stackpos=3}
eng3 = {x=471, y=257, z=13, stackpos=3}
eng4 = {x=471, y=259, z=13, stackpos=4}
eng4 = {x=471, y=259, z=13, stackpos=4}
eng4 = {x=471, y=259, z=13, stackpos=4}
eng5 = {x=471, y=261, z=13, stackpos=5}
eng5 = {x=471, y=261, z=13, stackpos=5}
eng5 = {x=471, y=261, z=13, stackpos=5}
eng6 = {x=474, y=257, z=13, stackpos=6}
getpiece1 = getThingfromPos(piece1pos)
getpiece2 = getThingfromPos(piece2pos)
getpiece3 = getThingfromPos(piece3pos)
getpiece4 = getThingfromPos(piece4pos)
getpiece5 = getThingfromPos(piece5pos)
getpiece6 = getThingfromPos(piece6pos)
if item.uid == 6036 and item.itemid == 4331 and getpiece1.itemid == 1982 and getpiece2.itemid == 1983 and getpiece3.itemid == 1984 and getpiece4.itemid == 1985 and getpiece5.itemid == 1986 and getpiece6.itemid == 1354 then
doCreateItem(5070,1,eng1)
doCreateItem(5070,1,eng2)
doCreateItem(5070,1,eng3)
doCreateItem(5070,1,eng4)
doCreateItem(5070,1,eng5)
doCreateItem(5070,1,eng6)
doRemoveItem(getpiece6.uid,1)
doSendAnimatedText(getPlayerPosition(cid), "Cleck!", TEXTCOLOR_ORANGE)
doSendMagicEffect(topos,CONST_ME_BLOCKHIT)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_BLOCKHIT)
doTransformItem(item.uid,item.itemid+1)
elseif item.uid == 6036 and item.itemid == 4332 then
doTransformItem(item.uid,item.itemid-1)
else
doPlayerSendTextMessage(cid,20,"Sorry you need the sequence of mystic books.")
end
return 1
end