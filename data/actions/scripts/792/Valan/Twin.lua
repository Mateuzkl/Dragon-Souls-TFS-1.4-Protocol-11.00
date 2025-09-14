-- Diging up scarabs and scarab coins from sand!
 -- By Roman edited by grimmed for 7.5 use :D
 -- To get it to working replace this code with your old shovel lua
 function onUse(cid, item, frompos, item2, topos)
doRemoveItem(item.uid,1)
 if item2.itemid == 28 then
  return 0
 end
 if item2.itemid == 1412 then
wall1 = {x=420, y=254, z=15, stackpos=1}
wall2 = {x=420, y=254, z=15, stackpos=1}
	getwall1 = getThingfromPos(wall1)
	getwall2 = getThingfromPos(wall2)
		doCreateItem(5070,1,wall1)
		doCreateItem(1509,1,wall2)
doSendMagicEffect(topos,10)
doSendMagicEffect(getPlayerPosition(cid),10)
doSendAnimatedText(getPlayerPosition(cid), "Hell", TEXTCOLOR_RED)
  doDecayItem(item2.uid)
 elseif item2.itemid == 1415 then
wall3 = {x=463, y=246, z=15, stackpos=1}
wall4 = {x=463, y=246, z=15, stackpos=1}
	getwall3 = getThingfromPos(wall3)
	getwall4 = getThingfromPos(wall4)
		doCreateItem(5070,1,wall3)
		doCreateItem(1509,1,wall4)
doSendMagicEffect(topos,10)
doSendMagicEffect(getPlayerPosition(cid),10)
doSendAnimatedText(getPlayerPosition(cid), "Hell", TEXTCOLOR_RED)
  doDecayItem(item2.uid)
 elseif item2.itemid == 1413 then
wall5 = {x=456, y=220, z=15, stackpos=1}
wall6 = {x=456, y=220, z=15, stackpos=1}
	getwall5 = getThingfromPos(wall5)
	getwall6 = getThingfromPos(wall6)
		doCreateItem(5070,1,wall5)
		doCreateItem(1509,1,wall6)
doSendMagicEffect(topos,10)
doSendMagicEffect(getPlayerPosition(cid),10)
doSendAnimatedText(getPlayerPosition(cid), "Hell", TEXTCOLOR_RED)

  doDecayItem(item2.uid)
 elseif item2.itemid == 1414 then
wall7 = {x=419, y=227, z=15, stackpos=1}
wall8 = {x=419, y=227, z=15, stackpos=1}
	getwall7 = getThingfromPos(wall7)
	getwall8 = getThingfromPos(wall8)
		doCreateItem(5070,1,wall7)
		doCreateItem(1509,1,wall8)
doSendMagicEffect(topos,10)
doSendMagicEffect(getPlayerPosition(cid),10)
doSendAnimatedText(getPlayerPosition(cid), "Hell", TEXTCOLOR_RED)
  doDecayItem(item2.uid)
  rand = math.random(1,30)
  if rand < 6 then
   doSummonCreature("", topos)
  elseif rand == 100	 then
   doPlayerAddItem(cid,2006,1)
  else
   doSendMagicEffect(topos,2)
  end
 else
  return 0
 end
 return 1
 end