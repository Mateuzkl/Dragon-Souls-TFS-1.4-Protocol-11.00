function onUse(cid, item, frompos, item2, topos)

piecepos = {x=463, y=234, z=14, stackpos=2}
piece1pos = {x=453, y=236, z=14, stackpos=1}
piece2pos = {x=453, y=238, z=14, stackpos=1}
piece3pos = {x=453, y=240, z=14, stackpos=1}
piece4pos = {x=453, y=242, z=14, stackpos=1}
piece5pos = {x=453, y=244, z=14, stackpos=1}
piece6pos = {x=473, y=236, z=14, stackpos=1}
piece7pos = {x=473, y=238, z=14, stackpos=1}
piece8pos = {x=473, y=240, z=14, stackpos=1}
piece9pos = {x=473, y=242, z=14, stackpos=1}
piece10pos = {x=473, y=244, z=14, stackpos=1}
piece11pos = {x=461, y=247, z=14, stackpos=1}
piece12pos = {x=461, y=250, z=14, stackpos=1}
piece13pos = {x=466, y=247, z=14, stackpos=1}
piece14pos = {x=466, y=250, z=14, stackpos=1}
piece15pos = {x=464, y=248, z=14, stackpos=1}

rockpos1 = {x=453, y=236, z=14, stackpos=1}
rockpos2 = {x=453, y=238, z=14, stackpos=1}
rockpos3 = {x=453, y=240, z=14, stackpos=1}
rockpos4 = {x=453, y=242, z=14, stackpos=1}
rockpos5 = {x=453, y=244, z=14, stackpos=1}
rockpos6 = {x=473, y=236, z=14, stackpos=1}
rockpos7 = {x=473, y=238, z=14, stackpos=1}
rockpos8 = {x=473, y=240, z=14, stackpos=1}
rockpos9 = {x=473, y=242, z=14, stackpos=1}
rockpos10 = {x=473, y=244, z=14, stackpos=1}
rockpos11 = {x=461, y=247, z=14, stackpos=1}
rockpos12 = {x=461, y=250, z=14, stackpos=1}
rockpos13 = {x=466, y=247, z=14, stackpos=1}
rockpos14 = {x=466, y=250, z=14, stackpos=1}
rockpos15 = {x=464, y=248, z=14, stackpos=1}

getpiece = getThingfromPos(piecepos)
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
getpiece12 = getThingfromPos(piece12pos)
getpiece13 = getThingfromPos(piece13pos)
getpiece14 = getThingfromPos(piece14pos)
getpiece15 = getThingfromPos(piece15pos)

if item2.itemid == 2071 and getpiece.itemid == 2071 and getpiece1.itemid == 1455 and getpiece2.itemid == 1455 and getpiece3.itemid == 1455 and getpiece4.itemid == 1455 and getpiece5.itemid == 1455 and getpiece6.itemid == 1454 and getpiece7.itemid == 1454 and getpiece8.itemid == 1454 and getpiece9.itemid == 1454 and getpiece10.itemid == 1454 and getpiece11.itemid == 1455 and getpiece12.itemid == 1455  and getpiece13.itemid == 1454 and getpiece14.itemid == 1454 then

doRemoveItem(getpiece1.uid,1)
doRemoveItem(getpiece2.uid,1)
doRemoveItem(getpiece3.uid,1)
doRemoveItem(getpiece4.uid,1)
doRemoveItem(getpiece5.uid,1)
doRemoveItem(getpiece6.uid,1)
doRemoveItem(getpiece7.uid,1)
doRemoveItem(getpiece8.uid,1)
doRemoveItem(getpiece9.uid,1)
doRemoveItem(getpiece10.uid,1)
doRemoveItem(getpiece11.uid,1)
doRemoveItem(getpiece12.uid,1)
doRemoveItem(getpiece13.uid,1)
doRemoveItem(getpiece14.uid,1)
doCreateItem(1459,1,rockpos1)
doCreateItem(1459,1,rockpos2)
doCreateItem(1459,1,rockpos3)
doCreateItem(1459,1,rockpos4)
doCreateItem(1459,1,rockpos5)
doCreateItem(1458,1,rockpos6)
doCreateItem(1458,1,rockpos7)
doCreateItem(1458,1,rockpos8)
doCreateItem(1458,1,rockpos9)
doCreateItem(1458,1,rockpos10)
doCreateItem(1459,1,rockpos11)
doCreateItem(1459,1,rockpos12)
doCreateItem(1458,1,rockpos13)
doCreateItem(1458,1,rockpos14)
doCreateItem(1396,1,rockpos15)

doSummonCreature("Guardian Gargoyle", {x=453, y=236, z=14})
doSummonCreature("Guardian Gargoyle", {x=453, y=238, z=14})
doSummonCreature("Guardian Gargoyle", {x=453, y=240, z=14})
doSummonCreature("Guardian Gargoyle", {x=453, y=242, z=14})
doSummonCreature("Guardian Gargoyle", {x=453, y=244, z=14})
doSummonCreature("Guardian Gargoyle", {x=473, y=236, z=14})
doSummonCreature("Guardian Gargoyle", {x=473, y=238, z=14})
doSummonCreature("Guardian Gargoyle", {x=473, y=240, z=14})
doSummonCreature("Guardian Gargoyle", {x=473, y=242, z=14})
doSummonCreature("Guardian Gargoyle", {x=473, y=244, z=14})
doSummonCreature("Guardian Gargoyle", {x=461, y=247, z=14})
doSummonCreature("Guardian Gargoyle", {x=461, y=250, z=14})
doSummonCreature("Guardian Gargoyle", {x=466, y=247, z=14})
doSummonCreature("Guardian Gargoyle", {x=466, y=250, z=14})

doSendMagicEffect(getpiece1,CONST_ME_MAGIC_BLUE)
doSendMagicEffect(getpiece2,CONST_ME_MAGIC_BLUE)
doSendMagicEffect(getpiece3,CONST_ME_MAGIC_BLUE)
doSendMagicEffect(getpiece4,CONST_ME_MAGIC_BLUE)
doSendMagicEffect(getpiece5,CONST_ME_MAGIC_BLUE)
doSendMagicEffect(getpiece6,CONST_ME_MAGIC_BLUE)
doSendMagicEffect(getpiece7,CONST_ME_MAGIC_BLUE)
doSendMagicEffect(getpiece8,CONST_ME_MAGIC_BLUE)
doSendMagicEffect(getpiece9,CONST_ME_MAGIC_BLUE)
doSendMagicEffect(getpiece10,CONST_ME_MAGIC_BLUE)
doSendMagicEffect(getpiece11,CONST_ME_MAGIC_BLUE)
doSendMagicEffect(getpiece12,CONST_ME_MAGIC_BLUE)
doSendMagicEffect(getpiece13,CONST_ME_MAGIC_BLUE)
doSendMagicEffect(getpiece14,CONST_ME_MAGIC_BLUE)

doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
doSendAnimatedText(getPlayerPosition(cid), "Cleck!", TEXTCOLOR_ORANGE)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
doPlayerSendTextMessage(cid,22,"Os seres adormecidos foram despertados atraves do som dos deuses.")
else
doPlayerSendTextMessage(cid,22,"Desculpe, não é possivel.")
end
return 1
end
