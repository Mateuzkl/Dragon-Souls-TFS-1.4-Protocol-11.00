

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
		selfSay('Hey there! ' .. creatureGetName(cid) .. '! What i can do for you my friend?')
 		focus = cid
 		talk_start = os.clock()

	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')



  	elseif focus == cid then
		talk_start = os.clock()


	if msgcontains(msg, 'job') then
			selfSay('I get exotics fruits!')

		elseif msgcontains(msg, 'offer') then
			selfSay('Go talk whit Fartun!')

		elseif msgcontains(msg, 'sell') then
			selfSay('Go talk whit Fartun!')

		elseif msgcontains(msg, 'buy') then
			selfSay('Dont have money now!')

		elseif msgcontains(msg, 'quest') then
			selfSay('Hehe!')

		elseif msgcontains(msg, 'mission') then
			selfSay('Nothing now.')

-- promo

		elseif msgcontains(msg, 'orc place') then
			selfSay('Oh! Its here! Come i show you... on this hole!')
			selfMoveTo(327, 296, 7)


------------------------------------------------ confirm no ------------------------------------------------
		elseif msgcontains(msg, 'no') and (talk_state >= 1 and talk_state <= 34) then
			selfSay('Ok than.')
			talk_state = 0
		end

end
end

function onCreatureChangeOutfit(creature)

end


function onThink()

if focus == 0 then
selfMoveTo(323, 289, 7)
end


	doNpcSetCreatureFocus(focus)
  	if (os.clock() - talk_start) > 16 then
  		if focus > 0 then
  			selfSay('Now i need work!')
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
