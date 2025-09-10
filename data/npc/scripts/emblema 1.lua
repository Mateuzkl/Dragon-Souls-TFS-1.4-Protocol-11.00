

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
	addon = getPlayerStorageValue(cid,30000)


  	if (msgcontains(msg, 'hi') and (focus == 0)) and getDistanceToCreature(cid) < 4 then
					selfSay('What do you want here? This boat is only for the royal family!')
 					focus = cid
 					talk_start = os.clock()

	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')

  	elseif focus == cid then
		talk_start = os.clock()


		if msgcontains(msg, 'yes') and talk_state == 1 then
			if getPlayerItemCount(cid,2122) >= 1 then
					selfSay('Set the Sails!')
					destination = {x=56, y=431, z=7}
					doTeleportThing(cid, destination)
					doSendMagicEffect(destination, 10)
					doPlayerSay(cid,"Oh God",16)
					talk_state = 0
			else
				selfSay('You are not with the broch!')
			end

		elseif msgcontains(msg, 'royal family') and addon == -1 then
					selfSay('Go bother someone else!')

		elseif msgcontains(msg, 'royal family') and addon == 1 then
				if getPlayerItemCount(cid,2122) >= 1 then
					selfSay('I dont know how did you get the royal family broch, but is my job to take you to the prince, the king\'s son of dagmar. Can we go now?')
					talk_state = 1
				else
					selfSay('Go bother someone else!')
				end

		elseif msgcontains(msg, 'royal family') and addon == 2 then
				if getPlayerItemCount(cid,2122) >= 1 then
					selfSay('You need find Narzan the prince, the king\'s son of dagmar! Can we go now?')
					talk_state = 1
				else
					selfSay('I can\'t go whitout the broch!')
				end

		elseif msgcontains(msg, 'royal family') and addon >= 3 then
					selfSay('now, we just need wait the orders of the queen!')


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
  	if (os.clock() - talk_start) > 30 then
  		if focus > 0 then
  			selfSay('...')
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
