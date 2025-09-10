

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
	abs = getPlayerStorageValue(cid,5908)


  	if (msgcontains(msg, 'hi') and (focus == 0)) and getDistanceToCreature(cid) < 4 then
		selfSay('Hey there! ' .. creatureGetName(cid) .. '! What i can do for you my friend?')
 		focus = cid
 		talk_start = os.clock()

	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')



  	elseif focus == cid then
		talk_start = os.clock()


	if msgcontains(msg, 'offer') then
		selfSay('Welcome to my Tavern! I got, the best malte beer of region! Flesh meat, pure wine and strong rum, but i can sell milk if you want haha! So what do you wish my friend?')

	elseif msgcontains(msg, 'beer') then
		selfSay('It\'s 20 gps for a malte beer, wanna buy?')
		talk_state = 1

	elseif msgcontains(msg, 'meat') then
		selfSay('It\'s 7 gps for flesh meat, wanna buy?')
		talk_state = 2

	elseif msgcontains(msg, 'wine') then
		selfSay('It\'s 10 gps for a pure wine, wanna buy?')
		talk_state = 3

	elseif msgcontains(msg, 'rum') then
		selfSay('It\'s 50 gps for a strong rum, wanna buy?')
		talk_state = 4

	elseif msgcontains(msg, 'milk') then
		selfSay('It\'s 5 gps for your milk, wanna buy?')
		talk_state = 5

	elseif msgcontains(msg, 'draconian') and abs == 3 then
		if getPlayerItemCount(cid,5889) >= 1 then
		selfSay('OH MY GOD! Where did you get that, i really need it to do a powerfull weapon, wanna trade it and a Obsidian Lance for a rare item used by doctors and assassins?')
		talk_state = 10
		else
		selfSay('How you know about that?')
		end


  	elseif msgcontains(msg, 'bye')  and getDistanceToCreature(cid) < 4 then
  		selfSay('Good bye, ' .. creatureGetName(cid) .. '!')
  		focus = 0
  		talk_start = 0

	elseif msgcontains(msg, 'no') and (talk_state >= 1 and talk_state <= 34) then
		selfSay('Ok than.')
		talk_state = 0
-- abs yes

		elseif msgcontains(msg, 'yes') and talk_state == 10 then
			if getPlayerItemCount(cid,2425) >= 1 and getPlayerItemCount(cid,5889) >= 1 then
				selfSay('Im really happy whit that my friend, get this rare obsidian knife as a gift!')
  				doPlayerSendTextMessage(cid,19,"Quest 'Mais que um favor!' completada.")
				doPlayerTakeItem(cid,2425,1)
				doPlayerTakeItem(cid,5889,1)
  				doSendMagicEffect(getPlayerPosition(cid),12)
				doPlayerAddItem(cid,5908,1)
				setPlayerStorageValue(cid,5908,4)
				talk_state = 0
				else
				selfSay('Hmm... I need a piece of draconian steel and one obsidian lance!')
				end
				

-- states

	elseif talk_state == 1 then
		if msgcontains(msg, 'yes') then
		if pay(cid,20) then
		selfSay('It\'s here!')
		doPlayerAddItem(cid,3942,3)
		talk_state = 0
		else
		selfSay('Friend, you don\'t have this money.')
		talk_state = 0
 		end
	end

	elseif talk_state == 2 then
		if msgcontains(msg, 'yes') then
		if pay(cid,7) then
		selfSay('It\'s here!')
		doPlayerAddItem(cid,2666,1)
		talk_state = 0
		else
		selfSay('Friend, you don\'t have this money.')
		talk_state = 0
 		end
	end

	elseif talk_state == 3 then
		if msgcontains(msg, 'yes') then
		if pay(cid,10) then
		selfSay('It\'s here!')
		doPlayerAddItem(cid,3942,15)
		talk_state = 0
		else
		selfSay('Friend, you don\'t have this money.')
		talk_state = 0
 		end
	end

	elseif talk_state == 4 then
		if msgcontains(msg, 'yes') then
		if pay(cid,50) then
		selfSay('It\'s here!')
		doPlayerAddItem(cid,3942,27)
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
  			selfSay('See you later.')
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
