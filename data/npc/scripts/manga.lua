
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

		promo = getPlayerStorageValue(cid,30002)
		
	
		if msgcontains(msg, 'job') then
			selfSay('I am a seller of exotics fruits!')

		elseif msgcontains(msg, 'offer') then
			selfSay('Hmm... Do you want prove my fruits!')

		elseif msgcontains(msg, 'sell') then
			selfSay('I am not a merchant!')

		elseif msgcontains(msg, 'buy') then
			selfSay('Nothing now!')

		elseif msgcontains(msg, 'quest') then
			selfSay('I dont share my quests with anyone!')

		elseif msgcontains(msg, 'mission') then
			selfSay('Not now, Jatu is a good assistent!')

-- promo

		elseif msgcontains(msg, 'orc place') then
			selfSay('Oh! Wanna know where is this orc place? Im busy now to show, ask this for my assistent Jatu, him show for you.')


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