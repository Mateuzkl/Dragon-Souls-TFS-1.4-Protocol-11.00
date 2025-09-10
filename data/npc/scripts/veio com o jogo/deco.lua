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
  		selfSay('Hello ' .. creatureGetName(cid) .. '! I sell Gems, Big Gems and Misc Decoration!')
  		focus = cid
  		talk_start = os.clock()

  	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')

	elseif focus == cid then
		talk_start = os.clock()

		if msgcontains(msg, 'big gems') then
			selfSay('I sell Violet (1k), Yellow (1k), Green (1k), Red (1k) and Blue Gems (1k).')
		elseif msgcontains(msg, 'misc') then
			selfSay('I sell Blood Herbs (1k), 100 Coconuts (5k), 100 Snowballs (10k), 100 Gold Nuggets (10k), and Teddy Bears (10k).')
		elseif msgcontains(msg, 'gems') then
			selfSay('I sell 100 Talons (5k), 100 Small Rubies (5k), 100 Small Emeralds (5k), 100 Small Diamonds (5k), 100 Small Amethysts (5k), 100 Small Sapphires (5k), 100 Black Pearls (5k) and 100 White Pearls (5k).')

		elseif msgcontains(msg, 'violet') then
			buy(cid,2153,1,1000)
		elseif msgcontains(msg, 'yellow') then
			buy(cid,2154,1,1000)
		elseif msgcontains(msg, 'green') then
			buy(cid,2155,1,1000)
		elseif msgcontains(msg, 'red') then
			buy(cid,2156,1,1000)
		elseif msgcontains(msg, 'blue') then
			buy(cid,2158,1,1000)

		elseif msgcontains(msg, 'blood herb') then
			buy(cid,2798,1,1000)
		elseif msgcontains(msg, 'coconuts') then
			buy(cid,2678,100,5000)
		elseif msgcontains(msg, 'snowballs') then
			buy(cid,2111,100,10000)
		elseif msgcontains(msg, 'teddy bear') then
			buy(cid,2326,1,10000)
		elseif msgcontains(msg, 'nuggets') then
			buy(cid,2157,100,10000)

		elseif msgcontains(msg, 'small rubies') then
			buy(cid,2147,100,5000)
		elseif msgcontains(msg, 'small emeralds') then
			buy(cid,2149,100,5000)
		elseif msgcontains(msg, 'small diamonds') then
			buy(cid,2145,100,5000)
		elseif msgcontains(msg, 'small sapphires') then
			buy(cid,2146,100,5000)
		elseif msgcontains(msg, 'small amethysts') then
			buy(cid,2150,100,5000)
		elseif msgcontains(msg, 'talons') then
			buy(cid,2151,100,5000)
		elseif msgcontains(msg, 'black pearls') then
			buy(cid,2144,100,5000)
		elseif msgcontains(msg, 'white pearls') then
			buy(cid,2143,100,5000)
		
		
		elseif string.find(msg, '(%a*)bye(%a*)') and getDistanceToCreature(cid) < 4 then
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
