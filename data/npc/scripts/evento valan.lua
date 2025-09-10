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
 		selfSay('Hello ' .. creatureGetName(cid) .. '! I can change you on "valan", What you want here?')
 		focus = cid
 		talk_start = os.clock()

	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')

  	elseif focus == cid then
		talk_start = os.clock()

	if msgcontains(msg, 'valan') then
	if isPremium(cid) then
	if level == 8 then
	if getPlayerMagLevel(cid) == 0 then
		selfSay('Se voce tem certeza disso tudo bem, qual vocacao voce deseja? "Wyzard", "Cleric", "Ranger" ou "Slayer"?')
		talk_state = 1
		else
		selfSay('Sorry, you need magic level 0 to turn a valan!')
  		focus = 0
		talk_state = 0
		end
		else
		selfSay('Sorry, you need level 8 to turn a valan!')
  		focus = 0
		talk_state = 0
		end
		else
		selfSay('Sorry, only premium accounts can turn a valan!')
  		focus = 0
		talk_state = 0
		end

	elseif talk_state == 1 and msgcontains(msg, 'wyzard') then
		doPlayerSendTextMessage(cid,19,"You are now a wyzard!")
  		doSendMagicEffect(getPlayerPosition(cid),12)
		doPlayerSetVocation(cid, 9)
  		focus = 0
		talk_state = 0

	elseif talk_state == 1 and msgcontains(msg, 'cleric') then
		doPlayerSendTextMessage(cid,19,"You are now a cleric!")
  		doSendMagicEffect(getPlayerPosition(cid),12)
		doPlayerSetVocation(cid, 10)
  		focus = 0
		talk_state = 0

	elseif talk_state == 1 and msgcontains(msg, 'ranger') then
		doPlayerSendTextMessage(cid,19,"You are now a ranger!")
  		doSendMagicEffect(getPlayerPosition(cid),12)
		doPlayerSetVocation(cid, 11)
  		focus = 0
		talk_state = 0

	elseif talk_state == 1 and msgcontains(msg, 'slayer') then
		doPlayerSendTextMessage(cid,19,"You are now a slayer!")
  		doSendMagicEffect(getPlayerPosition(cid),12)
		doPlayerSetVocation(cid, 12)
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
