focus = 0
 talk_start = 0
 target = 0
 following = false
 attacking = false
 ox = 204
  oy = 100
  oz = 7
  max = 7
 
 function onThingMove(creature, thing, oldpos, oldstackpos)
 
 end
 
 
 function onCreatureAppear(creature)
 
 end
 
 
 function onCreatureDisappear(cid, pos)
 if focus == cid then
 selfSay('Good bye then.')
 focus = 0
 talk_start = 0
 end
 end
 
 function onCreatureTurn(creature)
 end
 function msgcontains(txt, str)
 return (string.find(txt, str) and not string.find(txt, '(%w+)' .. str) and not string.find(txt, str .. '(%w+)'))
 end
 
 function onCreatureSay(cid, type, msg)
 msg = string.lower(msg)
 
   	if ((string.find(msg, '(%a*)hi(%a*)')) and (focus == 0)) and getDistanceToCreature(cid) < 4 then
		selfSay('Hello ' .. creatureGetName(cid) .. '! I\'m one of Marine Sisters, we selling parcels and letters in all cities.')
 		focus = cid
 		selfLook(cid)
		talk_start = os.clock()
	end

   	if ((string.find(msg, '(%a*)oi(%a*)')) and (focus == 0)) and getDistanceToCreature(cid) < 4 then
		 selfSay('Ola ' .. creatureGetName(cid) .. '! Sou uma das Marine Sisters, Estamos vendendo parcels e letters em todas as cidades.')
 		focus = cid
 		selfLook(cid)
 		talk_start = os.clock()
	end
 
  	if string.find(msg, '(%a*)hi(%a*)') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')
  	end

  	if string.find(msg, '(%a*)oi(%a*)') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Desculpe, ' .. creatureGetName(cid) .. '! Falo com voce em um minuto.')
  	end
 
  	if msgcontains(msg, 'letter') and focus == cid then
		buy(cid,2597,1,10)
  		talk_start = os.clock()
  	end

  	if msgcontains(msg, 'parcel') and focus == cid then
		 buy(cid,2595,1,15)
		 buy(cid,2599,1,0)
  		talk_start = os.clock()
  	end

  	if msgcontains(msg, 'label') and focus == cid then
		 buy(cid,2599,1,0)
  		talk_start = os.clock()
  	end 

 
  	if string.find(msg, '(%a*)bye(%a*)') and focus == cid and getDistanceToCreature(cid) < 4 then
  		selfSay('Goodbye, ' .. creatureGetName(cid) .. '!')
  		focus = 0
  		talk_start = 0
  	end
  	if string.find(msg, '(%a*)tchau(%a*)') and focus == cid and getDistanceToCreature(cid) < 4 then
  		selfSay('Tchau, ' .. creatureGetName(cid) .. '!')
  		focus = 0
  		talk_start = 0
  	end
  end
 
 
 function onCreatureChangeOutfit(creature)
 
 end
 
 
 function onThink() 
if focus == 0 then
cx, cy, cz = selfGetPosition()
randmove = math.random(1,20)
if randmove == 1 then
nx = cx + 1
end
if randmove == 2 then
nx = cx - 1
end
if randmove == 3 then
ny = cy + 1
end
if randmove == 4 then
ny = cy - 1
end
if randmove >= 5 then
nx = cx
ny = cy
end
moveToPosition(nx, ny, cz)
end

 if (os.clock() - talk_start) > 30 then 
 if focus > 0 then 
 selfSay('Next please!') 
 talkcount = 0
 end 
 focus = 0 
 itemid = 0
 talk_start = 0 
 end 
  	if focus ~= 0 then
  		if getDistanceToCreature(focus) > 5 then
  			selfSay('Adeus.')
  			focus = 0
  		end
	end
end
 
