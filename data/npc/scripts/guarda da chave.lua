focus = 0
 talk_start = 0
 target = 0
 following = false
 attacking = false
 talkstate = 0
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
 
 endfunction msgcontains(txt, str)
   	return (string.find(txt, str) and not string.find(txt, '(%w+)' .. str) and not string.find(txt, str .. '(%w+)'))
 end
 
 
 function onCreatureSay(cid, type, msg)
   	msg = string.lower(msg)

   	if ((string.find(msg, '(%a*)hi(%a*)')) and (focus == 0)) and getDistanceToCreature(cid) < 4 then
  		selfSay('Hello ' .. creatureGetName(cid) .. '! I take care of the prison ,could take the key on the table and help me?')
  		focus = cid
 		selfLook(cid)
		talkstate = 1
 		selfLook(cid)
  		talk_start = os.clock()
  	end


   	if ((string.find(msg, '(%a*)oi(%a*)')) and (focus == 0)) and getDistanceToCreature(cid) < 4 then
  		selfSay('Ola ' .. creatureGetName(cid) .. '! Eu tomo conta da prisao, pegue a chave da bancada e poderia me ajuda a tomar conta do presos ?')
  		focus = cid
 		selfLook(cid)
		talkstate = 1
 		selfLook(cid)
  		talk_start = os.clock()
  	end
 
  	if string.find(msg, '(%a*)hi(%a*)') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')
  	end

  	if string.find(msg, '(%a*)oi(%a*)') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Desculpe, ' .. creatureGetName(cid) .. '! Falo com voce em um minuto.')
  	end

  	if string.find(msg, '(%a*)yes(%a*)') and focus == cid and talkstate == 1 then
  		selfSay('Thanks! but take care , they are dangerous.')
  		focus = 0
  		talk_start = 0
  	end
  	if string.find(msg, '(%a*)sim(%a*)') and focus == cid and talkstate == 1 then
  		selfSay('Obrigado! mas tome cuidado, eles são perigosos.')
  		focus = 0
  		talk_start = 0
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
 selfSay('Humpf!') 
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
 