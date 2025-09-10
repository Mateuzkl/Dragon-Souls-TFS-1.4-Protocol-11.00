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
  		selfSay('I dont speak to unrespectable people!')
  	end
  end
  	if (string.find(msg, '(%a*)oi(%a*)')) and getDistanceToCreature(cid) < 4 then
  		selfSay('Nao falo com pessoas sem educacao!')
  	end
  end
  	if (string.find(msg, '(%a*)oi rainha(%a*)')) and getDistanceToCreature(cid) < 4 then
  		selfSay('Estou faminta , preciso de um cozinheiro...')
  	end
  end
  	if (string.find(msg, '(%a*)hi queen(%a*)')) and getDistanceToCreature(cid) < 4 then
  		selfSay('I am so hungry, i need a cooker...')
  	end
  end
 
 
  function onCreatureChangeOutfit(creature)
 
  end
 
 
  function onThink()
 
  end
 
