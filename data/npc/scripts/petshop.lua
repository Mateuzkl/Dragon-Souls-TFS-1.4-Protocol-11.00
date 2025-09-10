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

		preco = getPlayerStorageValue(cid,60000)*500*getPlayerStorageValue(cid,60000)*getPlayerStorageValue(cid,60010)
		
	
		if msgcontains(msg, 'job') then
			selfSay('I am the owner of this PetShop.')

		elseif msgcontains(msg, 'offer') then
			selfSay('I can revive your pet.')

		elseif msgcontains(msg, 'sell') then
			selfSay('Sell What?')

		elseif msgcontains(msg, 'buy') then
			selfSay('Sorry but I do not sell those.')

		elseif msgcontains(msg, 'quest') then
			selfSay('I am not geting involved in quests anymore!')

		elseif msgcontains(msg, 'mission') then
			selfSay('I am not geting involved in missions anymore!')

-- addon (busca)

		elseif msgcontains(msg, 'revive') then
		if getPlayerStorageValue(cid,60000) >= 1 then
			selfSay('Want revive your pet for ' .. preco .. ' gps?')
			talk_state = 500
		else
			selfSay('You dont have any pet.')
			talk_state = 0
		end

	elseif talk_state == 500 then
	if msgcontains(msg, 'yes') then
	if getPlayerStorageValue(cid,60000) >= 1 then
	if getPlayerStorageValue(cid,60011) == 2 then
        if isPremium(cid) then
	if pay(cid,preco) then
		selfSay('live again!')
		doPlayerSendTextMessage(cid,22,"Voce reviveu seu pet.")
  		doSendMagicEffect(getPlayerPosition(cid),12)
		setPlayerStorageValue(cid,60005,1)
		setPlayerStorageValue(cid,60003,0)
		setPlayerStorageValue(cid,60011,1)
		talk_state = 0
		else
		selfSay('Sorry, but you dont have this monney!')
		talk_state = 0
		end
		else
		selfSay('Sorry, but only can revive pets of premium accounts.')
		talk_state = 0
		end
		else
		selfSay('Sorry, but your pet is alive!')
		talk_state = 0
		end
		else
		selfSay('Sorry, but you dont have an pet!')
		talk_state = 0
		end
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