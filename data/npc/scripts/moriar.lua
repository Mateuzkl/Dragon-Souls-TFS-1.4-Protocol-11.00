
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

		post = getPlayerStorageValue(cid,2078)

	
		if msgcontains(msg, 'delivery') and post == 0 then
			selfSay('What tha hec... It\'s empty! I will talk about your work with your boss!')
			doPlayerTakeItem(cid,1993,1)
			talk_state = 0

		elseif msgcontains(msg, 'job') then
			selfSay('I fish something in our ice rivers!')

		elseif msgcontains(msg, 'offer') then
			selfSay('I am not selling or buing nothing!')

		elseif msgcontains(msg, 'sell') then
			selfSay('Haha, sorry, not today!')

		elseif msgcontains(msg, 'buy') then
			selfSay('No , no merchant')

		elseif msgcontains(msg, 'quest') then
			selfSay('Not involved.. you know!')

		elseif msgcontains(msg, 'mission') then
			selfSay('Not involved.. you know!')

-- postman

		elseif msgcontains(msg, 'delivery') and post == 9 then
		if getPlayerItemCount(cid,2330) >= 1 then
			selfSay('Oh, thanks god, i will realy need this, talk with your boss about promotion, you deserve it, here is something for you.')
			doPlayerAddItem(cid, 2152, 4)
  			doSendMagicEffect(getPlayerPosition(cid),12)
			setPlayerStorageValue(cid,2078,10)
			doPlayerTakeItem(cid,2330,1)
			talk_state = 0
			else
			selfSay('So were is my delivery?')
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