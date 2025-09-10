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
 		selfSay('Hello ' .. creatureGetName(cid) .. '! I can take you to Femur Hills (300gps), Edron (400gps) or Tombstone (200gps). Where do you want to go?')
 		focus = cid
 		selfLook(cid)
 		talk_start = os.clock()
 	end

 	if ((string.find(msg, '(%a*)oi(%a*)')) and (focus == 0)) and getDistanceToCreature(cid) < 3 then
 		selfSay('Hola ' .. creatureGetName(cid) .. '! Puesso levar-te a Femur Hills (300gps), Edron (400gps) ou Tombstone (200gps). Onde gostaria de ir?')
 		focus = cid
 		selfLook(cid)
 		talk_start = os.clock()
 	end

	if string.find(msg, '(%a*)hi(%a*)') and (focus ~= cid) and getDistanceToCreature(cid) < 3 then
 		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')
 	end
	if string.find(msg, '(%a*)oi(%a*)') and (focus ~= cid) and getDistanceToCreature(cid) < 3 then
 		selfSay('Desculpe, ' .. creatureGetName(cid) .. '! Hablo contigo em um minuto.')
 	end

 	if msgcontains(msg, 'tombstone') and focus == cid then
 		if pay(cid,200) then
			selfSay('Yhaa!')
			selfSay('/send ' .. creatureGetName(cid) .. ', 219 92 7')
			focus = 0
			talk_start = 0
		else
				selfSay('Sorry, you don\'t have enough money.')
				talk_start = os.clock()
			end
		end

 	if msgcontains(msg, 'tomb') and focus == cid then
 		if pay(cid,200) then
			selfSay('Yhaa!')
			selfSay('/send ' .. creatureGetName(cid) .. ', 219 92 7')
			focus = 0
			talk_start = 0
		else
				selfSay('Sorry, you don\'t have enough money.')
				talk_start = os.clock()
			end
		end

 	if msgcontains(msg, 'hills') and focus == cid then
 		if pay(cid,300) then
			selfSay('Yhaa!')
			selfSay('/send ' .. creatureGetName(cid) .. ', 307 378 4')
			focus = 0
			talk_start = 0
		else
				selfSay('Sorry, you don\'t have enough money.')
				talk_start = os.clock()
			end
		end

	if msgcontains(msg, 'femur hills') and focus == cid then
 		if pay(cid,300) then
			selfSay('Yhaa!')
			selfSay('/send ' .. creatureGetName(cid) .. ', 307 378 4')
			focus = 0
			talk_start = 0
		else
				selfSay('Sorry, you don\'t have enough money.')
				talk_start = os.clock()
			end
		end

 	if msgcontains(msg, 'edron') and focus == cid then
 		if pay(cid,400) then
			selfSay('Yhaa!')
			selfSay('/send ' .. creatureGetName(cid) .. ', 752 816 3')
			focus = 0
			talk_start = 0
		else
				selfSay('Sorry, you don\'t have enough money.')
				talk_start = os.clock()
			end
		end

 	if string.find(msg, '(%a*)bye(%a*)') and focus == cid and getDistanceToCreature(cid) < 3 then
 		selfSay('Good bye, ' .. creatureGetName(cid) .. '!')
 		focus = 0
 		talk_start = 0
 	end
 	if string.find(msg, '(%a*)tchau(%a*)') and focus == cid and getDistanceToCreature(cid) < 3 then
 		selfSay('Adios, ' .. creatureGetName(cid) .. '!')
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
  			selfSay('Adeus.')
  			focus = 0
  		end
	end
end
 