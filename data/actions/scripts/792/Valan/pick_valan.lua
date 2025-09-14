-- Diging up scarabs and scarab coins from sand!
 -- By Roman edited by grimmed for 7.5 use :D
 -- To get it to working replace this code with your old shovel lua
 function onUse(cid, item, frompos, item2, topos)
doRemoveItem(item.uid,1)
 if item2.itemid == 28 then
  return 0
 end
 if item2.itemid == 6299 then
  doTransformItem(item2.uid,383)
  doDecayItem(item2.uid)
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