

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
	quest = getPlayerStorageValue(cid,5059)


  	if (msgcontains(msg, 'hi') and (focus == 0)) and getDistanceToCreature(cid) < 4 then
		selfSay('Who dare to enter our cave!')
 		focus = cid
 		talk_start = os.clock()

	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Go away you too.')



  	elseif focus == cid then
		talk_start = os.clock()


	if msgcontains(msg, 'offer') then
		selfSay('I cant offer you not eaven talk!')

	elseif msgcontains(msg, 'help') then
		selfSay('You are in the wrong place weak!')

	elseif msgcontains(msg, 'mission') then
		selfSay('My mission is to dont let none enter!')



-- quest

	elseif msgcontains(msg, 'enter') and quest == -1 then
		selfSay('Há, do you think I will let anyone enter? I am here to do the oposit!')
		selfSay('But if you are realy interested, I can let you in if you do something for me.')
		selfSay('Do you accept my task?')
		talk_state = 1
		setPlayerStorageValue(cid,5059,1)
		
	elseif msgcontains(msg, 'yes') and talk_state == 1 then
		selfSay('Ok, some days ago, I went to the Black Knights cave to visit an old friend,')
		selfSay('But I think I forgot my Watch there, If you recover it Ill let you in! I think my friend have the watch...')
		selfSay('Tell him Savar sent you.')
		setPlayerStorageValue(cid,5059,1)
		doPlayerSendTextMessage(cid,19,"Nova quest adicionada 'O segredo Hero.'.")
  		doSendMagicEffect(getPlayerPosition(cid),12)
		talk_state = 0

	elseif msgcontains(msg, 'enter') and quest == 1 then
		selfSay('I lost my Watch in the Black Knights cave, not too far from here.')
	elseif msgcontains(msg, 'enter') and quest == 2 then
		selfSay('I lost my Watch in the Black Knights cave, not too far from here.')

	elseif msgcontains(msg, 'enter') and quest == 3 then
		selfSay('Did you manage to bring me back my Watch?')
		talk_state = 2

		elseif msgcontains(msg, 'yes') and talk_state == 2 then
			if getPlayerItemCount(cid,6092) >= 1 then
				doPlayerTakeItem(cid,6092,1)
				selfSay('Thanks alot! It was given by my grandfather to my father, and he gaved it to me.')
				selfSay('As I promissed, come in.')
				selfSay('/send ' .. creatureGetName(cid) .. ', 759 771 8')
				setPlayerStorageValue(cid,5059,4)
			doPlayerSendTextMessage(cid,19,"Quest 'O segredo Hero.' Completada!")
  			doSendMagicEffect(getPlayerPosition(cid),12)
				talk_state = 0
				else
				selfSay('You dont have it, I lost it in the Black Knights Cave.')
				end


-- quest fim

-- enter e leave

	elseif msgcontains(msg, 'enter') and quest == 4 then
		selfSay('Do you wana came in?')
		talk_state = 3

		elseif msgcontains(msg, 'yes') and talk_state == 3 then
		selfSay('/send ' .. creatureGetName(cid) .. ', 759 771 8')

	elseif msgcontains(msg, 'leave') then
		selfSay('Do you wana leave?')
		talk_state = 4

		elseif msgcontains(msg, 'yes') and talk_state == 4 then
		selfSay('/send ' .. creatureGetName(cid) .. ', 763 771 8')



--------------

  	elseif msgcontains(msg, 'bye')  and getDistanceToCreature(cid) < 4 then
  		selfSay('Good bye, ' .. creatureGetName(cid) .. '!')
  		focus = 0
  		talk_start = 0

	elseif msgcontains(msg, 'no') and (talk_state >= 1 and talk_state <= 51) then
		selfSay('Ok than.')
		talk_state = 0

-- states

	elseif talk_state == 50 then
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

	elseif talk_state == 51 then
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