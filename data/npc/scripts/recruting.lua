local focus = 0
local talk_start = 0
local target = 0

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
  	level = getPlayerLevel(cid)

  	if (msgcontains(msg, 'hi') and (focus == 0)) and getDistanceToCreature(cid) < 4 then
 		selfSay('Hello ' .. creatureGetName(cid) .. '! When think you was ready to try the "test", just say to me.')
 		focus = cid
 		talk_start = os.clock()

	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')

  	elseif focus == cid then
		talk_start = os.clock()

	if msgcontains(msg, 'test') then
	if level >= 8 then
	if getPlayerItemCount(cid,2160) == 0 then
	if getPlayerItemCount(cid,13685) == 0 then
	if getPlayerItemCount(cid,2152) < 101 then
		selfSay('Levarei você para uma sala onde possa escolher o seu teste para sua vocação, terá que provar que esta pronto! Acha que está realmente pronto?')
		talk_state = 1
		else
		selfSay('Você só pode ir para o teste com no máximo 10k!')
  		focus = 0
		talk_state = 0
		end
		else
		selfSay('Você só pode ir para o teste com no máximo 10k!')
  		focus = 0
		talk_state = 0
		end
		else
		selfSay('Você só pode ir para o teste com no máximo 10k!')
  		focus = 0
		talk_state = 0
		end
		else
		selfSay('Sorry, you need level 8 to stay ready, go train children!')
  		focus = 0
		talk_state = 0
		end

	elseif talk_state == 1 and msgcontains(msg, 'yes') then
		selfSay('Well well, if you thing, good luck!')
		travel(cid, 270, 199, 8)
  		focus = 0
		talk_state = 0

	elseif talk_state == 1 and msgcontains(msg, 'no') then
		selfSay('So back here when you are ready!')
  		focus = 0
		talk_state = 0

  	elseif msgcontains(msg, 'bye')  and getDistanceToCreature(cid) < 4 then
  		selfSay('Good bye, back here when you ready ' .. creatureGetName(cid) .. '!')
  		focus = 0
  		talk_start = 0
  		end
  	end
end


function onCreatureChangeOutfit(creature)

end


function onThink()
	doNpcSetCreatureFocus(focus)
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
