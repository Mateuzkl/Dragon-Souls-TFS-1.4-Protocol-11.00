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
	-- Place all your code in here. Remember that hi, bye and all that stuff is already handled by the npcsystem, so you do not have to take care of that yourself.
	if(npcHandler.focus ~= cid) then
		return false
	end

		addon = getPlayerStorageValue(cid,40003)
		addon_need_premium = 'Sorry, you need a premium account to get addons.'
		addon_have_already = 'Sorry, you already have this addon.'
		
	
		if msgcontains(msg, 'job') then
			selfSay('I am the hunter guild master of this town!')

		elseif msgcontains(msg, 'offer') then
			selfSay('Hmm... Now i don\'t have nothing ready!')

		elseif msgcontains(msg, 'sell') then
			selfSay('I don\'t have nothing already done!')

		elseif msgcontains(msg, 'buy') then
			selfSay('Nah...')

		elseif msgcontains(msg, 'quest') then
			selfSay('I am not geting involved in quests anymore!')

		elseif msgcontains(msg, 'mission') then
			selfSay('I am not geting involved in missions anymore!')

		elseif msgcontains(msg, 'knownledge') then
			selfSay('I have been in long trips and quests! One more dangerous than the other, now i am just traveling and wondering the world beauties!')

		elseif msgcontains(msg, 'addon') then
				selfSay('I won those Sniper Gloves by my bravery!')

		elseif msgcontains(msg, 'sniper gloves') and addon == 2 then
				selfSay('You look great using them!')


-- addon (busca)

		elseif msgcontains(msg, 'sniper gloves') and addon == -1 then
			if isPremium(cid) then
				selfSay('That is an incredible rare item! If you find one, run and tell me, would you?')
				talk_state = 1
			else
				selfSay(addon_need_premium)
				talk_state = 0
			end


		elseif msgcontains(msg, 'yes') and talk_state == 1 then
				selfSay('Great! But i dont think you will find it in the next two months ha!')
				doPlayerSendTextMessage(cid,19,"Nova quest adicionada '(Addon) Sniper Gloves.'.")
  				doSendMagicEffect(getPlayerPosition(cid),12)
				setPlayerStorageValue(cid,40003,1)
		talk_state = 0

-- addon (entrega)

		elseif msgcontains(msg, 'sniper gloves') and addon == 1 then
			if isPremium(cid) then
				selfSay('You found sniper gloves?! Incredible! Listen, if you give them to me, I will grant you the right to wear the sniper gloves accessory. How about it?')
				talk_state = 2
			else
				selfSay(addon_need_premium)
				talk_state = 0
			end
				
		elseif msgcontains(msg, 'yes') and talk_state == 2 then
			if getPlayerItemCount(cid,5875) >= 1 then
				doPlayerTakeItem(cid,5875,1)
				doPlayerAddAddon(cid, 129, 2)
				doPlayerAddAddon(cid, 137, 1)
  				doPlayerSendTextMessage(cid,19,"Quest '(Addon) Sniper Gloves.' completada.")
  				doSendMagicEffect(getPlayerPosition(cid),12)
				setPlayerStorageValue(cid,40003,2)
				selfSay('Great! I hereby grant you the right to wear the sniper gloves as accessory. Congratulations!')
				talk_state = 0
			else
				selfSay('I knew that it was a lie! Where is it?')
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