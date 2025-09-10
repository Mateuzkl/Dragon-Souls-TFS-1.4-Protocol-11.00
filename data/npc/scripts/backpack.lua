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
 		selfSay('Hello, ' .. creatureGetName(cid) .. '! I sell blue bp (50gps), red bp (50gps), yellow bp (50gps), tiquanda bp (50gps), green bp (50gps) and gray bp (50gps). I buy vials (10gps).')
 		selfLook(cid)
		focus = cid
 		talk_start = os.clock()

 	elseif string.find(msg, '(%a*)hi(%a*)') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
 		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')

 	elseif msgcontains(msg, 'blue bp') and focus == cid then
 		buy(cid,2807,1,50)
 		talk_start = os.clock()

 	elseif msgcontains(msg, 'red bp') and focus == cid then
 		buy(cid,2805,1,50)
 		talk_start = os.clock()

 	elseif msgcontains(msg, 'yellow bp') and focus == cid then
 		buy(cid,2809,1,50)
 		talk_start = os.clock()

 	elseif msgcontains(msg, 'tiquanda') and focus == cid then

 		buy(cid,2810,1,50)
 		talk_start = os.clock()

 	elseif msgcontains(msg, 'green') and focus == cid then

 		buy(cid,2803,1,50)
 		talk_start = os.clock()

 	elseif msgcontains(msg, 'gray bp') and focus == cid then
 		buy(cid,2808,1,50)
 		talk_start = os.clock()

 	elseif string.find(msg, '(%a*)bye(%a*)') and focus == cid and getDistanceToCreature(cid) < 4 then
 		selfSay('Good bye, ' .. creatureGetName(cid) .. '!')
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

