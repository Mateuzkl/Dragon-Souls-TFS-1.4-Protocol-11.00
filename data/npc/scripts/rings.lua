--ox = 44
 --oy = 5
 --oz = 6

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
         selfLook(cid)
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
 		selfSay('Hello ' .. creatureGetName(cid) .. '! I buy rings of every type.')
 		focus = cid
 		talk_start = os.clock()
	elseif string.find(msg, '(%a*)hi(%a*)') and (focus ~= cid) and getDistanceToCreature(cid) < 3 then
 		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')
  	        elseif focus == cid then
		talk_start = os.clock() 

if ((string.find(msg, '(%a*)oi(%a*)')) and (focus == 0)) and getDistanceToCreature(cid) < 3 then
 		selfSay('Ola ' .. creatureGetName(cid) .. '! Eu compro todos os tipos de aneis.')
 		focus = cid
 		talk_start = os.clock()
	elseif string.find(msg, '(%a*)hi(%a*)') and (focus ~= cid) and getDistanceToCreature(cid) < 3 then
 		selfSay('Desculpe, ' .. creatureGetName(cid) .. '! Eu falo com você em um minuto.')
  	        elseif focus == cid then
		talk_start = os.clock()  
		
                if msgcontains(msg, 'axe ring') then
 			sell(cid,3030,1,250)
 		elseif msgcontains(msg, 'club ring') then
 			sell(cid,3031,1,250)
 		elseif msgcontains(msg, 'crystal ring') then
 			sell(cid,2945,1,300)
 		elseif msgcontains(msg, 'dwarven ring') then
 			sell(cid,3035,1,200)
 		elseif msgcontains(msg, 'energy ring') then
 			sell(cid,2989,1,1000)
 		elseif msgcontains(msg, 'golden ring') then
 			sell(cid,3001,1,1500)
		elseif msgcontains(msg, 'life ring') then
 			sell(cid,2990,1,100)
 		elseif msgcontains(msg, 'might ring') then
 			sell(cid,2986,1,1000)
		elseif msgcontains(msg, 'power ring') then
 			sell(cid,2988,1,500)
		elseif msgcontains(msg, 'ring of healing') then
 			sell(cid,3036,1,500)
		elseif msgcontains(msg, 'ring of the skies') then
 			sell(cid,2944,1,5000)
		elseif msgcontains(msg, 'stealth ring') then
 			sell(cid,2987,1,500)
		elseif msgcontains(msg, 'sword ring') then
 			sell(cid,3029,1,250)
		elseif msgcontains(msg, 'time ring') then
 			sell(cid,2991,1,100)
		elseif msgcontains(msg, 'wedding ring') then
 			sell(cid,2942,1,200)
 		elseif msgcontains(msg, 'rings') then
 			selfSay('I buy axe (250gp), club (250gp), crystal (300gp), dwarven (200gp), energy (1k), golden (1,5k) life (100gp), might (1k), power (500gp), of healing (500gp), of skies (5k), stealth (500gp), sword (250gp), time (100gp), wedding (200gp).')

 		elseif string.find(msg, '(%a*)bye(%a*)')  and getDistanceToCreature(cid) < 3 then
 			selfSay('Good bye, ' .. creatureGetName(cid) .. '!')
 			focus = 0
 			talk_start = 0
 		end
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
 