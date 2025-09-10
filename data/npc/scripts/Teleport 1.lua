

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
		selfSay('Who invited you to enter on temple of Anoriel mortal?')
 		focus = cid
 		talk_start = os.clock()

	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Wait your turn ' .. creatureGetName(cid) .. '!')



  	elseif focus == cid then
		talk_start = os.clock()


	if msgcontains(msg, 'anoriel') then
		if getPlayerStorageValue(cid,6040) == -1 then
		if getPlayerVocation(cid) < 9 then
			selfSay('Then go talk whit him!')
			selfSay('/send ' .. creatureGetName(cid) .. ', 461 254 13')
			focus = 0
			talk_start = 0
			else
			selfSay('You can not enter on this temple again, go away Semi-Deus!')
			end
			else
			selfSay('You can not enter on this temple again, go away!')
			end

  	elseif msgcontains(msg, 'bye')  and getDistanceToCreature(cid) < 4 then
  		selfSay('Get out ' .. creatureGetName(cid) .. '!')
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
  			selfSay('Get out.')
  		end
  			focus = 0
  	end
 	if focus ~= 0 then
 		if getDistanceToCreature(focus) > 5 then
 			selfSay('Get out.')
 			focus = 0
 		end
 	end
end
