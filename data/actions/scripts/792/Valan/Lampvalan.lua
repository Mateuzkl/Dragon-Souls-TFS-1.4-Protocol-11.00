-- Diging up scarabs and scarab coins from sand!
 -- By Roman edited by grimmed for 7.5 use :D
 -- To get it to working replace this code with your old shovel lua
 function onUse(cid, item, frompos, item2, topos)
doRemoveItem(item.uid,1)
 if item2.itemid == 28 then
  return 0
 end
 if item2.itemid == 2064 then
wall1 = {x=468, y=257, z=14, stackpos=1}
wall2 = {x=468, y=258, z=14, stackpos=1}
wall3 = {x=458, y=259, z=14, stackpos=1}
	getwall1 = getThingfromPos(wall1)
	getwall2 = getThingfromPos(wall2)
	getwall3 = getThingfromPos(wall3)
		doCreateItem(5061,1,wall1)
		doCreateItem(2065,1,wall2)
		doCreateItem(407,1,wall3)
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