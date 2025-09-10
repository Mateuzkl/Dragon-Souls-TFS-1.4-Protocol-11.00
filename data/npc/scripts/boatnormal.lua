focus = 0
talk_start = 0
target = 0
following = false
attacking = false

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
		if isPremmium(cid) then
			selfSay('Hello ' .. creatureGetName(cid) .. '! I can take you to the Desert City (20gp) or Jungle Camp (50gp). Where do you want to go?')
			focus = cid
			talk_start = os.clock()
		else
			selfSay('Sorry, only premium players can travel by boat.')
			focus = 0
			talk_start = 0
		end

  	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')

  	elseif focus == cid then
		talk_start = os.clock()

		if msgcontains(msg, 'desert city') then
			if pay(cid,50) then
				selfSay('Let\'s go!')
				selfSay('/send ' .. creatureGetName(cid) .. ', 369 270 7')
				focus = 0
				talk_start = 0
			else
				selfSay('Sorry, you don\'t have enough money.')
			end

		elseif msgcontains(msg, 'jungle camp') then
			if pay(cid,20) then
				selfSay('Let\'s go!')
				selfSay('/send ' .. creatureGetName(cid) .. ', 195 257 6')
				focus = 0
				talk_start = 0
			else
				selfSay('Sorry, you don\'t have enough money.')
			end

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
  	if (os.clock() - talk_start) > 30 then
  		if focus > 0 then
  			selfSay('Next Please...')
  		end
  			focus = 0
  	end	if focus ~= 0 then
 		if getDistanceToCreature(focus) > 5 then
 			selfSay('Good bye then.')
 			focus = 0
 		end
 	end
end
