

local focus = 0
local talk_start = 0
local target = 0
local days = 0

function onThingMove(creature, thing, oldpos, oldstackpos)

end


function onCreatureAppear(creature)
          selfSay('Help!')
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
	promo = getPlayerStorageValue(cid,30007)


  	if (msgcontains(msg, 'hi') and (focus == 0)) and getDistanceToCreature(cid) < 4 then
		if promo == 1 then
			selfSay('Oh my hero! You got the key?')
			talk_state = 1
 			focus = cid
 			talk_start = os.clock()
		else
			selfSay('What you doing here? Please, i wanna out of here!')
 			focus = cid
 			talk_start = os.clock()
		end
 		focus = cid
 		talk_start = os.clock()

	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Oh! two heroes to help me!')

  	elseif focus == cid then
		talk_start = os.clock()


	if msgcontains(msg, 'no') and talk_state == 1 then
		selfSay('Oh too bad! So, i can\'t out... Please do a favor for me.')
		selfSay('Can you take a message from me to the queen?')
		talk_state = 2

	elseif msgcontains(msg, 'yes') and talk_state == 1 then
		selfSay('Oh great! You are the best! So open the door for we run out of here!')
		talk_state = 1

	elseif msgcontains(msg, 'yes') and talk_state == 2 then
		setPlayerStorageValue(cid,30007,2)
  		doSendMagicEffect(getPlayerPosition(cid),12)
		carta = doPlayerAddItem(cid, 2598, 1)
	doSetItemText(carta,"My queen, im busted on orc place, need help! By Sarina.")
		selfSay('Say to her that you have a message from Sarina... thanks so much!')
		talk_state = 0
  		focus = 0


		elseif msgcontains(msg, 'no') and (talk_state >= 2 and talk_state <= 34) then
			selfSay('Ok than.')
			talk_state = 0

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

if focus == 0 then
randsay = math.random(1,100)
if randsay == 1 then
 selfSay('Help!') 
end
if randsay == 50 then
 selfSay('Here! I need help!') 
end
if randsay == 100 then
 selfSay('Help me please!') 
end
end

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
