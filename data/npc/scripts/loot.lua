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
  		selfSay('Hello ' .. creatureGetName(cid) .. '! I buy swords, clubs, axes, helmets, boots, legs, shields and armors.')
  		focus = cid
  		talk_start = os.clock()

	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')

  	elseif focus == cid then
		talk_start = os.clock()

		if msgcontains(msg, 'demon helmet') then
  			sell(cid,2498,getCount(msg),80000)
		elseif msgcontains(msg, 'royal helmet') then
  			sell(cid,2498,getCount(msg),40000)
  		elseif msgcontains(msg, 'warrior helmet') then
  			sell(cid,2475,getCount(msg),6000)
  		elseif msgcontains(msg, 'crusader helmet') then
  			sell(cid,2497,getCount(msg),9000)
  		elseif msgcontains(msg, 'crown helmet') then
  			sell(cid,2491,getCount(msg),5000)
  		elseif msgcontains(msg, 'devil helmet') then
  			sell(cid,2462,getCount(msg),4000)
  		elseif msgcontains(msg, 'mystic turban') then
  			sell(cid,2663,getCount(msg),500)
  		elseif msgcontains(msg, 'chain helmet') then
  			sell(cid,2458,getCount(msg),35)
		elseif msgcontains(msg, 'iron helmet') then
  			sell(cid,2459,getCount(msg),30)
  		elseif msgcontains(msg, 'helmets') then
  			selfSay('I buy demon (80k), royal (40k), warrior (6k), crusader (9k), crown (5k), devil (4k), chain (35gp) and iron helmets (30gp), also mystic turbans (500gp).')

  		elseif msgcontains(msg, 'steel boots') and focus == cid then
  			sell(cid,2645,getCount(msg),40000)
  		elseif msgcontains(msg, 'boh') or msgcontains(msg, 'boots of haste') and focus == cid then
  			sell(cid,2195,getCount(msg),40000)
			elseif msgcontains(msg, 'golden boots') and focus == cid then
  			sell(cid,2646,getCount(msg),100000)
  		elseif msgcontains(msg, 'boots')  then
  			selfSay('I buy golden boots (100k), steel boots (40k) and boots of haste (40k).')

		elseif msgcontains(msg, 'magic plate armor') or msgcontains(msg, 'mpa') then
  			sell(cid,2472,getCount(msg),100000)
		elseif msgcontains(msg, 'dragon scale mail') or msgcontains(msg, 'dsm') then
  			sell(cid,2492,getCount(msg),60000)
		elseif msgcontains(msg, 'demon armor') then
  			sell(cid,2494,getCount(msg),90000)
		elseif msgcontains(msg, 'golden armor') then
  			sell(cid,2466,getCount(msg),30000)
		elseif msgcontains(msg, 'crown armor') then
  			sell(cid,2487,getCount(msg),20000)
		elseif msgcontains(msg, 'knight armor') then
  			sell(cid,2476,getCount(msg),5000)
		elseif msgcontains(msg, 'blue robe') then
  			sell(cid,2656,getCount(msg),15000)
  		elseif msgcontains(msg, 'lady armor') then
  			sell(cid,2500,getCount(msg),7500)
		elseif msgcontains(msg, 'plate armor') then
  			sell(cid,2463,getCount(msg),400)
		elseif msgcontains(msg, 'brass armor') then
  			sell(cid,2465,getCount(msg),200)
		elseif msgcontains(msg, 'chain armor') then
  			sell(cid,2464,getCount(msg),100)
  		elseif msgcontains(msg, 'armors')  then
  			selfSay('I buy golden (30k), crown (20k), knight (5k), lady (7,5k), plate (400gp), brass (200gp) and chain armors (100gp), also mpa (100k), dsm (60k) and blue robes (15k).')

		elseif msgcontains(msg, 'golden legs') then
  			sell(cid,2470,getCount(msg),80000)
		elseif msgcontains(msg, 'crown legs') then
  			sell(cid,2488,getCount(msg),15000)
		elseif msgcontains(msg, 'knight legs') then
  			sell(cid,2477,getCount(msg),6000)
		elseif msgcontains(msg, 'plate legs') then
  			sell(cid,2647,getCount(msg),500)
  		elseif msgcontains(msg, 'brass legs') then
  			sell(cid,2478,getCount(msg),100)
 		elseif msgcontains(msg, 'chain legs') then
  			sell(cid,2478,getCount(msg),50)
  		elseif msgcontains(msg, 'legs')  then
  			selfSay('I buy golden (80k), crown (15k), knight (6k), plate (500gp), brass (100gp) and chain legs (50gp).')

  		elseif msgcontains(msg, 'shield of the mastermind') or msgcontains(msg, 'mms') then
  			sell(cid,2514,getCount(msg),80000)
		elseif msgcontains(msg, 'demon shield') then
  			sell(cid,2520,getCount(msg),40000)
		elseif msgcontains(msg, 'blessed shield') then
  			sell(cid,2523,getCount(msg),150000)
		elseif msgcontains(msg, 'great shield') then
  			sell(cid,2522,getCount(msg),100000)
  		elseif msgcontains(msg, 'vampire shield') then
  			sell(cid,2534,getCount(msg),25000)
		elseif msgcontains(msg, 'medusa shield') then
  			sell(cid,2536,getCount(msg),8000)
  		elseif msgcontains(msg, 'amazon shield') then
  			sell(cid,2537,getCount(msg),4000)
		elseif msgcontains(msg, 'crown shield') then
  			sell(cid,2519,getCount(msg),5000)
  		elseif msgcontains(msg, 'tower shield') then
  			sell(cid,2528,getCount(msg),4000)
  		elseif msgcontains(msg, 'dragon shield') then
  			sell(cid,2516,getCount(msg),3000)
		elseif msgcontains(msg, 'guardian shield') then
  			sell(cid,2515,getCount(msg),2000)
		elseif msgcontains(msg, 'beholder shield') then
  			sell(cid,2518,getCount(msg),1500)
		elseif msgcontains(msg, 'dwarven shield') then
  			sell(cid,2525,getCount(msg),100)
		elseif msgcontains(msg, 'shields')  then
  			selfSay('I buy blessed (150k), great (100k), demon (40k), vampire (25k), medusa (8k), amazon (4k), crown (5k), tower (4k), dragon (3k), guardian (2k), beholder (1k), and dwarven shields (100gp), also mms (80k)')

  		elseif msgcontains(msg, 'magic longsword') then
  			sell(cid,2390,getCount(msg),150000)
		elseif msgcontains(msg, 'warlord sword') then
  			sell(cid,2408,getCount(msg),100000)
		elseif msgcontains(msg, 'magic sword') then
  			sell(cid,2400,getCount(msg),90000)
		elseif msgcontains(msg, 'giant sword') then
  			sell(cid,2393,getCount(msg),10000)
		elseif msgcontains(msg, 'bright sword') then
  			sell(cid,2407,getCount(msg),6000)
		elseif msgcontains(msg, 'ice rapier')  then
  			sell(cid,2396,getCount(msg),4000)
		elseif msgcontains(msg, 'fire sword') then
  			sell(cid,2392,getCount(msg),3000)
		elseif msgcontains(msg, 'serpent sword')  then
  			sell(cid,2409,getCount(msg),1500)
		elseif msgcontains(msg, 'spike sword')  then
  			sell(cid,2383,getCount(msg),800)
  		elseif msgcontains(msg, 'two handed sword')  then
  			sell(cid,2377,getCount(msg),400)
		elseif msgcontains(msg, 'broad sword') then
  			sell(cid,2413,getCount(msg),70)
		elseif msgcontains(msg, 'short sword') then
  			sell(cid,2406,getCount(msg),30)
		elseif msgcontains(msg, 'sabre') then
  			sell(cid,2385,getCount(msg),25)
  		elseif msgcontains(msg, 'sword')  then
  			sell(cid,2376,getCount(msg),25)
		elseif msgcontains(msg, 'swords')  then
  			selfSay('I buy giant (10k), bright (6k), fire (3k) serpent (1.5k), spike (800gp) and two handed swords (400gp), also ice rapiers (4k), magic longswords (150k), magic swords (90k), warlord swords (100k) broad swords (70gp), short swords (30gp), sabres (25gp) and swords (25gp).')

  		elseif msgcontains(msg, 'dragon lance')  then
  			sell(cid,2414,getCount(msg),10000)
		elseif msgcontains(msg, 'stonecutters axe')  then
  			sell(cid,2431,getCount(msg),90000)
		elseif msgcontains(msg, 'guardian halberd')  then
  			sell(cid,2427,getCount(msg),7500)
  		elseif msgcontains(msg, 'fire axe')  then
  			sell(cid,2432,getCount(msg),10000)
		elseif msgcontains(msg, 'knight axe')  then
  			sell(cid,2430,getCount(msg),2000)
		elseif msgcontains(msg, 'double axe')  then
  			sell(cid,2387,getCount(msg),200)
		elseif msgcontains(msg, 'halberd')  then
  			sell(cid,2381,getCount(msg),200)
		elseif msgcontains(msg, 'battle axe')  then
  			sell(cid,2378,getCount(msg),100)
  		elseif msgcontains(msg, 'hatchet')  then
  			sell(cid,2388,getCount(msg),20)
		elseif msgcontains(msg, 'axes')  then
  			selfSay('I buy fire (10k), guardian halberds (7,5k) knight (2k), double (200gp) and battle axes (100gp), also dragon lances (10k), stonecutters axes (90k), halberds (200gp) and hatchets (20gp).')

		elseif msgcontains(msg, 'war hammer') then
  			sell(cid,2391,getCount(msg),6000)
		elseif msgcontains(msg, 'thunder hammer') then
  			sell(cid,2421,getCount(msg),90000)
		elseif msgcontains(msg, 'skull staff') then
  			sell(cid,2436,getCount(msg),10000)
  		elseif msgcontains(msg, 'dragon hammer')  then
  			sell(cid,2434,getCount(msg),2000)
  		elseif msgcontains(msg, 'clerical mace')  then
  			sell(cid,2423,getCount(msg),200)
  		elseif msgcontains(msg, 'battle hammer')  then
  			sell(cid,2417,getCount(msg),60)
  		elseif msgcontains(msg, 'mace') then
  			sell(cid,2398,getCount(msg),30)
		elseif msgcontains(msg, 'clubs')  then
  			selfSay('I buy thunder hammers (90k), war (6k), dragon (2k) and battle hammers (60gp), also skull staffs (10k) and clerical maces (200gp).')

		elseif msgcontains(msg, 'platinum amulet') then
  			sell(cid,2171,getCount(msg),5000)
		elseif msgcontains(msg, 'scarf') then
  			sell(cid,2661,getCount(msg),1000)
		elseif msgcontains(msg, 'amulets')  then
  			selfSay('I buy platinum amulets (5k) and scarfs (1k).')

  		elseif string.find(msg, '(%a*)bye(%a*)')  and getDistanceToCreature(cid) < 4 then
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
