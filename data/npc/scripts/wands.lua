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
  		selfSay('Hello ' .. creatureGetName(cid) .. '! I sell runes, wands and rods.')
  		focus = cid
 		selfLook(cid)
  		talk_start = os.clock()
	end

   	if ((string.find(msg, '(%a*)oi(%a*)')) and (focus == 0)) and getDistanceToCreature(cid) < 4 then
  		selfSay('Ola ' .. creatureGetName(cid) .. '! Vendo runas , wands e rods.')
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


		if msgcontains(msg, 'runes') and focus == cid then
			selfSay('I sell hmms (25gps), uhs (175gps), gfbs (90gps), explosions (85gps), sds (325gps) and blank runes (50gps). To buy more runes say "10 uh" or "100 sd".')
  		talk_start = os.clock()
  	end
		if msgcontains(msg, 'runes') and focus == cid then
			selfSay('Eu vendo hmms (25gps), uhs (175gps), gfbs (90gps), explosions (85gps), sds (325gps) e blank runes (50gps). Para comprar mais diga "10 uh" ou "100 sd".')
  		talk_start = os.clock()
  	end

		if msgcontains(msg, 'wands') and focus == cid then
			selfSay('I sell wand of inferno (15k), plague (5k), cosmic energy (10k), vortex (500gp) and dragonbreath (1k).')
  		talk_start = os.clock()
  	end
		if msgcontains(msg, 'rods') and focus == cid then
			selfSay('I sell quagmire (10k), snakebite (500gp), tempest (15k), volcanic (5k) and moonlight rod (1k).')
  		talk_start = os.clock()
  	end

		if msgcontains(msg, 'inferno') and focus == cid then
			buy(cid,2187,1,15000)
  		talk_start = os.clock()
  	end
		if msgcontains(msg, 'plague') and focus == cid then
			buy(cid,2188,1,5000)
  		talk_start = os.clock()
  	end
		if msgcontains(msg, 'cosmic energy') and focus == cid then
			buy(cid,2189,1,10000)
  		talk_start = os.clock()
  	end
		if msgcontains(msg, 'vortex') and focus == cid then
			buy(cid,2190,1,500)
  		talk_start = os.clock()
  	end
		if msgcontains(msg, 'dragonbreath') and focus == cid then
			buy(cid,2191,1,1000)
  		talk_start = os.clock()
  	end

		if msgcontains(msg, 'quagmire') and focus == cid then
			buy(cid,2181,1,10000)
  		talk_start = os.clock()
  	end
		if msgcontains(msg, 'snakebite') and focus == cid then
			buy(cid,2182,1,500)
  		talk_start = os.clock()
  	end
		if msgcontains(msg, 'tempest') and focus == cid then
			buy(cid,2183,1,15000)
  		talk_start = os.clock()
  	end
		if msgcontains(msg, 'volcanic') and focus == cid then
			buy(cid,2185,1,5000)
  		talk_start = os.clock()
  	end
		if msgcontains(msg, 'moonlight') and focus == cid then
			buy(cid,2186,1,1000)
  		talk_start = os.clock()
  	end

		if msgcontains(msg, '100 hmm') and focus == cid then
			buy(cid,2311,100,2500)
  		talk_start = os.clock()
  	end
		if msgcontains(msg, '10 hmm') and focus == cid then
			buy(cid,2311,10,250)
  		talk_start = os.clock()
  	end
		if msgcontains(msg, 'hmm') and focus == cid then
			buy(cid,2311,5,25)
  		talk_start = os.clock()
  	end
		if msgcontains(msg, '100 uh') and focus == cid then
			buy(cid,2273,100,17500)
  		talk_start = os.clock()
  	end
		if msgcontains(msg, '10 uh') and focus == cid then
			buy(cid,2273,10,1750)
  		talk_start = os.clock()
  	end
		if msgcontains(msg, 'uh') and focus == cid then
			buy(cid,2273,1,175)
  		talk_start = os.clock()
  	end

		if msgcontains(msg, '100 gfb') and focus == cid then
			buy(cid,2304,100,9000)
  		talk_start = os.clock()
  	end
		if msgcontains(msg, '10 gfb') and focus == cid then
			buy(cid,2304,10,900)
  		talk_start = os.clock()
  	end
		if msgcontains(msg, 'gfb') and focus == cid then
			buy(cid,2304,3,90)
  		talk_start = os.clock()
  	end
		if msgcontains(msg, '100 explosion') and focus == cid then
			buy(cid,2313,100,8500)
  		talk_start = os.clock()
  	end
		if msgcontains(msg, '10 explosion') and focus == cid then
			buy(cid,2313,10,850)
  		talk_start = os.clock()
  	end
		if msgcontains(msg, 'explosion') and focus == cid then
			buy(cid,2313,3,85)
  		talk_start = os.clock()
  	end
		if msgcontains(msg, '100 sd') and focus == cid then
			buy(cid,2268,100,32500)
  		talk_start = os.clock()
  	end
		if msgcontains(msg, '10 sd') and focus == cid then
			buy(cid,2268,10,3250)
  		talk_start = os.clock()
  	end
		if msgcontains(msg, 'sd') and focus == cid then
			buy(cid,2268,1,325)
  		talk_start = os.clock()
  	end

		if msgcontains(msg, 'blank') and focus == cid then
			buy(cid,2260,1,50)
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
 