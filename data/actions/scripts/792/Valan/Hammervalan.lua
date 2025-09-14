-- Diging up scarabs and scarab coins from sand!
 -- By Roman edited by grimmed for 7.5 use :D
 -- To get it to working replace this code with your old shovel lua
 function onUse(cid, item, frompos, item2, topos)
doRemoveItem(item.uid,1)
 if item2.itemid == 28 then
  return 0
 end
 if item2.itemid == 1740 then
wall1 = {x=458, y=258, z=14, stackpos=1}
wall2 = {x=441, y=259, z=13, stackpos=1}
wall3 = {x=441, y=258, z=13, stackpos=1}
wall4 = {x=441, y=257, z=13, stackpos=1}
wall5 = {x=458, y=258, z=14, stackpos=1}
wall6 = {x=470, y=258, z=14, stackpos=1}
	getwall1 = getThingfromPos(wall1)
	getwall2 = getThingfromPos(wall2)
	getwall3 = getThingfromPos(wall3)
	getwall4 = getThingfromPos(wall4)
	getwall5 = getThingfromPos(wall5)
	getwall6 = getThingfromPos(wall6)
		doCreateItem(1740,1,wall1)
		doCreateItem(3766,1,wall2)
		doCreateItem(3766,1,wall3)
		doCreateItem(3766,1,wall4)
		doCreateItem(6116,1,wall5)
		doCreateItem(6117,1,wall5)
		doCreateItem(5070,1,wall5)
		doCreateItem(383,1,wall6)
 	doPlayerSendTextMessage(cid,22,"you actived the quest.")
doSendMagicEffect(topos,10)
doSendMagicEffect(getPlayerPosition(cid),10)
 elseif item2.itemid == 7186 then
  doTransformItem(item2.uid,383)
  doDecayItem(item2.uid)
 elseif item2.itemid == 483 then
  doTransformItem(item2.uid,484)
  doDecayItem(item2.uid)
 elseif item2.itemid == 231 then
  rand = math.random(1,30)
  if rand < 6 then
   doSummonCreature("Scarab", topos)
  elseif rand == 100 then
   doPlayerAddItem(cid,2159,1)
  else
   doSendMagicEffect(topos,2)
  end
 else
  return 0
 end
 return 1
 end