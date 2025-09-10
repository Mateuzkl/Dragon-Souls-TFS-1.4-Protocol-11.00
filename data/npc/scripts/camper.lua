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
  		selfSay('Shhh! I See an head of orc leaving on this hole!')
  		focus = cid
 		selfLook(cid)
  	end
 
  	if (string.find(msg, '(%a*)oi(%a*)')) and getDistanceToCreature(cid) < 4 then
  		selfSay('Shhh! Eu vi uma cabeça de orc saindo desse buraco!')
  		focus = cid
 		selfLook(cid)
  	end
  end
 
 
  function onCreatureChangeOutfit(creature)
 
  end
 
 
  function onThink()
 
  end
 
