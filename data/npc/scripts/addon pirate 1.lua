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
function onCreatureSay(cid, type, msg) 	npcHandler:onCreatureSay(cid, type, msg) end
function onThink() 						npcHandler:onThink() end


-- OTServ event handling functions end

function creatureSayCallback(cid, type, msg)
	-- Place all your code in here. Remember theadpiece hi, bye and all theadpiece stuff is already handled by the npcsystem, so you do not have to take care of theadpiece yourself.
	if(npcHandler.focus ~= cid) then
		return false
	end

		addon = getPlayerStorageValue(cid,40006)
		addon_need_premium = 'Sorry, you need a premium account to get addons.'
		addon_have_already = 'Sorry, you already have this addon.'
		addon_have_not_items = 'Sorry, you don\'t have these items.'
		
	
		if msgcontains(msg, 'job') then
			selfSay('I hunt boats! haha!')

		elseif msgcontains(msg, 'offer') then
			selfSay('The pirate wisdom is unshareable!')

		elseif msgcontains(msg, 'sell') then
			selfSay('I used to sell stuff.. but not anymore.')

		elseif msgcontains(msg, 'buy') then
			selfSay('No need for buy, we steal!')

		elseif msgcontains(msg, 'quest') then
			selfSay('Yeah, yeah... we make lots of quests, but i dont wana share them...')

		elseif msgcontains(msg, 'mission') then
			selfSay('Yeah, yeah... we make lots of missions, but i dont wana share them...')

		elseif msgcontains(msg, 'addon') and addon == 2 then
				selfSay('What are you waiting to find Morgan? Dont forget the secret word: firebird!')

		elseif msgcontains(msg, 'addon') and addon == 3 then
				selfSay('That looks great haha!')



-- addon (busca)

		elseif msgcontains(msg, 'addon') and addon == -1 then
			if isPremium(cid) then
				selfSay('Are you up to the task which Im going to give you and willing to prove youre worthy of wearing such a sabre?')
				talk_state = 2
			else
				selfSay(addon_need_premium)
				talk_state = 0
			end


		elseif msgcontains(msg, 'yes') and talk_state == 2 then
				selfSay('Listen, the task is not that hard. Simply prove that you are loyal by bringing me some pirate stuff. ...')
				selfSay('Bring me 100 eye patchs, 100 peg legs and 100 hooks, all together ...')
				selfSay('Have you understood everything I told you and are willing to handle this task?')
				talk_state = 10

		elseif msgcontains(msg, 'yes') and talk_state == 10 then
				doPlayerSendTextMessage(cid,19,"Nova quest adicionada '(Addon) Pirate Sabre.'.")
  				doSendMagicEffect(getPlayerPosition(cid),12)
				setPlayerStorageValue(cid,40006,1)
				talk_state = 0
				selfSay('Good. Bring me all at once! Just ask me about the Sabre!')

-- addon (entrega)

		elseif msgcontains(msg, 'sabre') and addon == 1 then
			if isPremium(cid) then
				selfSay('Have you gathered 100 eye patches, 100 peg legs and 100 hooks?')
				talk_state = 3
			else
				selfSay(addon_need_premium)
				talk_state = 0
			end
				
		elseif msgcontains(msg, 'yes') and talk_state == 3 then
			if getPlayerItemCount(cid,6098) >= 100 and getPlayerItemCount(cid,6097) >= 100 and getPlayerItemCount(cid,6126) >= 100 then
				doPlayerTakeItem(cid,6098,100)
				doPlayerTakeItem(cid,6097,100)
				doPlayerTakeItem(cid,6126,100)
  				doSendMagicEffect(getPlayerPosition(cid),12)
				setPlayerStorageValue(cid,40006,2)
				selfSay('I see, I see. Well done. Now find Morgan and tell him this codeword: firebird. Her know what to do...')
				talk_state = 0
			else
				selfSay('You dont have the itens with you!')
			end

------------------------------------------------ confirm no ------------------------------------------------
		elseif msgcontains(msg, 'no') and (talk_state >= 1 and talk_state <= 34) then
			selfSay('So why do you bother me?')
			talk_state = 0
		end

	-- Place all your code in here. Remember theadpiece hi, bye and all theadpiece stuff is already handled by the npcsystem, so you do not have to take care of theadpiece yourself.
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())