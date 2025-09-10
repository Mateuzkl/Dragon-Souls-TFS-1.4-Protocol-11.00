local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)



-- OTServ event handling functions start
function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) 	npcHandler:onCreatureSay(cid, type, msg) end
function onThink() 						npcHandler:onThink() end
-- OTServ event handling functions end

function creatureSayCallback(cid, type, msg)
	-- Place all your code in here. Remember that hi, bye and all that stuff is already handled by the npcsystem, so you do not have to take care of that yourself.
	if(npcHandler.focus ~= cid) then
		return false
	end

		abs = getPlayerStorageValue(cid,5908)
		black = getPlayerStorageValue(cid,2026)
		addon_need_premium = 'Sorry, you need a premium account to help me.'
		addon_have_already = 'Sorry, you already have helped me.'
		addon_have_not_items = 'Sorry, you don\'t have these items.'
		
	
		if msgcontains(msg, 'mission') and abs == -1 then
			selfSay('Oh, I dont have any mission for you, its only a favor, I will dance whit my wife on next tavern event, but she need one bast skirt, do you think you can find one for me?')
			talk_state = 2

		elseif msgcontains(msg, 'mission') and abs == 1 then
			selfSay('Oh, I said to you, its not a mission, its a favor, so... You bring me a bast skirt?')
			talk_state = 3

		elseif msgcontains(msg, 'mission') and abs >= 2 then
			selfSay('Oh, I dont have nothing to you at this moment.')
			talk_state = 0

		elseif msgcontains(msg, 'skirt') and abs == 1 then
			selfSay('Oh, I really need that! You bring me the bast skirt?')
			talk_state = 3

		elseif msgcontains(msg, 'draconian') and abs == 2 then
			selfSay('Oh, I can do one piece for you, only bring me a dragon shield, do you got one?')
			talk_state = 4

		elseif msgcontains(msg, 'draconian') and abs == 3 then
			selfSay('Oh, I really did one for you!')
			talk_state = 0

--

		elseif msgcontains(msg, 'materials') and black == -1 then
			selfSay('Oh, I need two Iron Nuggets to forge the BlackSmith Hammer, Do you think you can found TWO of this metal?')
			talk_state = 13

		elseif msgcontains(msg, 'materials') and black == 1 then
			selfSay('Oh, you again... Did you manage to found the materials I asked?')
			talk_state = 14

		elseif msgcontains(msg, 'materials') and black == 2 then
			selfSay('Nah.. I dont need anything now.')
			talk_state = 0

		elseif msgcontains(msg, 'blacksmith') and black == -1 then
			selfSay('I am looking for Materials to create and sell it!')
			talk_state = 0
		elseif msgcontains(msg, 'blacksmith') and black == 2 then
			selfSay('You already have yours!')
			talk_state = 0

--
		elseif msgcontains(msg, 'job') then
			selfSay('I am the BlackSmith Master of the town, say HELP for an forging tutorial')
			talk_state = 0
		elseif msgcontains(msg, 'help') then
			selfSay('First you have to go down to our mines and get some iron, then you place them in the anvil..hmm.. 10 should do it..say Continue')
			talk_state = 10
		elseif msgcontains(msg, 'continue') and talk_state == 10 then
			selfSay('With the iron placed there, you shoul hit it several times with an BlackSmith Hammer... you should get Iron Solid, Continue hitting it until you get an Weapon Model... say Continue')
			talk_state = 11
		elseif msgcontains(msg, 'continue') and talk_state == 11 then
			selfSay('When you get the Model , put it on the Fire Field and wait until it get realy hot, then you place it on the anvil and hit it with the hammer, when the smoke stops to come out...say Continue')
			talk_state = 12
		elseif msgcontains(msg, 'continue') and talk_state == 12 then
			selfSay('...when the smoke stops to come out you throw water on it. Simple!')
			talk_state = 0


-- missao yes 1

		elseif msgcontains(msg, 'yes') and talk_state == 2 then
			selfSay('OH! Thank you! Im really happy now! Im waiting you!')
			doPlayerSendTextMessage(cid,19,"Nova quest adicionada 'Mais que um favor!'.")
  			doSendMagicEffect(getPlayerPosition(cid),12)
			setPlayerStorageValue(cid,5908,1)
			talk_state = 0


		elseif msgcontains(msg, 'yes') and talk_state == 3 then
			if getPlayerItemCount(cid,3983) >= 1 then
				selfSay('OH! You are really a good friend! And by the way, I learnt how to forje a rare metal, the name is Draconian Steel, I can do one for you, only bring me a dragon shield, and ask me about draconian steel! Oh... My little dwarf will love that!')
				doPlayerTakeItem(cid,3983,1)
  				doSendMagicEffect(getPlayerPosition(cid),12)
				setPlayerStorageValue(cid,5908,2)
				talk_state = 0
				else
				selfSay('OH! But where it are?')
				end
				
		elseif msgcontains(msg, 'yes') and talk_state == 4 then
			if getPlayerItemCount(cid,2516) >= 1 then
				selfSay('OH! Here it is my friend! Willian would be crazy if he see that, hehe. Well, i need back to work! See Ya.')
				doPlayerTakeItem(cid,2516,1)
				doPlayerAddItem(cid,5889,1)
  				doSendMagicEffect(getPlayerPosition(cid),12)
				setPlayerStorageValue(cid,5908,3)
				talk_state = 0
				else
				selfSay('Oh! But i cant see the dragon shield.')
				end
				

-- blacksmith hammer 

		elseif msgcontains(msg, 'yes') and talk_state == 13 then
			selfSay('HAHA! Only the most Ancient Mines have it in their walls, I doubt you can found one , and i need TWO ha! Good Luck, You will need it!')
			doPlayerSendTextMessage(cid,19,"Nova quest adicionada 'Em busca dos materiais!'.")
  			doSendMagicEffect(getPlayerPosition(cid),12)
			setPlayerStorageValue(cid,2026,1)
			talk_state = 0

		elseif msgcontains(msg, 'yes') and talk_state == 14 then
			if getPlayerItemCount(cid,13641) >= 2 then
				selfSay('OH! You realy did it! Here is you hammer!')
				doPlayerTakeItem(cid,13641,2)
				doPlayerAddItem(cid,2321,1)
  				doSendMagicEffect(getPlayerPosition(cid),12)
				setPlayerStorageValue(cid,2026,2)
				talk_state = 0
				else
				selfSay('OH! But where are them?')
				end


------------------------------------------------ confirm no ------------------------------------------------
		elseif msgcontains(msg, 'no') and (talk_state >= 1 and talk_state <= 34) then
			selfSay('Ok than.')
			talk_state = 0
		end

	-- Place all your code in here. Remember that hi, bye and all that stuff is already handled by the npcsystem, so you do not have to take care of that yourself.
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- Don't forget npcHandler = npcHandler in the parameters. It is required for all StdModule functions!

keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I can teach you how to make itens by forging. But in the moment, I dont have the materials to make the Blacksmith Hammer.'})
keywordHandler:addKeyword({'sell'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Do i look like some Shopkeeper?'})
keywordHandler:addKeyword({'buy'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Do i look like some Shopkeeper?'})
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I have more important things to do.'})


-- Makes sure the npc reacts when you say hi, bye etc.
npcHandler:addModule(FocusModule:new())
