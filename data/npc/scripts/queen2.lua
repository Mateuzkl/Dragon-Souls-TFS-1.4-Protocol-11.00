local focus = 0
local talk_start = 0
local target = 0
local days = 0

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
 		selfSay('Hello ' .. creatureGetName(cid) .. ',Help me!')
 		focus = cid
 		talk_start = os.clock()

	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')

  	elseif focus == cid then
		talk_start = os.clock()

		if msgcontains(msg, 'no') then
			selfSay('Help me!')
			talk_state = 0

		elseif talk_state == 0 then
			if msgcontains(msg, 'yes') then
 					queststatus = getPlayerStorageValue(cid,5928)
 					if queststatus == -1 then
  					doPlayerAddItem(cid,5958,1)
					selfSay('fale com ela sobre a Sarina.')
					doSendMagicEffect(getPlayerPosition(cid),14)
					selfSay('Entregue para a Rainha com urgencia!')
					setPlayerStorageValue(cid,5928,1)
				else
					selfSay('Desculpe, mas você ja fez está quest..')
				end
			end
			talk_state = 0

  		elseif msgcontains(msg, 'hi')  and getDistanceToCreature(cid) < 4 then
 		selfSay('' .. creatureGetName(cid) .. ',Help me please!')

  		elseif msgcontains(msg, 'bye')  and getDistanceToCreature(cid) < 4 then
  			selfSay('Good bye, ' .. creatureGetName(cid) .. '!')
  			focus = 0
  			talk_start = 0
  		end
  	end
end

function onCreatureChangeOutfit(creature)

end


function onThink()
	doNpcSetCreatureFocus(focus)
  	if (os.clock() - talk_start) > 10 then
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
