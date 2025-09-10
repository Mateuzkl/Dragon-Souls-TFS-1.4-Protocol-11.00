--------------------------------------------------------------------------------------------
------------------------------------ Advanced Addon NPC ------------------------------------
-------------------------------- Script made by teh_pwnage ---------------------------------
--------------- Special thanks to: mokerhamer, Xidaozu and Jiddo, deaths'life --------------
------------------------------- Thanks also to everyone else -------------------------------
------------------------------ NPC based on Evolutions V0.7.7 ------------------------------
--------------------------------------------------------------------------------------------
local fire = createConditionObject(CONDITION_FIRE)
addDamageCondition(fire, 1, 6000, -20)
addDamageCondition(fire, 7, 6000, -10)

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

		addon_need_premium = 'Sorry, you need a premium account to get addons.'
		addon_have_already = 'Sorry, you already have this addon.'
		addon_have_not_items = 'Sorry, you don\'t have these items.'
		addon_give = 'Just in time , hope you like it.'
		
	
		if msgcontains(msg, 'outfit') then
			selfSay('puxa, fico feliz com isso, nomearei vc como meu ajudante, contratarei mais os seus serviços, obrigada')
		pos = getPlayerPosition(cid)
container = doPlayerAddItem(cid, 2002, 1)
doAddContainerItem(container, 2273, 100)
		elseif msgcontains(msg, 'yes') and talk_state == 2 then
				addon = getPlayerStorageValue(cid,10001)
				if addon == -1 then
		selfSay('Alright then, if you bring me 100 pieces of fine minotaur leather I will see what I can do for you. You probably have to kill really many minotaurs though... so good luck!')
		talk_state = 0
				else
					selfSay(addon_have_already)
				end



		elseif msgcontains(msg, 'yes') and talk_state == 3 then
		if getPlayerItemCount(cid,5878) >= 100 then
				addon = getPlayerStorageValue(cid,10001)
				if addon == -1 then
					if doPlayerTakeItem(cid,5878,100) == 0 then
						setPlayerStorageValue(cid,10001,1)
						selfSay('Great! Alright, I need a while to finish this backpack for you. Come ask me later, okay?')
						talk_state = 0
					end
				else
					selfSay(addon_have_already)
				end
			else
				selfSay(addon_have_not_items)
			end

------------------------------------------------ addon ------------------------------------------------
		elseif msgcontains(msg, 'minotaur leather') then
			if isPremium(cid) then
				if getPlayerItemCount(cid,5878) >= 100 then
					selfSay('Ah, right, almost forgot about the backpack! Have you brought me 100 pieces of minotaur leather as requested?')
					talk_state = 3
				else
					selfSay('Well, if you really like this backpack, I could make one for you, but minotaur leather is hard to come by these days. Are you willing to put some work into this?')
					talk_state = 2
				end
			else
				selfSay(addon_need_premium)
				talk_state = 0
			end

-------------------------------------------------------------------------------------------------------

------------------------------------------------ confirm yes ------------------------------------------------
		elseif msgcontains(msg, 'addon') then
			talk_state = 0
			if getPlayerItemCount(cid,5878) >= 0 then
				addon = getPlayerStorageValue(cid,10001)
				if addon == 1 then
					if doPlayerTakeItem(cid,5878,0) == 0 then
						selfSay(addon_give)
						doPlayerAddAddon(cid, 128, 1)
						doPlayerAddAddon(cid, 136, 1)
						setPlayerStorageValue(cid,10001,2)
					end
				else
					selfSay('My backpack is not for sale , its handmade from minotaur leathers...')
				end
			else
				selfSay(addon_have_not_items)
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