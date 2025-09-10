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
 
 endfunction msgcontains(txt, str)
   	return (string.find(txt, str) and not string.find(txt, '(%w+)' .. str) and not string.find(txt, str .. '(%w+)'))
 end
 
 
 function onCreatureSay(cid, type, msg)
   	msg = string.lower(msg)

   	if ((string.find(msg, '(%a*)hi(%a*)')) and (focus == 0)) and getDistanceToCreature(cid) < 4 then
  		selfSay('Hello ' .. creatureGetName(cid) .. '! I am the master miner fo the town,i can sell tell you all about it just say MORE.')
  		focus = cid
 		selfLook(cid)
  		talk_start = os.clock()
  	end


   	if ((string.find(msg, '(%a*)oi(%a*)')) and (focus == 0)) and getDistanceToCreature(cid) < 4 then
  		selfSay('Ola ' .. creatureGetName(cid) .. '! Eu sou o minerador chefe da regiao, posso te contar tudo sobre minerar e so dizer MAIS.')
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

       	 if msgcontains(msg, 'more') and focus == cid then
  		selfSay('Using a pick on sertain types of stalagmites you can extract some rocks or maybe a jewel! But first you need a pick , to buy one just say PICK')
  		talk_start = os.clock()
  	end

       	 if msgcontains(msg, 'mais') and focus == cid then
  		selfSay('Usando uma pick em certos tipos de rochas voce pode extrais algumas pedras ou entao uma joia! Mas primeiro voce precisa de uma pick , diga PICK para comprar')
  		talk_start = os.clock()
  	end

       	 if msgcontains(msg, 'golem') and focus == cid then
  		selfSay('Humpf!')
  		talk_start = os.clock()
  	end

       	 if msgcontains(msg, 'rocks') and focus == cid then
  		selfSay('Rocks are useless , but you may concentrate in JEWELS')
  		talk_start = os.clock()
  	end

       	 if msgcontains(msg, 'jewels') and focus == cid then
  		selfSay('You can obtains jewels if you persist in mining , they can make some money!')
  		talk_start = os.clock()
  	end

       	 if msgcontains(msg, 'pedras') and focus == cid then
  		selfSay('Pedras sao inuteis , voce deve se concentrar em JOIAS')
  		talk_start = os.clock()
  	end

       	 if msgcontains(msg, 'joias') and focus == cid then
  		selfSay('Voce obtem joias minerando duro, elas podem valer algum dinheiro!')
  		talk_start = os.clock()
  	end
 
  	if msgcontains(msg, 'pick') and focus == cid then
 		buy(cid,2553,1,50)
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
 