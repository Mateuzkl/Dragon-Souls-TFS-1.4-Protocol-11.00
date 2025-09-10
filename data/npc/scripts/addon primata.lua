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

		addon = getPlayerStorageValue(cid,51003)
		addon_need_premium = 'Sorry, you need a premium account to get addons.'
		addon_have_already = 'Sorry, you already have this addon, now get out of here!'
		
	
		if msgcontains(msg, 'job') then
			selfSay('I am the leader of this place, but I aint got jobs for you, human!')

		elseif msgcontains(msg, 'offer') then
			selfSay('Hmm... Now I don\'t have nothing ready!')

		elseif msgcontains(msg, 'sell') then
			selfSay('I don\'t have nothing already done!')

		elseif msgcontains(msg, 'buy') then
			selfSay('Nah...')

		elseif msgcontains(msg, 'quest') then
			selfSay('I am not getting involved in quests anymore, too old for that!')

		elseif msgcontains(msg, 'mission') then
			selfSay('I am not getting involved in missions anymore!')

		elseif msgcontains(msg, 'knownledge') then
			selfSay('I have been in long trips and quests! One more dangerous than the other, now I am just takin care of here!')

		elseif msgcontains(msg, 'addon') then
				selfSay('Huh, I am the leader here! Thats why I am using it! Its called Beggar staff!')

		elseif msgcontains(msg, 'beggar staff') and addon == 2 then
				selfSay('It seems that you already got one! Leave me ALONE!!')


-- addon (busca)

		elseif msgcontains(msg, 'beggar staff') and addon == -1 then
			if isPremium(cid) then
				selfSay('A really new and innovative look would be - the poor man\'s look! I can already see it in front of me... yes... a little ragged... but not too shabby!...')
                                selfSay('Let me see... I can do one staff for you... but before, you gotta look for my staff!! Can you bring it to me?')
				talk_state = 1
			else
				selfSay(addon_need_premium)
				talk_state = 0
			end


		elseif msgcontains(msg, 'yes') and talk_state == 1 then
				selfSay('Terrific! What are you waiting for?!! Start right away to gather your staff and get your outfit!!')
				doPlayerSendTextMessage(cid,19,"Nova quest adicionada '(Addon) Beggar staff.'.")
  				doSendMagicEffect(getPlayerPosition(cid),12)
				setPlayerStorageValue(cid,51003,1)
		talk_state = 0

-- addon (entrega)

		elseif msgcontains(msg, 'beggar staff') and addon == 1 then
			if isPremium(cid) then
				selfSay('Ah! Have found sniper the staff? Incredible! I will immediately start to work on this outfit! What about that?')
				talk_state = 2
			else
				selfSay(addon_need_premium)
				talk_state = 0
			end
				
		elseif msgcontains(msg, 'yes') and talk_state == 2 then
			if getPlayerItemCount(cid,6107) >= 1 then
				doPlayerTakeItem(cid,6107,1)
				doPlayerAddAddon(cid, 153, 2)
  				doPlayerSendTextMessage(cid,19,"Quest '(Addon) Beggar Staff.' completada.")
  				doSendMagicEffect(getPlayerPosition(cid),12)
				setPlayerStorageValue(cid,51003,2)
				selfSay('This is it! Alas, the poor man\'s outfit is finished, but... to be honest... it turned out much less appealing than I expected. However, you can use it if you want, okay?')
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