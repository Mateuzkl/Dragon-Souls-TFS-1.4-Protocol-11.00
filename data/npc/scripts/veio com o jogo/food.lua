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
  		selfSay('Hello ' .. creatureGetName(cid) .. '! I sell ham, meat, carrots, apples, brown breads, brown mushrooms and eggs (everything for 9gps).')
  		focus = cid
  		talk_start = os.clock()

  	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')

	elseif focus == cid then
		talk_start = os.clock()

		if msgcontains(msg, 'brown bread') or msgcontains(msg, 'brown breads')then
		count = getCount(msg)
		price = count*8
			buy(cid,2691,count,price)
		elseif msgcontains(msg, 'ham') or msgcontains(msg, 'hams')then
		count = getCount(msg)
		price = count*8
			buy(cid,2671,count,price)
		elseif msgcontains(msg, 'carrot') or msgcontains(msg, 'carrots') then
		count = getCount(msg)
		price = count*8
			buy(cid,2684,count,price)
		elseif msgcontains(msg, 'meat') or msgcontains(msg, 'meats')then
		count = getCount(msg)
		price = count*8
			buy(cid,2666,count,price)
		elseif msgcontains(msg, 'apple') or msgcontains(msg, 'apples')then
		count = getCount(msg)
		price = count*8
			buy(cid,2674,count,price)
		elseif msgcontains(msg, 'brown mushroom') or msgcontains(msg, 'brown mushroooms')then
		count = getCount(msg)
		price = count*8
			buy(cid,2789,count,price)
		elseif msgcontains(msg, 'egg') or msgcontains(msg, 'eggs')then
		count = getCount(msg)
		price = count*8
			buy(cid,2695,count,price)

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

