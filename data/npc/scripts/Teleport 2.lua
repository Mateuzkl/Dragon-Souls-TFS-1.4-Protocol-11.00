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

  	if (msgcontains(msg, 'hi') and (focus == 0)) and getDistanceToCreature(cid) < 4 then
 		selfSay('Hallo, kennen Sie Gespräch Deutschland?')
 		selfLook(cid)
		focus = cid
 		talk_start = os.clock()
	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Traurig, spreche ich mit Ihnen in einer Minute.')  	elseif focus == cid then
		talk_start = os.clock()

	if msgcontains(msg, 'ja') then
			selfSay('Oh! kühlen, wenn Sie Sagen im bereit ich Sie zum folgenden Raum schicken.')
			talk_state = 1

		elseif talk_state == 1 then
			if msgcontains(msg, 'im bereit') then
					selfSay('Bis später!')
					selfSay('/send ' .. creatureGetName(cid) .. ', 439 244 14')
 			end
			talk_state = 0

  		elseif msgcontains(msg, 'wiedersehen')  and getDistanceToCreature(cid) < 4 then
  			selfSay('Auf Wiedersehen! ')
  			focus = 0
  			talk_start = 0
  		end
  	end
end


function onCreatureChangeOutfit(creature)

end


function onThink()
  	if (os.clock() - talk_start) > 30 then
  		if focus > 0 then
  			selfSay('Auf Wiedersehen!')
  		end
  			focus = 0
  	end
	if focus ~= 0 then
 		if getDistanceToCreature(focus) > 5 then
 			selfSay('Auf Wiedersehen!')
 			focus = 0
 		end
 	end
end
