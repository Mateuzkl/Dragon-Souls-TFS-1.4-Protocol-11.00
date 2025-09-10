-- the id of the creature we are attacking, following, etc.
 
  target = 0
  following = false
  attacking = false
 focus = 0
 
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
		randsay = math.random(1,4)
		if randsay == 1 then
  		selfSay('I cannot talk with you now.')
		end
		if randsay == 2 then
  		selfSay('Not now...')
		end
		if randsay == 3 then
  		selfSay('Who are you anyway?')
		end
		if randsay == 4 then
  		selfSay('Hail King Denethor!')
		end
  	end

  	if (string.find(msg, '(%a*)fuck(%a*)')) and getDistanceToCreature(cid) < 4 then
  		selfSay('Hey! Watch your mouth!')
  	end
  	if (string.find(msg, '(%a*)fdp(%a*)')) and getDistanceToCreature(cid) < 4 then
  		selfSay('Ei! Olha a educacao!')
  	end
 
  	if (string.find(msg, '(%a*)oi(%a*)')) and getDistanceToCreature(cid) < 4 then
		randsay = math.random(1,4)
		if randsay == 1 then
  		selfSay('Não posso falar com voce agora.')
		end
		if randsay == 2 then
  		selfSay('Voce viu orcs?')
		end
		if randsay == 3 then
  		selfSay('Crianca sem educacao!')
		end
		if randsay == 4 then
  		selfSay('Salve o Rei Denethor!')
		end
  	end
  end
 
 
  function onCreatureChangeOutfit(creature)
 
  end
 
 
 function onThink() 

if focus == 0 then
randsay = math.random(1,500)
if randsay == 1 then
 selfSay('Hmm...There is something strange about this place.') 
end
if randsay == 250 then
 selfSay('Huh?...I think i heard something over there!') 
end
if randsay == 500 then
 selfSay('My fire sword is burning my hand!') 
end
end
end
 
 
