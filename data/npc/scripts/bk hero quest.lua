

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
		selfSay('SPY, OUT OF OUR CAVE!')
 		focus = cid
 		talk_start = os.clock()

	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('GO AWAY!')



  	elseif focus == cid then
		talk_start = os.clock()


	if msgcontains(msg, 'offer') then
		selfSay('NO TALK SPY!')

	elseif msgcontains(msg, 'mission') then
		selfSay('GRR, YOU ARE PISSING ME OFF!')

	elseif msgcontains(msg, 'savar') and quest == 1 then
		selfSay('Hmm, savar sent you?.')
		selfSay('Oh, he forgot his Watch here, he want it back?')
		talk_state = 1


-- quest

	elseif msgcontains(msg, 'yes') and talk_state == 1 then
		selfSay('Ok but first do me something to prove you are not a spy!')
		selfSay('Hmm... bring me an warrior helmet and we have a deal!')
		selfSay('When you get it, ask me about the watch.')
		setPlayerStorageValue(cid,5059,2)
		
	elseif msgcontains(msg, 'watch') and quest == 2 then
		selfSay('Did you bring me the Warrior Helmet?')
		talk_state = 2

		elseif msgcontains(msg, 'yes') and talk_state == 2 then
			if getPlayerItemCount(cid,2475) >= 1 then
				doPlayerTakeItem(cid,2475,1)
				selfSay('Ok, you proofed to be loyal, now take this!')
  		doSendMagicEffect(getPlayerPosition(cid),12)
				relogio = doPlayerAddItem(cid,6092,1)
				doSetItemSpecialDescription(relogio,"Its Savar Hero Watch")
				setPlayerStorageValue(cid,5059,3)
				talk_state = 0
				else
				selfSay('You dont have it, Find it witch other Black Knights.')
				end


-- quest fim



--------------

  	elseif msgcontains(msg, 'bye')  and getDistanceToCreature(cid) < 4 then
  		selfSay('Finaly!')
  		focus = 0
  		talk_start = 0

	elseif msgcontains(msg, 'no') and (talk_state >= 1 and talk_state <= 51) then
		selfSay('Bah...')
		talk_state = 0

-- states

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
 selfSay('GRR!') 
end
if randsay == 50 then
 selfSay('MINE!') 
end
end

	doNpcSetCreatureFocus(focus)
  	if (os.clock() - talk_start) > 30 then
  		if focus > 0 then
  			selfSay('GRRRRRRRRR!')
  		end
  			focus = 0
  	end
 	if focus ~= 0 then
 		if getDistanceToCreature(focus) > 5 then
 			selfSay('GRRRRRRRR!')
 			focus = 0
 		end
 	end
end