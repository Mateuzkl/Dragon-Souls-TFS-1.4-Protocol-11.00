
--------------------------------------------------------------------------------------------
------------------------------------ Advanced Addon NPC ------------------------------------
-------------------------------- Script made by teh_pwnage ---------------------------------
--------------- Special thanks to: mokerhamer, Xidaozu and Jiddo, deaths'life --------------
------------------------------- Thanks also to everyone else -------------------------------
------------------------------ NPC based on Evolutions V0.7.7 ------------------------------
--------------------------------------------------------------------------------------------

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

-- OTServ event handling functions start
function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)                         npcHandler:onCreatureSay(cid, type, msg) end
function onThink() 						npcHandler:onThink() end


-- OTServ event handling functions end

function creatureSayCallback(cid, type, msg)
	-- Place all your code in here. Remember that hi, bye and all that stuff is already handled by the npcsystem, so you do not have to take care of that yourself.
	if(npcHandler.focus ~= cid) then
		return false
	end

		addon = getPlayerStorageValue(cid,30002)
		parte2 = getPlayerStorageValue(cid,31000)
		parte3 = getPlayerStorageValue(cid,31001)
		addon_need_premium = 'Sorry, you need a premium account to help me.'
		addon_have_already = 'Sorry, you already have helped me.'
		addon_have_not_items = 'Sorry, you don\'t have these items.'
		
	
		if msgcontains(msg, 'backpack') then
			selfSay('Oh, the backpack wasnt so important, but i lost a map inside it, the map was stolen from orcs.')
			talk_state = 1

		elseif msgcontains(msg, 'job') then
			selfSay('I am a treasure hunter!')

		elseif msgcontains(msg, 'offer') then
			selfSay('I am not selling or buing nothing!')

		elseif msgcontains(msg, 'sell') then
			selfSay('I am not a merchant!')

		elseif msgcontains(msg, 'buy') then
			selfSay('I am not a merchant!')

		elseif msgcontains(msg, 'quest') then
			selfSay('I dont share my quests with anyone!')

		elseif msgcontains(msg, 'mission') then
			selfSay('I dont share my quests with anyone!')

-- mapas

	elseif msgcontains(msg, 'map') and addon == -1 and talk_state == 1 then
			selfSay('It was wroten in Orchish, i didnt traslate it all. Oh , i need it back! Find it for me PLEASE!')
			doPlayerSendTextMessage(cid,19,"Nova quest adicionada 'O segredo de Kar'ce'.")
  			doSendMagicEffect(getPlayerPosition(cid),12)
			setPlayerStorageValue(cid,30002,1)
			talk_state = 0

	elseif msgcontains(msg, 'map') and addon == 1 then
		if getPlayerItemCount(cid,1956) >= 1 then
			selfSay('I cant belive it! How did you get it back? Many thanks and.. Oh! i need an assistent, would you be interested?')
			talk_state = 3
			else
			selfSay('I need it back! Find it for me PLEASE!')	
				end
		
	elseif msgcontains(msg, 'map') and addon == 2 then
			selfSay('E entao? Estou ancioso para saber das novidades.')
			talk_state = 4
		
	elseif msgcontains(msg, 'map') and parte2 == 2 and addon == 2 then
			selfSay('Map? The map not is more important now, tell me, what is the news?')
			talk_state = 5

	elseif msgcontains(msg, 'map') and parte3 == 1 and addon == 2 then
			selfSay('Map? Why you stay saying map to me? Go find Thordain!')
			talk_state = 5

-- entrega do mapa

		elseif msgcontains(msg, 'yes') and talk_state == 3 then
		if getPlayerItemCount(cid,1956) >= 1 then
				addon = getPlayerStorageValue(cid,30002)
				if addon == 1 then
					if doPlayerTakeItem(cid,1956,100) == 0 then
						selfSay('You are not with it!')
						else
  					doSendMagicEffect(getPlayerPosition(cid),12)
						setPlayerStorageValue(cid,30002,2)
						setPlayerStorageValue(cid,31000,1)
					doPlayerTakeItem(cid,1956,1)
						selfSay('Great! Right let me see... Here in the map, i dont now the right place but is next to my body, where you found my body, there is place to dig, good luck and later bring me news!')
						talk_state = 0
					end
				else
					selfSay(addon_have_already)
				end
			else
				selfSay("Hey, i see on your hand, where are the map?")
			end

-- novidades

		elseif msgcontains(msg, 'news') and talk_state == 4 or
			msgcontains(msg, 'news') and addon == 2 then
				selfSay('So! What news you got for me?')
				talk_state = 5

	elseif talk_state == 5 then
		if msgcontains(msg, 'kar') then
				if getPlayerItemCount(cid,2392) >= 1 then
				if parte2 == 2 then
				selfSay('Wow! I cant believe! That on your hand is The flame of Kar\'ce?! Oh God, go talk about Kar\'ce whit Thordain! ')
				selfSay('Good luck!')
  				doSendMagicEffect(getPlayerPosition(cid),12)
				setPlayerStorageValue(cid,31001,1)
				talk_state = 0
				else
				selfSay('Wow! How you know that?')
				talk_state = 5
				end
				else
				selfSay('Wow! really? But you dont find any item?')
				talk_state = 5
				end
			else
				selfSay("Hmm... Im losted now, what this can help us?")
				talk_state = 0
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
npcHandler:addModule(FocusModule:new())