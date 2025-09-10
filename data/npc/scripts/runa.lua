focus = 0
  talk_start = 0
  target = 0
  following = false
  attacking = false
  ox = 135
  oy = 54
  oz = 7
  max = 20
  function onThingMove(creature, thing, oldpos, oldstackpos)
 
  end
 
 
  function onCreatureAppear(creature)
 
  end
 
 
  function onCreatureDisappear(cid, pos)
  	if focus == cid then
          selfSay('Thau-thau.')
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
  		selfSay('Hello ' .. creatureGetName(cid) .. '! I sell all runes , just say their names.')
  		focus = cid
 		selfLook(cid)
  		talk_start = os.clock()
  	end

  	if ((string.find(msg, '(%a*)oi(%a*)')) and (focus == 0)) and getDistanceToCreature(cid) < 4 then
  		selfSay('Ola ' .. creatureGetName(cid) .. '! Eu vendo todas as runas basta vc saber o nome delas.')
  		focus = cid
 		selfLook(cid)
  		talk_start = os.clock()
  	end
 
  	if string.find(msg, '(%a*)hi(%a*)') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')
  	end

  	if string.find(msg, '(%a*)oi(%a*)') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Desculpe, ' .. creatureGetName(cid) .. '! Ja falo com voce.')
  	end
 
  	if msgcontains(msg, 'light magic missile') and focus == cid then
  		buy(cid,2287,1,200)
  		talk_start = os.clock()
  	end
 
  	if msgcontains(msg, 'poison field') and focus == cid then
  		buy(cid,2285,1,300)
  		talk_start = os.clock()
  	end
 
  	if msgcontains(msg, 'fire field') and focus == cid then
  		buy(cid,2301,1,500)
  		talk_start = os.clock()
  	end
 
  	if msgcontains(msg, 'heavy magic missile') and focus == cid then
  		buy(cid,2311,1,600)
  		talk_start = os.clock()
  	end
 
  	if msgcontains(msg, 'intense healing rune') and focus == cid then
  		buy(cid,2265,1,600)
  		talk_start = os.clock()
  	end
 
  	if msgcontains(msg, 'antidote rune') and focus == cid then
  		buy(cid,2266,1,600)
  		talk_start = os.clock()
  	end
 
  	if msgcontains(msg, 'fireball') and focus == cid then
  		buy(cid,2302,1,800)
  		talk_start = os.clock()
  	end
 
  	if msgcontains(msg, 'energy field') and focus == cid then
  		buy(cid,2277,1,700)
  		talk_start = os.clock()
  	end
 
  	if msgcontains(msg, 'destroy field') and focus == cid then
  		buy(cid,2261,1,350)
  		talk_start = os.clock()
 
  	end 	
 	
 	if msgcontains(msg, 'fireball') and focus == cid then
  		buy(cid,2302,1,800)
  		talk_start = os.clock()
  	end
 
  	if msgcontains(msg, 'envenenom') and focus == cid then
  		buy(cid,2292,1,1000)
  		talk_start = os.clock()
  	end
 
  	if msgcontains(msg, 'animate dead') and focus == cid then
  		buy(cid,2316,1,1200)
  		talk_start = os.clock()
  	end
 
 	if msgcontains(msg, 'desintegrate') and focus == cid then
  		buy(cid,2310,1,900)
  		talk_start = os.clock()
  	end
 
  	if msgcontains(msg, 'poison bomb') and focus == cid then
  		buy(cid,2286,1,1000)
  		talk_start = os.clock()
  	end
 
  	if msgcontains(msg, 'great fireball') and focus == cid then
  		buy(cid,2304,1,1200)
  		talk_start = os.clock()
  	end
 
 	if msgcontains(msg, 'fire bomb') and focus == cid then
  		buy(cid,2305,1,1500)
  		talk_start = os.clock()
  	end
 
  	if msgcontains(msg, 'convince creature') and focus == cid then
  		buy(cid,2290,1,1300)
  		talk_start = os.clock()
  	end
 
  	if msgcontains(msg, 'poison wall') and focus == cid then
  		buy(cid,2289,1,1600)
  		talk_start = os.clock()
  	end
 
 	if msgcontains(msg, 'ultimate healing rune') and focus == cid then
  		buy(cid,2273,1,1500)
  		talk_start = os.clock()
  	end
 
  	if msgcontains(msg, 'chameleon') and focus == cid then
  		buy(cid,2291,1,1800)
  		talk_start = os.clock()
  	end
 
  	if msgcontains(msg, 'explosion') and focus == cid then
  		buy(cid,2313,1,1800)
  		talk_start = os.clock()
  	end
 
 	if msgcontains(msg, 'soul fire') and focus == cid then
  		buy(cid,2308,1,1800)
  		talk_start = os.clock()
  	end
 
  	if msgcontains(msg, 'fire wall') and focus == cid then
  		buy(cid,2303,1,2000)
  		talk_start = os.clock()
  	end
 
  	if msgcontains(msg, 'magic wall') and focus == cid then
  		buy(cid,2293,1,2100)
  		talk_start = os.clock()
  	end
 
 	if msgcontains(msg, 'energy bomb') and focus == cid then
  		buy(cid,2262,1,2300)
  		talk_start = os.clock()
  	end
 
  	if msgcontains(msg, 'energy wall') and focus == cid then
  		buy(cid,2279,1,2500)
  		talk_start = os.clock()
  	end
 
  	if msgcontains(msg, 'sudden death') and focus == cid then
  		buy(cid,2268,1,3000)
  		talk_start = os.clock()
  	end
 
  	if msgcontains(msg, 'paralyze') and focus == cid then
  		buy(cid,2278,1,19000)
  		talk_start = os.clock()
  	end
 
  	if string.find(msg, '(%a*)bye(%a*)') and focus == cid and getDistanceToCreature(cid) < 4 then
  		selfSay('Goodbye, ' .. creatureGetName(cid) .. '!')
  		focus = 0
  		talk_start = 0
  	end
  	if string.find(msg, '(%a*)tchau(%a*)') and focus == cid and getDistanceToCreature(cid) < 4 then
  		selfSay('Thau, ' .. creatureGetName(cid) .. '!')
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

 
