function onUse(cid, item, frompos, item2, topos)
piece1pos = {x=501, y=256, z=13, stackpos=2}
piece2pos = {x=501, y=260, z=13, stackpos=2}
piece3pos = {x=498, y=255, z=13, stackpos=2}
piece4pos = {x=495, y=252, z=13, stackpos=2}
piece5pos = {x=494, y=261, z=13, stackpos=2}
piece6pos = {x=495, y=252, z=13, stackpos=2}
piece7pos = {x=498, y=261, z=13, stackpos=2}
piece8pos = {x=494, y=255, z=13, stackpos=2}
piece9pos = {x=491, y=256, z=13, stackpos=2}
piece10pos = {x=497, y=252, z=13, stackpos=2}
piece11pos = {x=504, y=258, z=13, stackpos=1}
eng1 = {x=501, y=256, z=13, stackpos=2}
eng2 = {x=501, y=260, z=13, stackpos=2}
eng3 = {x=498, y=255, z=13, stackpos=2}
eng4 = {x=495, y=252, z=13, stackpos=2}
eng5 = {x=494, y=261, z=13, stackpos=2}
eng6 = {x=491, y=260, z=13, stackpos=2}
eng7 = {x=491, y=256, z=13, stackpos=2}
eng8 = {x=494, y=255, z=13, stackpos=2}
eng9 = {x=498, y=261, z=13, stackpos=2}
eng10 = {x=497, y=252, z=13, stackpos=2}
eng11 = {x=504, y=258, z=13, stackpos=1}
getpiece1 = getThingfromPos(piece1pos)
getpiece2 = getThingfromPos(piece2pos)
getpiece3 = getThingfromPos(piece3pos)
getpiece4 = getThingfromPos(piece4pos)
getpiece5 = getThingfromPos(piece5pos)
getpiece6 = getThingfromPos(piece6pos)
getpiece7 = getThingfromPos(piece7pos)
getpiece8 = getThingfromPos(piece8pos)
getpiece9 = getThingfromPos(piece9pos)
getpiece10 = getThingfromPos(piece10pos)
getpiece11 = getThingfromPos(piece11pos)
if item.uid == 6037 and item.itemid == 4333 and getpiece1.itemid == 2813 and getpiece2.itemid == 2813 and getpiece3.itemid == 2813 and getpiece4.itemid == 2813 and getpiece5.itemid == 2813 and getpiece6.itemid == 2813 and getpiece7.itemid == 2897 and getpiece8.itemid == 2897 and getpiece9.itemid == 2897 and getpiece10.itemid == 2897 and getpiece11.itemid == 1355 then
doCreateItem(5066,1,eng1)
doCreateItem(5067,1,eng1)
doCreateItem(5066,1,eng2)
doCreateItem(5067,1,eng2)
doCreateItem(5066,1,eng3)
doCreateItem(5067,1,eng3)
doCreateItem(5066,1,eng4)
doCreateItem(5067,1,eng4)
doCreateItem(5066,1,eng5)
doCreateItem(5067,1,eng5)
doCreateItem(5066,1,eng6)
doCreateItem(5067,1,eng6)
doCreateItem(5068,1,eng7)
doCreateItem(5069,1,eng7)
doCreateItem(5068,1,eng8)
doCreateItem(5069,1,eng8)
doCreateItem(5068,1,eng9)
doCreateItem(5069,1,eng9)
doCreateItem(5068,1,eng10)
doCreateItem(5069,1,eng10)
doRemoveItem(getpiece11.uid,1)
	guards1pos = {x=491, y=255, z=13}
	guards2pos = {x=491, y=261, z=13}
	guards3pos = {x=496, y=258, z=13}
	guards4pos = {x=501, y=261, z=13}
	guards5pos = {x=501, y=255, z=13}

	doSummonCreature("Juggernaut", guards1pos)
	doSummonCreature("Juggernaut", guards2pos)
	doSummonCreature("Orshabaal", guards3pos)
	doSummonCreature("Juggernaut", guards4pos)
	doSummonCreature("Juggernaut", guards5pos)

doSendAnimatedText(getPlayerPosition(cid), "Schzzz", TEXTCOLOR_BLUE)
doSendMagicEffect(topos,10)
doSendMagicEffect(getPlayerPosition(cid),10)
doTransformItem(item.uid,item.itemid+1)
elseif item.uid == 6037 and item.itemid == 4334 then
 doTransformItem(item.uid,item.itemid-1)
else
doPlayerSendTextMessage(cid,22,"Sorry you need the sequence of mystic books.")
end
return 1
end