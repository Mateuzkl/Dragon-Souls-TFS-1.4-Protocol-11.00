

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
			addon = getPlayerStorageValue(cid,30000)
				if addon == 3 then
					selfSay('Did you found Narzan? Lets go now?')
					talk_state = 1
 					focus = cid
 					talk_start = os.clock()
				else
					selfSay('We cant go before we have sure that Narzan is alive!')
 					focus = cid
 					talk_start = os.clock()
				end
 		focus = cid
 		talk_start = os.clock()

	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')

	elseif msgcontains(msg, 'oh god') and (focus == 0) and getDistanceToCreature(cid) < 4 then
          selfSay('Oh! What is going on? Find Narzan, i am going to find help!')
		setPlayerStorageValue(cid,30000,2)
  		doSendMagicEffect(getPlayerPosition(cid),12)

  	elseif focus == cid then
		talk_start = os.clock()


	if msgcontains(msg, 'yes') and talk_state == 1 then
		selfSay('As you wish!')
		destination = {x=31, y=298, z=7}
		doTeleportThing(cid, destination)
		doSendMagicEffect(destination, 10)
  		focus = 0
		talk_state = 0



  		elseif msgcontains(msg, 'bye')  and getDistanceToCreature(cid) < 4 then
  			selfSay('Good luck, ' .. creatureGetName(cid) .. '!')
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
  			selfSay('Go go, fast!')
  		end
  			focus = 0
  	end
 	if focus ~= 0 then
 		if getDistanceToCreature(focus) > 5 then
 			selfSay('Go go, fast!')
 			focus = 0
 		end
 	end
end
