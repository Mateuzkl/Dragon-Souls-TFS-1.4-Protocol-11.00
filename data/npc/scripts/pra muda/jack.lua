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
  		selfSay('Hello, ' .. creatureGetName(cid) .. '! I sell beer and wine for 10 gp.')
  		focus = cid
 		selfLook(cid)
  		talk_start = os.clock()
  	end
  	if ((string.find(msg, '(%a*)oi(%a*)')) and (focus == 0)) and getDistanceToCreature(cid) < 3 then
  		selfSay('Ola, ' .. creatureGetName(cid) .. '! Vendo beer e wine por 10gp.')
  		focus = cid
 		selfLook(cid)
  		talk_start = os.clock()
  	end
  
  	if string.find(msg, '(%a*)hi(%a*)') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Leave us alone, ' .. creatureGetName(cid) .. '!')
  	end
  	if string.find(msg, '(%a*)hi(%a*)') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Nos deixe ' .. creatureGetName(cid) .. '!')
  	end

  	if msgcontains(msg, 'buy beer') and focus == cid then
  		buy(cid,2006,3,10)
  		talk_start = os.clock()
  	end
 
  	if msgcontains(msg, 'buy wine') and focus == cid then
  		buy(cid,2006,15,10)
  		talk_start = os.clock()
  	end

        if msgcontains(msg, 'quest') and focus == cid then
  		selfSay('Explore Dungeon Caves on carlin a tired old man told me anything about a great teasure and many quests on this city')
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
 
