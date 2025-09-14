-- Diging up scarabs and scarab coins from sand!
 -- By Roman edited by grimmed for 7.5 use :D
 -- To get it to working replace this code with your old shovel lua
 function onUse(cid, item, frompos, item2, topos)
 if item2.itemid == 28 then
  return 0
 end
 if item2.itemid == 3797 then
		doTransformItem(item2.uid,5463)

	rat1pos = {x=493, y=248, z=13}
	rat2pos = {x=494, y=248, z=13}
	rat3pos = {x=494, y=249, z=13}
	rat4pos = {x=494, y=250, z=13}
	rat5pos = {x=493, y=250, z=13}
	rat6pos = {x=492, y=250, z=13}
	rat7pos = {x=492, y=249, z=13}
	rat8pos = {x=492, y=248, z=13}
	manticos9pos = {x=496, y=258, z=13}

	doSummonCreature("Rat", rat1pos)
	doSummonCreature("Rat", rat2pos)
	doSummonCreature("Rat", rat3pos)
	doSummonCreature("Rat", rat4pos)
	doSummonCreature("Rat", rat5pos)
	doSummonCreature("Rat", rat6pos)
	doSummonCreature("Rat", rat7pos)
	doSummonCreature("Rat", rat8pos)
	doSummonCreature("Jugger Manticos", manticos9pos)
doSendMagicEffect(topos,10)
doSendMagicEffect(getPlayerPosition(cid),10)

	elseif item2.itemid == 2739 then
		doTransformItem(item2.uid,2737)
		doDecayItem(item2.uid)
		doCreateItem(2694,1,topos)
	elseif item2.itemid == 5471 then
		doTransformItem(item2.uid,5463)
		doDecayItem(item2.uid)
		doCreateItem(5467,1,topos)

 elseif item2.itemid == 3799 then
		doTransformItem(item2.uid,5463)

	scp1pos = {x=499, y=248, z=13}
	scp2pos = {x=500, y=248, z=13}
	scp3pos = {x=500, y=249, z=13}
	scp4pos = {x=500, y=250, z=13}
	scp5pos = {x=499, y=250, z=13}
	scp6pos = {x=498, y=250, z=13}
	scp7pos = {x=498, y=249, z=13}
	scp8pos = {x=498, y=248, z=13}
	manticos9pos = {x=496, y=258, z=13}

	doSummonCreature("Scorpion", scp1pos)
	doSummonCreature("Scorpion", scp2pos)
	doSummonCreature("Scorpion", scp3pos)
	doSummonCreature("Scorpion", scp4pos)
	doSummonCreature("Scorpion", scp5pos)
	doSummonCreature("Scorpion", scp6pos)
	doSummonCreature("Scorpion", scp7pos)
	doSummonCreature("Scorpion", scp8pos)
	doSummonCreature("Jugger Manticos", manticos9pos)
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