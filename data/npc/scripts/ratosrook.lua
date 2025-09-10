

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
	rat = getPlayerStorageValue(cid,2467)
	dist = getDistanceToCreature(cid)


  	if (msgcontains(msg, 'hi') and (focus == 0)) and dist < 3 and rat == -1 then
		selfSay('Help ' .. creatureGetName(cid) .. '! My food storage was infested of rats! I cant loose more food!')
  		doPlayerSendTextMessage(cid,19,"Nova quest adicionada 'Infestação do armazen!'.")
		doSendMagicEffect(getPlayerPosition(cid),12)
  		setPlayerStorageValue(cid,2467,1)
  		focus = cid
		talk_start = os.clock()

  	elseif (msgcontains(msg, 'hi') and (focus == 0)) and dist < 3 and rat == 1 then
		selfSay('Help ' .. creatureGetName(cid) .. '! My food storage was infested of rats! I cant loose more food!')
  		focus = cid
		talk_start = os.clock()

  	elseif (msgcontains(msg, 'hi') and (focus == 0)) and dist < 3 and rat == 2 then
		selfSay('Thanks so much ' .. creatureGetName(cid) .. '! Get that to help you!')
     		doPlayerSendTextMessage(cid,22,"You receive few oranges, an studded club and an wooden shield.")
  		doSendMagicEffect(getPlayerPosition(cid),12)
		setPlayerStorageValue(cid,2467,3)
   		doPlayerAddItem(cid,2675,15)
   		doPlayerAddItem(cid,2448,1)
   		doPlayerAddItem(cid,2512,1)
  		doPlayerSendTextMessage(cid,19,"Quest 'Infestação do armazen!' completada.")
		doSendMagicEffect(getPlayerPosition(cid),12)
  		focus = cid
		talk_start = os.clock()

  	elseif (msgcontains(msg, 'hi') and (focus == 0)) and dist < 3 and rat == 3 then
		selfSay('Hey you again ' .. creatureGetName(cid) .. '!')
  		focus = cid
		talk_start = os.clock()

	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 3 then
  		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')
  		focus = cid
		talk_start = os.clock()

  	elseif focus == cid then
		talk_start = os.clock()


  	elseif msgcontains(msg, 'bye')  and getDistanceToCreature(cid) < 4 then
  		selfSay('Good bye, ' .. creatureGetName(cid) .. '!')
  			focus = 0
  			talk_start = 0

end
end


function onCreatureChangeOutfit(creature)

end


function onThink()
	doNpcSetCreatureFocus(focus)
  	if (os.clock() - talk_start) > 5 then
  		if focus > 0 then
  			selfSay('Thanks.')
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
