

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
			addon = getPlayerStorageValue(cid,30003)
				if addon == -1 then
					selfSay('Huh? Can you see me? Nobody can see me! take this ring boy, it will help you get out of here, are you lost too?')
					doPlayerGiveItem(cid, 2165, 1, 5)
     			doPlayerSendTextMessage(cid,22,"You receive an stealth ring.")
  			doSendMagicEffect(getPlayerPosition(cid),12)
					setPlayerStorageValue(cid,30003,1)
					talk_state = 1
 					focus = cid
 					talk_start = os.clock()
				else
					selfSay('Hey, you again? Dont find any friend? I hidden the key inside a drawer, but you have to break it to get the key, some kind of heavy hammer should break the drawer.')
  					focus = 0
  					talk_start = 0
				end

 		focus = cid
 		talk_start = os.clock()

	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')

  	elseif focus == cid then
		talk_start = os.clock()


		if msgcontains(msg, 'yes') and talk_state == 1 then
				addon = getPlayerStorageValue(cid,30003)
				if addon == 1 then
						selfSay('Damn! I got a key from the guards, but i hidden it before being busted, dont you have a friend who can help us get out of here?')
						talk_state = 2
						else
						selfSay('What you want?!')
						talk_state = 0
					end


		elseif msgcontains(msg, 'yes') and talk_state == 2 then
				addon = getPlayerStorageValue(cid,30003)
					if addon == 1 then
						selfSay('Great! I hidden the key inside a drawer, but you have to break it to get the key, some kind of heavy hammer should break the drawer.')
						setPlayerStorageValue(cid,30003,2)
						else
						selfSay('Yes what?!')
						talk_state = 0
					end



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
  			selfSay('Bye...')
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
