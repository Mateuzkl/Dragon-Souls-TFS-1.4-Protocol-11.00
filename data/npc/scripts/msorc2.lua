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
	book = getPlayerStorageValue(cid,1002)

  	if (msgcontains(msg, 'hi') and (focus == 0)) and getDistanceToCreature(cid) < 2 then
	if book == -1 then
 		selfSay('Why so late ' .. creatureGetName(cid) .. '? whatever, what you bring to me? please say a "book", i dont have time to lost!')
 		focus = cid
 		talk_start = os.clock()
else
		selfSay('Go to Calona on Carlin, and say you are a "novice", her will help you mortal, so... You are ready to become a Sorcerer?')
 		focus = cid
 		talk_start = os.clock()
end

	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 2 then
  		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')

  	elseif focus == cid then
		talk_start = os.clock()

	if msgcontains(msg, 'book') then
	if getPlayerItemCount(cid,1973) >= 1 then
		doPlayerTakeItem(cid,1973,1)
 		selfSay('Hmm... You do a nice work for an mortal.')
		selfSay('Go to Calona on Carlin, and say you are a "novice", her will help you mortal, so... You are ready to become a Sorcerer?')
		setPlayerStorageValue(cid,1002,1)
		talk_state = 0
		else
 		selfSay('I dont have time for that, go get this book fast!')
  		focus = 0
		talk_state = 0
		end


	elseif msgcontains(msg, 'yes') and getPlayerVocation(cid) == 0 then
	if book == -1 then
		selfSay('Yes?! Yes what?!')
		talk_state = 0
		else
		selfSay('Good luck mortal!')
		doPlayerSendTextMessage(cid,19,"You are now a Sorcerer!")
  		doSendMagicEffect(getPlayerPosition(cid),12)
		doPlayerAddHealth(cid,185)
		doPlayerSetVocation(cid, 1)
		doPlayerSetTown(cid,2)
		travel(cid, 121, 311, 7)
		setPlayerStorageValue(cid,1002,2)
  		focus = 0
		talk_state = 0
		end
	
	elseif msgcontains(msg, 'no') then
		selfSay('HA! You are joking me!')
  		focus = 0
		talk_state = 0


  	elseif msgcontains(msg, 'bye')  and getDistanceToCreature(cid) < 2 then
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
  	if (os.clock() - talk_start) > 120 then
  		if focus > 0 then
  			selfSay('Next Please...')
  		end
  			focus = 0
  	end
 	if focus ~= 0 then
 		if getDistanceToCreature(focus) > 2 then
 			selfSay('Good bye then.')
 			focus = 0
 		end
 	end
end
