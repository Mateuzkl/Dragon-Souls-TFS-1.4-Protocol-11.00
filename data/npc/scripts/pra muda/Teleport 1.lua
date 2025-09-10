focus = 0
talk_start = 0
target = 0
talk_state = 0
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
 		selfSay('Who invited you to enter on temple of Zeus, mortal?')
 		focus = cid
 		selfLook(cid)
 		talk_start = os.clock()
 	end

 	if ((string.find(msg, '(%a*)oi(%a*)')) and (focus == 0)) and getDistanceToCreature(cid) < 3 then
 		selfSay('Quem convidou você para entrar no templo de Zeus, méro mortal?')
 		focus = cid
 		selfLook(cid)
 		talk_start = os.clock()
 	end

	if string.find(msg, '(%a*)hi(%a*)') and (focus ~= cid) and getDistanceToCreature(cid) < 3 then
 		selfSay('Wait your turn mortal.')
 	end
	if string.find(msg, '(%a*)oi(%a*)') and (focus ~= cid) and getDistanceToCreature(cid) < 3 then
 		selfSay('Espere sua vez mortal.')
 	end

 	if msgcontains(msg, 'zeus') and focus == cid then
			selfSay('Then go talk whit him!')
			selfSay('/send ' .. creatureGetName(cid) .. ', 461 254 13')
			focus = 0
			talk_start = 0
		end

 	if string.find(msg, '(%a*)bye(%a*)') and focus == cid and getDistanceToCreature(cid) < 3 then
 		selfSay('Get out of my front mortal!')
 		focus = 0
 		talk_start = 0
 	end
 	if string.find(msg, '(%a*)tchau(%a*)') and focus == cid and getDistanceToCreature(cid) < 3 then
 		selfSay('Saia da minha frente mortal!')
 		focus = 0
 		talk_start = 0
 	end
end


function onCreatureChangeOutfit(creature)

end


 function onThink() 
 if (os.clock() - talk_start) > 30 then 
 if focus > 0 then 
 selfSay('Get out!') 
 talkcount = 0
 end 
 focus = 0 
 itemid = 0
 talk_start = 0 
 end 
  	if focus ~= 0 then
  		if getDistanceToCreature(focus) > 5 then
  			selfSay('Get out!')
  			focus = 0
  		end
	end
end
 