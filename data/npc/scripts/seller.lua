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
  		selfSay('Hello, ' .. creatureGetName(cid) .. '! I sell ropes (50gp), shovels (20gp), backpacks (10gp), manafluids (100gp), lifefluids (60gp), fishing rods (100gp), amulet of loss (10k), and torches (2gp). I buy vials (10gp).')
  		focus = cid
  		talk_start = os.clock()

  	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')

	elseif focus == cid then
		talk_start = os.clock()

		if msgcontains(msg, 'shovel') then
			buy(cid,2554,getCount(msg),20)
		elseif msgcontains(msg, 'backpack') then
			buy(cid,1988,getCount(msg),10)
		elseif msgcontains(msg, 'manafluid') or msgcontains(msg, 'mana fluid') then
			buyFluidContainer(cid,2006,getCount(msg),100,7)
		elseif msgcontains(msg, 'lifefluid') or msgcontains(msg, 'life fluid') then
			buyFluidContainer(cid,2006,getCount(msg),60,10)
		elseif msgcontains(msg, 'fishing rod') then
			buy(cid,2580,getCount(msg),100)
		elseif msgcontains(msg, 'torch') then
			buy(cid,2050,getCount(msg),2)
		elseif msgcontains(msg, 'aol') then
			buy(cid,2173,getCount(msg),10000)	
		elseif msgcontains(msg, 'vial') or msgcontains(msg, 'flask') then
			sell(cid,2006,getCount(msg),10)

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
