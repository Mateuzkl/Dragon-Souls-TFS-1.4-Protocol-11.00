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

		addon = getPlayerStorageValue(cid,40000)
		addon_need_premium = 'Sorry, you need a premium account to get addons.'
		addon_have_already = 'Sorry, you already have this addon.'
		addon_have_not_items = 'Sorry, you don\'t have these items.'
		addon_give = 'Just in time! Your backpack is finished. Here you go, I hope you like it.'
		
	
		if msgcontains(msg, 'job') then
			selfSay('I am a traveler, lost in the wonders of this world!')

		elseif msgcontains(msg, 'offer') then
			selfSay('The only thing i can offer you is the knownledge of what i have experienced until now!')

		elseif msgcontains(msg, 'sell') then
			selfSay('I am not a merchant!')

		elseif msgcontains(msg, 'buy') then
			selfSay('I am not a merchant!')

		elseif msgcontains(msg, 'quest') then
			selfSay('I am not geting involved in quests anymore!')

		elseif msgcontains(msg, 'mission') then
			selfSay('I am not geting involved in missions anymore!')

		elseif msgcontains(msg, 'knownledge') then
			selfSay('I have been in long trips and quests! One more dangerous than the other, now i am just traveling and wondering the world beauties!')


		elseif msgcontains(msg, 'addon') and addon == 1 then
				selfSay('You will like this backpack, im promess!')

		elseif msgcontains(msg, 'backpack') and addon == -1 then
				selfSay('Pretty, isn\'t?!')

		elseif msgcontains(msg, 'backpack') and addon == 2 then
				selfSay('You will like your new addon!')

		elseif msgcontains(msg, 'addon') and addon == 3 then
				selfSay('Sorry, i can\'t give another for you.')

		elseif msgcontains(msg, 'backpack') and addon == 3 then
				selfSay('Hmm... Any problem whit your backpack?')

-- addon (busca)

		elseif msgcontains(msg, 'addon') and addon == -1 then
			if isPremium(cid) then
				selfSay('Sorry, this backpack is not for sale, it\'s handmade from rare minotaur leather.')
				talk_state = 1
			else
				selfSay(addon_need_premium)
				talk_state = 0
			end

	elseif msgcontains(msg, 'minotaur leather') and addon == -1 and talk_state == 1 then
				selfSay('Well, if you really like this backpack, I could make one for you, but minotaur leather is hard to come by these days. Are you willing to put some work into this?')
				talk_state = 2

		elseif msgcontains(msg, 'yes') and talk_state == 2 then
				selfSay('Alright then, if you bring me 100 pieces of fine minotaur leather I will see what I can do for you. You probably have to kill really many minotaurs though... So good luck!')
			doPlayerSendTextMessage(cid,19,"Nova quest adicionada '(Addon) Citizen Backpack.'.")
  				doSendMagicEffect(getPlayerPosition(cid),12)
				setPlayerStorageValue(cid,40000,1)
				talk_state = 0

-- addon (entrega)


		elseif msgcontains(msg, 'backpack') and addon == 1 then
			if isPremium(cid) then
				selfSay('Ah, right, almost forgot about the backpack! Have you brought me 100 pieces of minotaur leather as requested?')
				talk_state = 3
			else
				selfSay(addon_need_premium)
				talk_state = 0
			end


		elseif msgcontains(msg, 'yes') and talk_state == 3 then
			if getPlayerItemCount(cid,5878) >= 100 then
  			if (alert(cid, storevalue, alerttime) == 0) then
				selfSay('msg nunca lida')
			else
				selfSay('Great! Alright, I need a while, maybe 1 hour to finish this backpack for you. Come ask me later, okay?')
				doPlayerTakeItem(cid,5878,100)
  				doSendMagicEffect(getPlayerPosition(cid),12)
				setPlayerStorageValue(cid,40000,2)
				talk_state = 0
			end
			else
				selfSay(addon_have_not_items)
			end

-- addon (recebendo)

  		storevalue = 7000
  		alerttime = 3600

		elseif msgcontains(msg, 'addon') and addon == 2 then
  			if (alert(cid, storevalue, alerttime) == 0) then
				selfSay('The backpack is not done yet, come back later.')
			else
				selfSay(addon_give)
				doPlayerAddAddon(cid, 128, 1)
				doPlayerAddAddon(cid, 136, 1)
  			doPlayerSendTextMessage(cid,19,"Quest '(Addon) Citizen Backpack.' completada.")
  				doSendMagicEffect(getPlayerPosition(cid),12)
				setPlayerStorageValue(cid,40000,3)
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