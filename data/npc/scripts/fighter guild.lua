

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
	quest1 = getPlayerStorageValue(cid,1569)


  	if (msgcontains(msg, 'hi') and (focus == 0)) and getDistanceToCreature(cid) < 4 then
		selfSay('Hello young Fighter! ' .. creatureGetName(cid) .. '! Ask for HELP if you need so!')
 		focus = cid
 		talk_start = os.clock()

	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Sorry, ' .. creatureGetName(cid) .. '! Wait in the line.')



  	elseif focus == cid then
		talk_start = os.clock()


	if msgcontains(msg, 'offer') then
		selfSay('I can offer you challanges.')
		selfSay('Challanges are like quest, you can participate a challange here in the Fighters Guild, after some missions.')
		selfSay('Completing challanges you will be training your Fighting skill(say skills to more information)!')

	elseif msgcontains(msg, 'help') then
		selfSay('Welcome to the Fighters Guild! Only the best fighters are allowed in here!')
		selfSay('Here you can use our training areas and face Challanges to train you Fighting Skill(say skills to more information)!')

	elseif msgcontains(msg, 'skills') then
		selfSay('By completing Challanges you will be training tour Fighting Skill...')
		selfSay('Fighting Skill is used to unlock Ancient Weapons!')

	elseif msgcontains(msg, 'ancient') then
		selfSay('They are unlocked after reaching Fighting Skill 30, 50, and 80!')

	elseif msgcontains(msg, 'challange') and quest1 == -1 then
		selfSay('You cant access challanges yet. Complete my quests to gain access to it.')

	elseif msgcontains(msg, 'challange') and quest1 == 1 then
		selfSay('You cant access challanges yet. Complete my quests to gain access to it.')

	elseif msgcontains(msg, 'challange') and quest1 == 2 then
		selfSay('You cant access challanges yet. Complete my quests to gain access to it.')

	elseif msgcontains(msg, 'challange') and quest1 == 3 then
		selfSay('Kaya ponha pra acessar quando tive skill 90.')

	elseif msgcontains(msg, 'quest') and quest1 == 3 then
		selfSay('No more quests for you, you can now access Challanges.')


-- novice

	elseif msgcontains(msg, 'quest') and quest1 == -1 then
		selfSay('Ok, your first quest will be easy, just open the door, nort here in the Guild, and kill the monster inside it, bring me hes loot!')
		setPlayerStorageValue(cid,1569,1)
		

	elseif msgcontains(msg, 'quest') and quest1 == 1 then
		selfSay('did you bring me the monster loot?')
		talk_state = 1


		elseif msgcontains(msg, 'yes') and talk_state == 1 then
			if getPlayerItemCount(cid,5900) >= 1 then
				doPlayerTakeItem(cid,5900,1)
				selfSay('Nice work, but that was easy...')
				selfSay('Now if you want to gain access for challanges you have to do one more thing...')
				selfSay('Bring me 5 Demon Horns!')
				setPlayerStorageValue(cid,1569,2)
				else
				selfSay('The monster is found north here in the Guild, after a door.')
				end

	elseif msgcontains(msg, 'quest') and quest1 == 2 then
		selfSay('did you bring me 5 Demon Horns?')
		talk_state = 2

		elseif msgcontains(msg, 'yes') and talk_state == 2 then
			if getPlayerItemCount(cid,5954) >= 5 then
				doPlayerTakeItem(cid,5954,5)
				selfSay('Nice work! Now you are allowed to access Challanges!')
				baguio = doPlayerAddItem(cid,5785,1)
				doSetItemSpecialDescription(baguio,"Its a proof of Honor!")
				setPlayerStorageValue(cid,1569,3)
				else
				selfSay('Kill demons to obtain it.')
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
 selfSay('Train Train!') 
end
if randsay == 50 then
 selfSay('Never give up!') 
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