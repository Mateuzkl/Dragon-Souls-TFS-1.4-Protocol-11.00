local focus = 0
local talk_start = 0
local target = 0
local following = false
local attacking = false

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
		if isPremium(cid) then
			selfSay('Hello ' .. creatureGetName(cid) .. '. Welcome to my great boat!')
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

		if msgcontains(msg, 'edron') then
			selfSay('Do you wish to travel to Edron for 400 gold coins?')
			talk_state = 1

		elseif talk_state == 1 then
			if msgcontains(msg, 'yes') then
				if pay(cid,400) then
					travel(cid, 736, 795, 6)
					selfSay('How rude!')
				else
				selfSay('Sorry, you don\'t have enough money.')
				end
 			end
			talk_state = 2
		

		elseif msgcontains(msg, 'carlin') then
			selfSay('Do you wish to travel to Carlin for 200 gold coins?')
			talk_state = 2

		elseif talk_state == 2 then
			if msgcontains(msg, 'yes') then
				if pay(cid,200) then
					travel(cid, 151, 357, 6)
					selfSay('How rude!')
				else
				selfSay('Sorry, you don\'t have enough money.')
				end
 			end
			talk_state = 3
	

		elseif msgcontains(msg, 'minas tirith') or msgcontains(msg, 'tirith') then
			selfSay('Do you wish to travel to Minas Tirith for 400 gold coins?')
			talk_state = 3

		elseif talk_state == 3 then
			if msgcontains(msg, 'yes') then
				if pay(cid,400) then
					travel(cid, 476, 294, 6)
					selfSay('How rude!')
				else
				selfSay('Sorry, you don\'t have enough money.')
				end
 			end
			talk_state = 4

		elseif msgcontains(msg, 'raccoon') or msgcontains(msg, 'raccoon city') then
			selfSay('Do you wish to travel to Raccoon for 300 gold coins?')
			talk_state = 4

		elseif talk_state == 4 then
			if msgcontains(msg, 'yes') then
				if pay(cid,300) then
					travel(cid, 210, 74, 6)
					selfSay('How rude!')
				else
				selfSay('Sorry, you don\'t have enough money.')
				end
 			end
			talk_state = 5

		elseif msgcontains(msg, 'castle of carlin') then
			selfSay('Do you wish to travel to Castle of Carlin for 100 gold coins?')
			talk_state = 5

		elseif talk_state == 5 then
			if msgcontains(msg, 'yes') then
				if pay(cid,100) then
					travel(cid, 543, 529, 6)
					selfSay('How rude!')
				else
				selfSay('Sorry, you don\'t have enough money.')
				end
 			end
			talk_state = 6

		elseif msgcontains(msg, 'draynor') or msgcontains(msg, 'draynor island') then
			selfSay('Well... I promissed to myself that I would never travel back there, but if you pay me..hmm.. 800 coins we have a deal! Wanna go?')
			talk_state = 6

		elseif talk_state == 6 then
			if msgcontains(msg, 'yes') then
				if pay(cid,100) then
					travel(cid, 250, 441, 6)
					selfSay('How rude!')
				else
				selfSay('Sorry, you don\'t have enough money.')
				end
 			end
			talk_state = 0

		elseif msgcontains(msg, 'offer') then
			selfSay('I can take you to Edron, Raccoon, Minas Tirith, Bree, to the castle of carlin, for just a small fee... And i known the way to Draynor Island.')

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
  	end
	if focus ~= 0 then
 		if getDistanceToCreature(focus) > 5 then
 			selfSay('Good bye then.')
 			focus = 0
 		end
 	end
end


