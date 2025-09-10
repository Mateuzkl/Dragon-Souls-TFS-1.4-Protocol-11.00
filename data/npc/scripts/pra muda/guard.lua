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
 
  	if (string.find(msg, '(%a*)hi queen(%a*)')) and getDistanceToCreature(cid) < 4 then
  		selfSay('Hail the Queen!')
  		focus = cid
 		selfLook(cid)
  	end
 
  	if (string.find(msg, '(%a*)oi rainha(%a*)')) and getDistanceToCreature(cid) < 4 then
  		selfSay('Salve a rainha!')
  		focus = cid
 		selfLook(cid)
  	end
  end
 
 
  function onCreatureChangeOutfit(creature)
 
  end
 
 
  function onThink()
 
  end
 
