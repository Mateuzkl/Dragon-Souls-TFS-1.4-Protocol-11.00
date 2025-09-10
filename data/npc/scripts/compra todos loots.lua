local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)



-- OTServ event handling functions start
function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) 	


npcHandler:onCreatureSay(cid, type, msg) end
function onThink() 						npcHandler:onThink() end
-- OTServ event handling functions end

function creatureSayCallback(cid, type, msg)
	if(npcHandler.focus ~= cid) then
		return false
	end

	novice = getPlayerStorageValue(cid,1002)
	voc = getPlayerVocation(cid)

	if msgcontains(msg, 'novice') and voc == 1 then
	if novice == 2 then
 		selfSay('Hello novice! I got an thing to help you, get!')
 		selfSay('But now i need work! Next please...')
     		doPlayerSendTextMessage(cid,22,"You receive an wand of vortex.")
		doPlayerAddItem(cid,2190,1)
		setPlayerStorageValue(cid,1002,3)
  		focus = 0
  		talk_start = 0
		else
 		selfSay('Hmm... You dont look like a novice... Sorry!')
  		focus = 0
  		talk_start = 0
		end

	elseif msgcontains(msg, 'novice') and voc == 2 then
	if novice == 2 then
 		selfSay('Hello novice! I got an thing to help you, get!')
 		selfSay('But now i need work! Next please...')
     		doPlayerSendTextMessage(cid,22,"You receive an snakebite rod.")
		doPlayerAddItem(cid,2182,1)
		setPlayerStorageValue(cid,1002,3)
  		focus = 0
  		talk_start = 0
		else
 		selfSay('Hmm... You dont look like a novice... Sorry!')
  		focus = 0
  		talk_start = 0
		end

	elseif msgcontains(msg, 'novice') and voc == 3 then
	if novice == 2 then
 		selfSay('Hello novice! I got an thing to help you, get!')
 		selfSay('But now i need work! Next please...')
     		doPlayerSendTextMessage(cid,22,"You receive an Dark helmet.")
		doPlayerAddItem(cid,2490,1)
		setPlayerStorageValue(cid,1002,3)
  		focus = 0
  		talk_start = 0
		else
 		selfSay('Hmm... You dont look like a novice... Sorry!')
  		focus = 0
  		talk_start = 0
		end

	elseif msgcontains(msg, 'novice') and voc == 4 then
	if novice == 2 then
 		selfSay('Hello novice! I got an thing to help you, get!')
 		selfSay('But now i need work! Next please...')
     		doPlayerSendTextMessage(cid,22,"You receive an morning star and an steel shield.")
		doPlayerAddItem(cid,2394,1)
		doPlayerAddItem(cid,2509,1)
		setPlayerStorageValue(cid,1002,3)
  		focus = 0
  		talk_start = 0
		else
 		selfSay('Hmm... You dont look like a novice... Sorry!')
  		focus = 0
  		talk_start = 0
		end

  	elseif string.find(msg, '(%a*)bye(%a*)')  and getDistanceToCreature(cid) < 5 then
  		focus = 0
  		talk_start = 0
end

	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)


-- Don't forget npcHandler = npcHandler in the parameters. It is required for all StdModule functions!
keywordHandler:addKeyword({'helmets'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I buy royal (30k), warrior (4k), crusader (5k), crown (3k), devil (900gps), chain (100gps), iron (300gps), strange (1k), soldier (50gps), viking (140gps), brass (60gps), dark (200gps) also mystic turbans (1k).'})

keywordHandler:addKeyword({'boots'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I buy steel boots (100k) and boots of haste (40k).'})

keywordHandler:addKeyword({'armors'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I buy golden (30k), crown (20k), knight (5k), lady (6k), plate (500gps), brass (300gps), dark (1k), scale (150gps) and chain armors (140gps) also dragon scale mail (50k), magic plate armor (100k) and blue robes (10k).'})

keywordHandler:addKeyword({'legs'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I buy golden (70k), crown (30k), knight (10k), plate (1k), chain (50gps) and brass legs (100gps).'})

keywordHandler:addKeyword({'shields'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I buy demon (40k), vampire (20k), medusa (10k), amazon (5k), crown (8k), tower (8k), dragon (8k), guardian (3k), beholder (2k), battle (200gps), plate (100gps), steel (160gps), scarab (2k), castle (1k) and dwarven shields (200gps), also mastermind shield (70k).'})

keywordHandler:addKeyword({'swords'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I buy giant (30k), bright (20k), fire (7k) serpent (1k), spike (500gps) and two-handed swords (900gps), also ice rapiers (2k), broad swords (500gps), longsword (100gps), short swords (60gps), sabres (50gps), katana (30gps) and swords (50gps).'})

keywordHandler:addKeyword({'axes'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I buy fire (8k), guardian halberds (10k) knight (3k), barbarian (300gps), obsidian lances (1k), double (520gps) and battle axes (160gps), also dragon lances (25k) and golden sickles (600gps), halberds (800gps) and hatchets (50gps).'})

keywordHandler:addKeyword({'clubs'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I buy dragon (3k), war hammers (2k) and battle hammers (240gps), mace (60gps), morning stars (200gps) also skull staffs (10k) and clerical maces (400gps).'})


keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am the owner of this weapon shop.'})
keywordHandler:addKeyword({'mission'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I have no ones for you now.'})
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I have no ones for you now.'})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am buing swords,axes,clubs,helmets,armors,legs,shields and boots.'})

-- Makes sure the npc reacts when you say hi, bye etc.
npcHandler:addModule(FocusModule:new())