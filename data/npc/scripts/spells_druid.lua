focus = 0
 talk_start = 0
 target = 0
 following = false
 attacking = false
 
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
  		if getPlayerVocation(cid) == 2 then
  			selfSay('Hello ' .. creatureGetName(cid) .. '! What spell do you want to learn?')
  			focus = cid
  			talk_start = os.clock()
  		else
  			selfSay('Sorry, I sell spells for druids.')
  		end

   	if ((string.find(msg, '(%a*)oi(%a*)')) and (focus == 0)) and getDistanceToCreature(cid) < 4 then
  		if getPlayerVocation(cid) == 2 then
  			selfSay('Ola ' .. creatureGetName(cid) .. '! Que magia iria apreder hoje?')
  			focus = cid
  			talk_start = os.clock()
  		else
  			selfSay('Desculpe , so druidas autorizados.')
  		end

  	if string.find(msg, '(%a*)hi(%a*)') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')
  	end

  	if string.find(msg, '(%a*)oi(%a*)') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Desculpe, ' .. creatureGetName(cid) .. '! Falo com voce em um minuto.')
  	end	

		if msgcontains(msg, 'light healing')) and focus == cid then
   			learnSpell(cid,'exura',170)
  		talk_start = os.clock()
  	end	
		if msgcontains(msg, 'create food')) and focus == cid then
   			learnSpell(cid,'exevo pan',150)
  		talk_start = os.clock()
  	end
		if msgcontains(msg, 'force strike')) and focus == cid then
   			learnSpell(cid,'exori mort',600)
  		talk_start = os.clock()
  	end
  		if msgcontains(msg, 'heavy magic missle')) and focus == cid then
   			learnSpell(cid,'adori gran',600)
  		talk_start = os.clock()
  	end
  		if msgcontains(msg, 'energy strike')) and focus == cid then
   			learnSpell(cid,'exori mort',800)
  		talk_start = os.clock()
  	end
  		if msgcontains(msg, 'flame strike')) and focus == cid then
   			learnSpell(cid,'exori flam',800)
  		talk_start = os.clock()
  	end
  		if msgcontains(msg, 'magic shield')) and focus == cid then
   			learnSpell(cid,'utamo vita',450)
  		talk_start = os.clock()
  	end
  		if msgcontains(msg, 'intense healing rune')) and focus == cid then
   			learnSpell(cid,'adura gran',600)
  		talk_start = os.clock()
  	end
  		if msgcontains(msg, 'intense healing')) and focus == cid then
   			learnSpell(cid,'exura gran',350)
  		talk_start = os.clock()
  	end
  		if msgcontains(msg, 'heal friend')) and focus == cid then
   			learnSpell(cid,'exura sio',800)
  		talk_start = os.clock()
  	end
  		if msgcontains(msg, 'strong haste')) and focus == cid then
   			learnSpell(cid,'utani gran hur',1300)
  		talk_start = os.clock()
  	end
  		if msgcontains(msg, 'haste')) and focus == cid then
   			learnSpell(cid,'utani hur',600)
  		talk_start = os.clock()
  	end
  		if msgcontains(msg, 'great fireball')) and focus == cid then
   			learnSpell(cid,'adori gran flam',1200)
  		talk_start = os.clock()
  	end
  		if msgcontains(msg, 'ultimate healing rune')) and focus == cid then
   			learnSpell(cid,'adura vita',1500)
  		talk_start = os.clock()
  	end
  		if msgcontains(msg, 'ultimate healing')) and focus == cid then
   			learnSpell(cid,'exura vita',1000)
  		talk_start = os.clock()
  	end
  		if msgcontains(msg, 'explosion')) and focus == cid then
   			learnSpell(cid,'adevo mas hur',1800)
  		talk_start = os.clock()
  	end
  		if msgcontains(msg, 'mass healing')) and focus == cid then
   			learnSpell(cid,'exevo gran mas res',2200)
  		talk_start = os.clock()
  	end
  		if msgcontains(msg, 'poison storm')) and focus == cid then
   			learnSpell(cid,'exevo gran mas pox',3400)
  		talk_start = os.clock()
  	end
  		if msgcontains(msg, 'ultimate light')) and focus == cid then
  			learnSpell(cid,'utevo vis lux',1600)
  		talk_start = os.clock()
  	end
  		if msgcontains(msg, 'greater light')) and focus == cid then
  			learnSpell(cid,'utevo gran lux',500)
  		talk_start = os.clock()
  	end
  		if msgcontains(msg, 'light')) and focus == cid then
  			learnSpell(cid,'utevo lux',100)
  		talk_start = os.clock()
  	end
 		if msgcontains(msg, 'invisible')) and focus == cid then
  			learnSpell(cid,'utana vid',1000)
  		talk_start = os.clock()
  	end
 		if msgcontains(msg, 'summon')) and focus == cid then
  			learnSpell(cid,'utevo res',2000)
  		talk_start = os.clock()
  	end
 		if msgcontains(msg, 'find person')) and focus == cid then
  			learnSpell(cid,'exiva',80)
  		talk_start = os.clock()
  	end
 		if msgcontains(msg, 'magic rope')) and focus == cid then
  			learnSpell(cid,'exani tera',200)
  		talk_start = os.clock()
  	end
 		if msgcontains(msg, 'levitate')) and focus == cid then
  			learnSpell(cid,'exani hur',500)
  		talk_start = os.clock()
  	end
 		if msgcontains(msg, 'antidote')) and focus == cid then
  			learnSpell(cid,'exana pox',150)
  		talk_start = os.clock()
  	end
 		if msgcontains(msg, 'wild growth')) and focus == cid then
  			learnSpell(cid,'exani tera',2000)
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
   	if (os.clock() - talk_start) > 30 then
   		if focus > 0 then
   			selfSay('Next Please...')
   		end
   			focus = 0
   	end
  	if focus ~= 0 then
  		if getDistanceToCreature(focus) > 5 then
  			selfSay('Good bye then.')
  			focus = 0
  		end
  	end
 end
