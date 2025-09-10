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

  	if (msgcontains(msg, 'hi') and focus == 0) and getDistanceToCreature(cid) < 4 then
  		selfSay('Hello ' .. creatureGetName(cid) .. '! I sell all amulets.')
  		focus = cid
  		talk_start = os.clock()

  	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')

  	elseif focus == cid then
		talk_start = os.clock()

	if msgcontains(msg, 'amulets') then
        selfSay('I sell aol (10k), ancient amulet (1.6k), broken amulet (20k), bronze amulet (100gps), bronzen necklace (300gps), crystal necklace (250gps), dragon necklace (400gps), garlic necklace (450gps), golden amulet (3k), platinum amulet (3.5k), protection amulet (300gps), elven amulet (500gps), ruby necklace (2k),  scarab amulet (1.3k),  scarf (500gps),  silver amulet (300gps), silver necklace (1k), star amulet (1.2k), stone skin amulet (3k), strange symbol (200gps), strange talisman (350gps) and wolves teeth chain (50gps).')      

      elseif msgcontains(msg, 'amulet of loss') or msgcontains(msg, 'aol') then
         buy(cid,2173,1,10000)

      elseif msgcontains(msg, 'ancient amulet') then
         buy(cid,2142,1,1600)

      elseif msgcontains(msg, 'broken amulet') then
         buy(cid,2196,1,20000)

      elseif msgcontains(msg, 'bronze amulet') then
         buy(cid,2172,1,100)

      elseif msgcontains(msg, 'bronzen necklace') then
         buy(cid,2126,1,300)

      elseif msgcontains(msg, 'crystal necklace') then
         buy(cid,2125,15,250)

      elseif msgcontains(msg, 'dragon necklace') then
         buy(cid,2201,15,400)

      elseif msgcontains(msg, 'garlic necklace') then
         buy(cid,2199,10,450)

      elseif msgcontains(msg, 'golden amulet') then
         buy(cid,2130,6,3000)

      elseif msgcontains(msg, 'platinum amulet') then
         buy(cid,2171,6,3500)

      elseif msgcontains(msg, 'protection amulet') then
         buy(cid,2200,15,300)

      elseif msgcontains(msg, 'elven amulet') then
         buy(cid,2198,4,500)

      elseif msgcontains(msg, 'ruby necklace') then
         buy(cid,2133,5,2000)

      elseif msgcontains(msg, 'scarab amulet') then
         buy(cid,2135,1,1300)

      elseif msgcontains(msg, 'scarf') then
         buy(cid,2135,1,500)

      elseif msgcontains(msg, 'silver amulet') then
         buy(cid,2170,1,300)

      elseif msgcontains(msg, 'silver necklace') then
         buy(cid,2132,1,1000)

      elseif msgcontains(msg, 'star amulet') then
         buy(cid,2131,1,1200)

      elseif msgcontains(msg, 'stone skin amulet') then
         buy(cid,2197,1,3000)

      elseif msgcontains(msg, 'strange symbol') then
         buy(cid,2319,1,200)

      elseif msgcontains(msg, 'strange talisman') then
         buy(cid,2161,1,350)

      elseif msgcontains(msg, 'wolves teeth chain') then
         buy(cid,2129,1,50) 
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
