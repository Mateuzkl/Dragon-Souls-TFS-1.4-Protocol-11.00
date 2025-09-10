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
 		selfSay('On right time ' .. creatureGetName(cid) .. '. What you bring to me? "100 blueberry"?')
 		focus = cid
 		talk_start = os.clock()
else
		selfSay('Go to Calona on Carlin, and say you are a "novice", her will help you mortal, so... You are ready to become a Druid?')
 		focus = cid
 		talk_start = os.clock()
end

	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 2 then
  		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')

  	elseif focus == cid then
		talk_start = os.clock()

	if msgcontains(msg, '100 blueberry') then
	if getPlayerItemCount(cid,2677) > 99 then
		doPlayerTakeItem(cid,2677,100)
 		selfSay('Excelent job!')
		selfSay('Go to Calona on Carlin, and say you are a "novice", her will help you mortal, so... You are ready to become a Druid?')
		setPlayerStorageValue(cid,1002,1)
		talk_state = 0
		else
 		selfSay('Be patient, i just need 100 blueberry, get for me.')
  		focus = 0
		talk_state = 0
		end

	elseif getPlayerVocation(cid) == 0 then
	if msgcontains(msg, 'yes') then
	if book == -1 then
		selfSay('Yes? I dont undertand!')
		talk_state = 0
		else
		selfSay('Good luck novice Druid!')
		doPlayerSendTextMessage(cid,19,"You are now a Druid!")
  		doSendMagicEffect(getPlayerPosition(cid),12)
		doPlayerAddHealth(cid,185)
		doPlayerSetVocation(cid, 2)
		doPlayerSetTown(cid,2)
		setPlayerStorageValue(cid,1002,2)
		travel(cid, 121, 311, 7)
  		focus = 0
		talk_state = 0
		end
		else
		end
	
	elseif msgcontains(msg, 'no') then
		selfSay('Ok, all on your time.')
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
