-- the id of the creature we are attacking, following, etc.
 
  ox = 219
  oy = 106
  oz = 7
  max = 2
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
  
  	if ((string.find(msg, '(%a*)hi(%a*)')) and (focus == 0)) and getDistanceToCreature(cid) < 3 then
  		selfSay('Hello ' .. creatureGetName(cid) .. '! Welcome to information box, I just have information about.: RUNES, WANDS, BLESSINGS, HOUSES AND READABLES. how can i help you ?')
  		focus = cid
 		selfLook(cid)
  		talk_start = os.clock()
  	end

  	if ((string.find(msg, '(%a*)oi(%a*)')) and (focus == 0)) and getDistanceToCreature(cid) < 3 then
  		selfSay('Ola ' .. creatureGetName(cid) .. '! Bemvindo a Cabine da Informacao, So posso te informar sobre.: RUNAS, VARINHAS, BLESSINGS, CASAS E READABLES. Como posso te ajudar ?')
  		focus = cid
 		selfLook(cid)
  		talk_start = os.clock()
  	end
 
 	if string.find(msg, '(%a*)hi(%a*)') and (focus ~= cid) and getDistanceToCreature(cid) < 3 then
  		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')
  	end

 	if string.find(msg, '(%a*)oi(%a*)') and (focus ~= cid) and getDistanceToCreature(cid) < 3 then
  		selfSay('Desculpe, ' .. creatureGetName(cid) .. '! Falo contigo em um minutos.')
  	end
 
 	if msgcontains(msg, 'runes') and focus == cid then
  		selfSay('You can buy runes next to Carlin Ship')
  		talk_start = os.clock()
  	end

 	if msgcontains(msg, 'runas') and focus == cid then
  		selfSay('Voce pode comprar runas proximo ao Barco de Carlin')
  		talk_start = os.clock()
  	end
 
  	if msgcontains(msg, 'wands') and focus == cid then
  		selfSay('You can buy wands in the west on carlin on Druid Shop.')
  		talk_start = os.clock()
  	end

  	if msgcontains(msg, 'varinhas') and focus == cid then
  		selfSay('Voce pode comprar varinhas no leste de Carlin na Loja Druida.')
  		talk_start = os.clock()
  	end
 	if msgcontains(msg, 'blessings') and focus == cid then
  		selfSay('We have diferent bless if you free acc and dont help server u can got just 2 bless but need walk so much to find the Lost´s NPCs')
  		talk_start = os.clock()
  	end
 	if msgcontains(msg, 'houses') and focus == cid then
  		selfSay('To buy a house, just need help server with a donation and you will have your house.')
  		talk_start = os.clock()
  	end

 	if msgcontains(msg, 'casas') and focus == cid then
  		selfSay('Para comprar uma casa, basta ajudar o servidor com uma doacao e tera uma.')
  		talk_start = os.clock()
  	end
 
 	if msgcontains(msg, 'readables') and focus == cid then
  		selfSay('Just give LOOK on every readables on shops or quests , many information on it may save your life')
  		talk_start = os.clock()
  	end
 
  
  	if string.find(msg, '(%a*)bye(%a*)') and focus == cid and getDistanceToCreature(cid) < 3 then
  		selfSay('Good bye, ' .. creatureGetName(cid) .. '!')
  		focus = 0
  		talk_start = 0
  	end
  	if string.find(msg, '(%a*)tchau(%a*)') and focus == cid and getDistanceToCreature(cid) < 3 then
  		selfSay('Sempre as ordens, ' .. creatureGetName(cid) .. '!')
  		focus = 0
  		talk_start = 0
  	end
  end
  
  
  function onCreatureChangeOutfit(creature)
  
end


 function onThink() 
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
  			selfSay('Good bye then.')
  			focus = 0
  		end
 	end
end
