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
  		if getPlayerVocation(cid) == 3 then
  			selfSay('Hello ' .. creatureGetName(cid) .. '! What spell do you want to learn?')
  			focus = cid
  			talk_start = os.clock()
  		else
  			selfSay('Sorry, I sell spells for paladins.')
  		end

   	if ((string.find(msg, '(%a*)oi(%a*)')) and (focus == 0)) and getDistanceToCreature(cid) < 4 then
  		if getPlayerVocation(cid) == 3 then
  			selfSay('Ola ' .. creatureGetName(cid) .. '! Que magia gostaria de aprender?')
  			focus = cid
  			talk_start = os.clock()
  		else
  			selfSay('Desculpe, so magia para paladinos.')
  		end

  	if string.find(msg, '(%a*)hi(%a*)') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')
  	end

  	if string.find(msg, '(%a*)oi(%a*)') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Desculpe, ' .. creatureGetName(cid) .. '! Falo com voce em um minuto.')
  	end
	
		if msgcontains(msg, 'light healing') and focus == cid then
   			learnSpell(cid,'exura',170)
  		talk_start = os.clock()
  	end	
		if msgcontains(msg, 'create food') and focus == cid then
   			learnSpell(cid,'exevo pan',150)
  		talk_start = os.clock()
  	end
  		if msgcontains(msg, 'intense healing') and focus == cid then
   			learnSpell(cid,'exura gran',350)
  		talk_start = os.clock()
  	end
  		if msgcontains(msg, 'conjure arrow') and focus == cid then
   			learnSpell(cid,'exevo con',450)
  		talk_start = os.clock()
  	end
  		if msgcontains(msg, 'heavy magic missle') and focus == cid then
   			learnSpell(cid,'adori gran',600)
  		talk_start = os.clock()
  	end
  		if msgcontains(msg, 'haste') and focus == cid then
   			learnSpell(cid,'utani hur',600)
  		talk_start = os.clock()
  	end
  		if msgcontains(msg, 'magic shield') and focus == cid then
   			learnSpell(cid,'utamo vita',450)
  		talk_start = os.clock()
  	end
  		if msgcontains(msg, 'conjure bolt') and focus == cid then
   			learnSpell(cid,'exevo con mort',750)
  		talk_start = os.clock()
  	end
  		if msgcontains(msg, 'ultimate healing') and focus == cid then
   			learnSpell(cid,'exura vita',1000)
  		talk_start = os.clock()
  	end
  		if msgcontains(msg, 'conjure burst arrow') and focus == cid then
   			learnSpell(cid,'exevo con flam',1000)
  		talk_start = os.clock()
  	end
  		if msgcontains(msg, 'conjure power bolt') and focus == cid then
   			learnSpell(cid,'exevo con vis',2000)
  		talk_start = os.clock()
  	end
  		if msgcontains(msg, 'greater light') and focus == cid then
  			learnSpell(cid,'utevo gran lux',500)
  		talk_start = os.clock()
  	end
  		if msgcontains(msg, 'light') and focus == cid then
  			learnSpell(cid,'utevo lux',100)	
  		talk_start = os.clock()
  	end	
		if msgcontains(msg, 'invisible') and focus == cid then
  			learnSpell(cid,'utana vid',1000)
  		talk_start = os.clock()
  	end
 		if msgcontains(msg, 'find person') and focus == cid then
  			learnSpell(cid,'exiva',80)
  		talk_start = os.clock()
  	end
 		if msgcontains(msg, 'magic rope') and focus == cid then
  			learnSpell(cid,'exani tera',200)
  		talk_start = os.clock()
  	end
 		if msgcontains(msg, 'levitate') and focus == cid then
  			learnSpell(cid,'exani hur',500)
  		talk_start = os.clock()
  	end
 		if msgcontains(msg, 'antidote') and focus == cid then
  			learnSpell(cid,'exana pox',150)
  		talk_start = os.clock()
  	end

   		if string.find(msg, '(%a*)bye(%a*)')  and getDistanceToCreature(cid) < 4 then
   			selfSay('Good bye, ' .. creatureGetName(cid) .. '!')
   			focus = 0
   			talk_start = 0
   		end
   		if string.find(msg, '(%a*)tchau(%a*)')  and getDistanceToCreature(cid) < 4 then
   			selfSay('Adeus, ' .. creatureGetName(cid) .. '!')
   			focus = 0
   			talk_start = 0
   		end
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
