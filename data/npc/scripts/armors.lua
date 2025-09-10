focus = 0
  talk_start = 0
  target = 0
  following = false
  attacking = false
  ox = 145
  oy = 51
  oz = 6
  max = 5
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
  
  	if ((string.find(msg, '(%a*)hi(%a*)')) and (focus == 0)) and getDistanceToCreature(cid) < 3 then
  		selfSay('Hello ' .. creatureGetName(cid) .. '! I sell armors, legs, helmets, boots and shields.')
  		focus = cid
 		selfLook(cid)
  		talk_start = os.clock()
  	end

  	if ((string.find(msg, '(%a*)oi(%a*)')) and (focus == 0)) and getDistanceToCreature(cid) < 3 then
  		selfSay('Ola ' .. creatureGetName(cid) .. '! Eu vendo armors,legs,helmets,boots e shields.')
  		focus = cid
 		selfLook(cid)
  		talk_start = os.clock()
  	end
  
  	if string.find(msg, '(%a*)hi(%a*)') and (focus ~= cid) and getDistanceToCreature(cid) < 3 then
  		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')
  	end

  	if string.find(msg, '(%a*)oi(%a*)') and (focus ~= cid) and getDistanceToCreature(cid) < 3 then
  		selfSay('Desculpe, ' .. creatureGetName(cid) .. '! Falo contigo em um minuto.')
  	end
  
  	if msgcontains(msg, 'armors') and focus == cid then
  		selfSay('I sell chain armor, brass armor and scale armor.')
  		talk_start = os.clock()
  	end

  	if msgcontains(msg, 'armaduras') and focus == cid then
  		selfSay('Vendo chain armor, brass armor e scale armor.')
  		talk_start = os.clock()
  	end
  
  	if msgcontains(msg, 'chain armor') and focus == cid then
  		buy(cid,2464,1,100)
  		talk_start = os.clock()
  	end
  
  	if msgcontains(msg, 'brass armor') and focus == cid then
  		buy(cid,2465,1,250)
  		talk_start = os.clock()
  	end
  
  	if msgcontains(msg, 'scale armor') and focus == cid then
  		buy(cid,2483,1,500)
  		talk_start = os.clock()
  	end
  
  	if msgcontains(msg, 'legs') and focus == cid then
  		selfSay('I sell chain and brass legs.')
  		talk_start = os.clock()
  	end
  
  	if msgcontains(msg, 'chain legs') and focus == cid then
  		buy(cid,2648,1,80)
  		talk_start = os.clock()
  	end
  
  	if msgcontains(msg, 'brass legs') and focus == cid then
  		buy(cid,2478,1,200)
  		talk_start = os.clock()
  	end
  
  	if msgcontains(msg, 'helmets') and focus == cid then
  		selfSay('I sell brass helmet, viking helmet and iron helmet.')
  		talk_start = os.clock()
  	end

  	if msgcontains(msg, 'capacetes') and focus == cid then
  		selfSay('Vendo brass helmet, viking helmet e iron helmet.')
  		talk_start = os.clock()
  	end
  
  	if msgcontains(msg, 'brass helmet') and focus == cid then
  		buy(cid,2460,1,50)
  		talk_start = os.clock()
  	end
  
  	if msgcontains(msg, 'viking helmet') and focus == cid then
  		buy(cid,2473,1,100)
  		talk_start = os.clock()
  	end
  
  	if msgcontains(msg, 'iron helmet') and focus == cid then
  		buy(cid,2459,1,190)
  		talk_start = os.clock()
  	end
  
  	if msgcontains(msg, 'boots') and focus == cid then
  		selfSay('I sell leather boots and sandals.')
  		talk_start = os.clock()
  	end

  	if msgcontains(msg, 'botas') and focus == cid then
  		selfSay('Vendo leather boots e sandals.')
  		talk_start = os.clock()
  	end
  
  	if msgcontains(msg, 'sandals') and focus == cid then
  		buy(cid,2642,1,10)
  		talk_start = os.clock()
  	end
  
  	if msgcontains(msg, 'leather boots') and focus == cid then
  		buy(cid,2443,1,20)
  		talk_start = os.clock()
  	end
  
  	if msgcontains(msg, 'shields') and focus == cid then
  		selfSay('I sell plate shield, black shield, cooper shield, bone shield and ornamented shield.')
  		talk_start = os.clock()
  	end

  	if msgcontains(msg, 'escudos') and focus == cid then
  		selfSay('Tenho plate shield, black shield, cooper shield, bone shield e ornamented shield.')
  		talk_start = os.clock()
  	end
  
  	if msgcontains(msg, 'plate shield') and focus == cid then
  		buy(cid,2510,1,50)
  		talk_start = os.clock()
  	end
  
  	if msgcontains(msg, 'black shield') and focus == cid then
  		buy(cid,2529,1,70)
  		talk_start = os.clock()
  	end
  
  	if msgcontains(msg, 'cooper shield') and focus == cid then
  		buy(cid,2530,1,120)
  		talk_start = os.clock()
  	end
  
  	if msgcontains(msg, 'bone shield') and focus == cid then
  		buy(cid,2541,1,150)
  		talk_start = os.clock()
  	end
  
  	if msgcontains(msg, 'ornamented shield') and focus == cid then
  		buy(cid,2524,1,200)
  		talk_start = os.clock()
  	end
  
  	if string.find(msg, '(%a*)bye(%a*)') and focus == cid and getDistanceToCreature(cid) < 3 then
  		selfSay('Good bye, ' .. creatureGetName(cid) .. '!')
  		focus = 0
  		talk_start = 0
  	end

  	if string.find(msg, '(%a*)tchau(%a*)') and focus == cid and getDistanceToCreature(cid) < 3 then
  		selfSay('Adeus, ' .. creatureGetName(cid) .. '!')
  		focus = 0
  		talk_start = 0
  	end

  	if string.find(msg, '(%a*)xau(%a*)') and focus == cid and getDistanceToCreature(cid) < 3 then
  		selfSay('Volte sempre, ' .. creatureGetName(cid) .. '!')
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

 