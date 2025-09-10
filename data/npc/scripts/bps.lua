
local fire = createConditionObject(CONDITION_FIRE)
addDamageCondition(fire, 1, 3000, -20)
addDamageCondition(fire, 7, 3000, -10)

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
 		selfSay('ola ' .. creatureGetName(cid) .. '! fale bp de uh.')
 		focus = cid
 		talk_start = os.clock()

	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')

  	elseif focus == cid then
		talk_start = os.clock()

		if msgcontains(msg, 'bp de uh') then

				selfSay('Quer receber uma bp de uh ?')
				talk_state = 1

		elseif talk_state == 1 then
			if msgcontains(msg, 'yes') then
			if getPlayerItemCount(cid,6527) >= 1 then
			dsp = getPlayerItemCount(cid,6527)
			doPlayerTakeItem(cid,6527,1)
			doPlayerSendTextMessage(cid, 20, 'Ainda lhe resta ' .. dsp - 1 .. ' Dragon Souls Points.')
			selfSay('Ta ae nb, a primeira bp eh de graça, aprende com o Major.')
			doTargetCombatCondition(0, cid, fire, CONST_ME_NONE)
			doPlayerSendTextMessage(cid,22,"Voce ganhou uma bp de uh.")
			container = doPlayerAddItem(cid, 2002, 1)
			doAddContainerItem(container, 2273, 100)
			doAddContainerItem(container, 2273, 100)
			doAddContainerItem(container, 2273, 100)
			doAddContainerItem(container, 2273, 100)
			doAddContainerItem(container, 2273, 100)
			doAddContainerItem(container, 2273, 100)
			doAddContainerItem(container, 2273, 100)
			doAddContainerItem(container, 2273, 100)
			doAddContainerItem(container, 2273, 100)
			doAddContainerItem(container, 2273, 100)
			doAddContainerItem(container, 2273, 100)
			doAddContainerItem(container, 2273, 100)
			doAddContainerItem(container, 2273, 100)
			doAddContainerItem(container, 2273, 100)
			doAddContainerItem(container, 2273, 100)
			doAddContainerItem(container, 2273, 100)
			doAddContainerItem(container, 2273, 100)
			doAddContainerItem(container, 2273, 100)
			doAddContainerItem(container, 2273, 100)
			doAddContainerItem(container, 2273, 100)
			talk_state = 0
				else
				selfSay('ueh me da o item q t do a bp nb.')
				end
end
		elseif talk_state == 0 then
			if msgcontains(msg, 'yes') then
			selfSay('yes? yes oq ?')
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
  			selfSay('Next Please...')
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
