local focus = 0
local talk_start = 0
local target = 0
local following = false
local attacking = false

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

  	if (msgcontains(msg, 'hi') and (focus == 0)) and getDistanceToCreature(cid) < 5 then
		if isPremium(cid) then
			selfSay('Hello ' .. creatureGetName(cid) .. '! wanna change some thing today?')
			focus = cid
			talk_start = os.clock()
		else
			selfSay('Sorry, only premium players can travel.')
			focus = 0
			talk_start = 0
		end
  	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 5 then
  		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')

  	elseif focus == cid then
		talk_start = os.clock()

		if msgcontains(msg, 'bramum') then
			if getPlayerLevel(cid) > 99 or getPlayerLevel(cid) < 8 then
				selfSay('You must have a minimum level 8 is maximum 99...')
				talk_state = 0
			else
				selfSay('Do you wish to travel to bramum for 500 gold coins?')
				talk_state = 1
			end

		elseif msgcontains(msg, 'canudis') then
			if getPlayerLevel(cid) > 199 or getPlayerLevel(cid) < 100 then
				selfSay('You must have a minimum level 100 is maximum 199...')
				talk_state = 0
			else
				selfSay('Do you wish to travel to canudis for 1000 gold coins?')
				talk_state = 2
			end

		elseif msgcontains(msg, 'morgun') then
			if getPlayerLevel(cid) > 299 or getPlayerLevel(cid) < 200 then
				selfSay('You must have a minimum level 200 is maximum 299...')
				talk_state = 0
			else
				selfSay('Do you wish to travel to morgun for 2500 gold coins?')
				talk_state = 3
			end

		elseif msgcontains(msg, 'mordor') then
			if getPlayerVocation(cid) < 9 or getPlayerVocation(cid) > 17 then
				selfSay('Sorry Only Valan\'s!')
				talk_state = 0
			else
				selfSay('Do you wish to travel to mordor for 5000 gold coins?')
				talk_state = 4
			end

		elseif msgcontains(msg, 'tanoris') then
			if getPlayerVocation(cid) < 13 or getPlayerVocation(cid) > 16 then
				selfSay('Sorry Only God\'s!')
				talk_state = 0
			else
				selfSay('Do you wish to travel to tanoris for 100 Dsp\'s?')
				talk_state = 5
			end	
		
		elseif talk_state == 1 then
			if msgcontains(msg, 'yes') then
				if pay(cid,500) then
				travel(cid, 793, 2058, 6)
				selfSay('How rude!')
				else
					selfSay('Sorry, you don\'t have enough money.')
				end
 			end
			talk_state = 0

		elseif talk_state == 2 then
			if msgcontains(msg, 'yes') then
				if pay(cid,1000) then
				travel(cid, 752, 1932, 6)
				selfSay('How rude!')
				else
					selfSay('Sorry, you don\'t have enough money.')
				end
 			end
			talk_state = 0

		elseif talk_state == 3 then
			if msgcontains(msg, 'yes') then
				if pay(cid,2500) then
				travel(cid, 881, 1879, 6)
				selfSay('How rude!')
				else
					selfSay('Sorry, you don\'t have enough money.')
				end
 			end
			talk_state = 0

		elseif talk_state == 4 then
			if msgcontains(msg, 'yes') then
				if pay(cid,5000) then
				travel(cid, 1024, 1858, 6)
				selfSay('How rude!')
				else
					selfSay('Sorry, you don\'t have enough money.')
				end
 			end
			talk_state = 0

		elseif talk_state == 5 then
			if msgcontains(msg, 'yes') then
				if doPlayerRemoveItem(cid,6527,100) == 1 then
				travel(cid, 1094, 1883, 6)
				selfSay('How rude!')
				else
					selfSay('Sorry, you don\'t have enough Dsp\'s.')
				end
 			end
			talk_state = 0

			elseif msgcontains(msg, 'hi') then
			selfSay('Hello ' .. creatureGetName(cid) .. ' ?')

			elseif msgcontains(msg, 'offer') then
			selfSay('level 8 from 99 bramum, level 100 from 199 canudis, level 200 from 299 morgun,level 8 from 510 mordor valans, is level 8 from 510 tanoris gods.')	
			
		elseif msgcontains(msg, 'bye') and getDistanceToCreature(cid) < 4 then
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
  			selfSay('How rude!')
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