

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
	pirate = getPlayerStorageValue(cid,893)
	golds = getPlayerItemCount(cid,1294) * 50
	stones = getPlayerItemCount(cid,1294)


  	if (msgcontains(msg, 'hi') and (focus == 0)) and getDistanceToCreature(cid) < 4 then
		selfSay('Hey there! ' .. creatureGetName(cid) .. '! Newcomers arrive every day in our mining guild!')
 		focus = cid
 		talk_start = os.clock()

	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')



  	elseif focus == cid then
		talk_start = os.clock()


	if msgcontains(msg, 'offer') then
		selfSay('I can sell you a pick to you get in work! If you wanna know more about mining ask for HELP.')

	elseif msgcontains(msg, 'nugget') then
		selfSay('Nuggets are used as base to forge weapons! Ask for more info in the Smithing Guild.')

	elseif msgcontains(msg, 'buy') then
		selfSay('I sell pick.')

	elseif msgcontains(msg, 'help') then
		selfSay('Just use you pick in the stalagmites or in iron walls!')
		selfSay('Iron walls are only found in Minas Tirith, you can train mining skills(!habilidades) on it, and find iron nuggets!')

	elseif msgcontains(msg, 'nugget') then
		selfSay('Nuggets are used as base to forge weapons! Ask for more info in the Smithing Guild.')

	elseif msgcontains(msg, 'tirith') then
		selfSay('The master mining and smithing city, only avaible to premium users.')

	elseif msgcontains(msg, 'mission') then
		selfSay('I prefer quests.')

	elseif msgcontains(msg, 'task') then
		selfSay('I used to ask for quests.')

	elseif msgcontains(msg, 'mission') and quest == 3 then
		selfSay('No more quest by now. Go train.')

	elseif msgcontains(msg, 'task') and quest == 3 then
		selfSay('No more quest by now. Go train.')

	elseif msgcontains(msg, 'pick') then
		selfSay('It will be only 10gold, accept?')
		talk_state = 1

	elseif msgcontains(msg, 'quest') and quest == 3 then
		selfSay('No more quest by now. Go train.')



-- novice

	elseif msgcontains(msg, 'quest') and quest == -1 then
		selfSay('Hmm... As you are a novice I will give you an easy task.')
		selfSay('I need you to bring me a Coal Ore.')
		selfSay('Coal is used to make fire! Its very dificult to find, but here in the Guild you can access if you have mining level:35.')
		setPlayerStorageValue(cid,893,1)
		

	elseif msgcontains(msg, 'quest') and quest == 1 then
		selfSay('You have to use your pick in the Coal Rocks untill you find some coal!')
		talk_state = 0

	elseif msgcontains(msg, 'quest') and quest == 2 then
		selfSay('Did you bring me the Coal i asked you?')
		talk_state = 11

		elseif msgcontains(msg, 'yes') and talk_state == 11 then
			if getPlayerItemCount(cid,5880) >= 5 then
				doPlayerTakeItem(cid,5880,1)
				selfSay('Oh, good job. Take this and come back when you want another task.')
				doPlayerAddItem(cid,2157,1)
				setPlayerStorageValue(cid,893,3)
				talk_state = 0
				else
				selfSay('Use your pick in the locked stone areas here in the Guild, to find Coal.')
				end


-- novice fim





  	elseif msgcontains(msg, 'bye')  and getDistanceToCreature(cid) < 4 then
  		selfSay('Good bye, ' .. creatureGetName(cid) .. '!')
  		focus = 0
  		talk_start = 0

	elseif msgcontains(msg, 'no') and (talk_state >= 1 and talk_state <= 50) then
		selfSay('Ok than.')
		talk_state = 0

-- states

	elseif talk_state == 1 then
		if msgcontains(msg, 'yes') then
		if pay(cid,10) then
		selfSay('It\'s here!')
		doPlayerAddItem(cid,2553,1)
		talk_state = 0
		else
		selfSay('Friend, you don\'t have this money.')
		talk_state = 0
 		end
	end

	elseif talk_state == 5 then
		if msgcontains(msg, 'yes') then
		if pay(cid,5) then
		selfSay('It\'s here!')
		doPlayerAddItem(cid,3942,6)
		talk_state = 0
		else
		selfSay('Friend, you don\'t have this money.')
		talk_state = 0
 		end
	end

end
end
end

function onCreatureChangeOutfit(creature)

end


function onThink()

if focus == 0 then
randsay = math.random(1,100)
if randsay == 1 then
 selfSay('Hicks!') 
end
if randsay == 50 then
 selfSay('Hicks!') 
end
end

	doNpcSetCreatureFocus(focus)
  	if (os.clock() - talk_start) > 30 then
  		if focus > 0 then
  			selfSay('See you later. Continue Training!')
  		end
  			focus = 0
  	end
 	if focus ~= 0 then
 		if getDistanceToCreature(focus) > 5 then
 			selfSay('Good bye then. Continue Training!')
 			focus = 0
 		end
 	end
end