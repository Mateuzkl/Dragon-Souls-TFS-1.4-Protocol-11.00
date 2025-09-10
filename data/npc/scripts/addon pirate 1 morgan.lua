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

		elseif msgcontains(msg, 'firebird') and addon == -1 then
				selfSay('Get Lost...')

		elseif msgcontains(msg, 'firebird') and addon == 1 then
				selfSay('Get Lost...')

		elseif msgcontains(msg, 'firebird') and addon == 3 then
				selfSay('You proved to be loyal, hehe.')



-- addon (busca)

		elseif msgcontains(msg, 'firebird') and addon == 2 then
			if isPremium(cid) then
				selfSay('Ahh. So Duncan sent you, eh? You must have done something really impressive. Okay, take this fine sabre from me, mate.')
  				doPlayerAddAddon(cid, 155, 1)
				doPlayerAddAddon(cid, 151, 1)
				doPlayerSendTextMessage(cid,19,"Quest '(Addon) Pirate Sabre.' completada.")
  				doSendMagicEffect(getPlayerPosition(cid),12)
				setPlayerStorageValue(cid,40006,3)
			else
				selfSay(addon_need_premium)
				talk_state = 0
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