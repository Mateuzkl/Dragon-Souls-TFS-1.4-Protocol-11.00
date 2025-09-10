-- the id of the creature we are attacking, following, etc.
 
  target = 0
  following = false
  attacking = false
 
  function onThingMove(creature, thing, oldpos, oldstackpos)
 
  end
 
 
  function onCreatureAppear(creature)
 
  end
 
 
  function onCreatureDisappear(cid, pos)
 
  end
 
 
  function onCreatureTurn(creature)
 
  end
 
 
  function onCreatureSay(cid, type, msg)
  	msg = string.lower(msg)
 
  	if (string.find(msg, '(%a*)hi(%a*)')) and getDistanceToCreature(cid) < 4 then
  		selfSay('I dont talk to unrespectable people!')
  		focus = cid
 		selfLook(cid)
  	end
  	if (string.find(msg, '(%a*)oi(%a*)')) and getDistanceToCreature(cid) < 4 then
  		selfSay('Quem vc pensa que é para falar assim comigo?!')
  		focus = cid
 		selfLook(cid)
  	end
  	if (string.find(msg, '(%a*)oi rainha(%a*)')) and getDistanceToCreature(cid) < 4 then
  		selfSay('Estou com tanta fome, preciso de um cozinheiro...')
  		focus = cid
 		selfLook(cid)
  	end
  	if (string.find(msg, '(%a*)hi queen(%a*)')) and getDistanceToCreature(cid) < 4 then
  		selfSay('I am so hungry , i need a cooker...')
  		focus = cid
 		selfLook(cid)
  	end
  end
 
 
  function onCreatureChangeOutfit(creature)
 
  end
 
 
  function onThink()
 
  end
 

 
