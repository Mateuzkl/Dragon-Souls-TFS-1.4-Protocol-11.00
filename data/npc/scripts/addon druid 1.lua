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

		post = getPlayerStorageValue(cid,2078)
		addon = getPlayerStorageValue(cid,40002)
		addon_need_premium = 'Sorry, you need a premium account to get addons.'
		addon_have_already = 'Sorry, you already have this addon.'
		addon_have_not_items = 'Sorry, you don\'t have these items.'
		
	
		if msgcontains(msg, 'job') then
			selfSay('I am an adventurer, seeking knownledge!')

		elseif msgcontains(msg, 'offer') then
			selfSay('Hmm... Now i don\'t have nothing ready, but... come again later!')

		elseif msgcontains(msg, 'sell') then
			selfSay('I don\'t have nothing already done!')

		elseif msgcontains(msg, 'buy') then
			selfSay('Oh, i am not buing anything!')

		elseif msgcontains(msg, 'quest') then
			selfSay('I am not geting involved in quests anymore!')

		elseif msgcontains(msg, 'mission') then
			selfSay('I am not geting involved in missions anymore!')

		elseif msgcontains(msg, 'knownledge') then
			selfSay('I have been in long trips and quests! One more dangerous than the other, now i am studing the druid necromant powers!')

		elseif msgcontains(msg, 'paws') and addon == -1 then
				selfSay('What about it?')

		elseif msgcontains(msg, 'addon') and addon == 1 then
				selfSay('You will love this paws!')

		elseif msgcontains(msg, 'paws') and addon >= 2 then
				selfSay('I have done a great job on yours. Hehe.')

		elseif msgcontains(msg, 'addon') and addon >= 2 then
				selfSay('I have done a great job on yours. Hehe.')

-- addon (busca)

		elseif msgcontains(msg, 'addon') and addon == -1 then
			if isPremium(cid) then
				selfSay('Would you like to wear bear paws like I do?')
				talk_state = 2
			else
				selfSay(addon_need_premium)
				talk_state = 0
			end


		elseif msgcontains(msg, 'yes') and talk_state == 2 then
				selfSay('No problem, just bring me 50 bear paws and 50 wolf paws and I\'ll fit them on.')
				doPlayerSendTextMessage(cid,19,"Nova quest adicionada '(Addon) Druid Bear Paws.'.")
  				doSendMagicEffect(getPlayerPosition(cid),12)
				setPlayerStorageValue(cid,40002,1)
				talk_state = 0

-- addon (entrega)

		elseif msgcontains(msg, 'paws') and addon == 1 then
			if isPremium(cid) then
				selfSay('Have you brought 50 bear paws and 50 wolf paws?')
				talk_state = 3
			else
				selfSay(addon_need_premium)
				talk_state = 0
			end
				
		elseif msgcontains(msg, 'yes') and talk_state == 3 then
			if getPlayerItemCount(cid,5896) >= 50 and getPlayerItemCount(cid,5897) >= 50 then
				doPlayerTakeItem(cid,5896,50)
				doPlayerTakeItem(cid,5897,50)
				doPlayerAddAddon(cid, 148, 1)
				doPlayerAddAddon(cid, 144, 1)
  				doPlayerSendTextMessage(cid,19,"Quest '(Addon) Druid Bear Paws.' completada.")
  				doSendMagicEffect(getPlayerPosition(cid),12)
				setPlayerStorageValue(cid,40002,2)
				selfSay('Excellent! Like promised, here are your bear paws.')
				talk_state = 0
			else
				selfSay('You dont have the itens with you!')
			end


-- postman

		elseif msgcontains(msg, 'delivery') and post == 8 then
			if getPlayerFreeCap(cid) >= 500 then
				selfSay('Oh, you are late mrs.postman, I have an urgent delivery, i need you to take this stuff and give to Moriar, I think he may be in Caradhras, say about an delivery to him! Thanks and Fast! Here its for you buy a beer!')
				doPlayerAddItem(cid, 2152, 3)
  				uniform = doPlayerAddItem(cid,2330,1)
				doSetItemSpecialDescription(uniform,"It's your delivery.")
				doSetItemActionId(uniform,100)
  				doSendMagicEffect(getPlayerPosition(cid),12)
				setPlayerStorageValue(cid,2078,9)
				else
				selfSay('Oh, you are late mrs. postman, I have an urgent delivery, but I think you are out of capacity, you need 500 cap for this delivery!')
				end
				talk_state = 0


-- confirm no

		elseif msgcontains(msg, 'no') and (talk_state >= 1 and talk_state <= 34) then
			selfSay('Ok than.')
			talk_state = 0
		end

	-- fim
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())