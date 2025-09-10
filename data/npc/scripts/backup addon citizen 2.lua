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

		addon_need_premium = 'Sorry, you need a premium account to get addons.'
		addon_have_already = 'Sorry, you already have this addon.'
		addon_have_not_items = 'Sorry, you don\'t have these items.'
		addon_give = 'Great job! That must have taken a lot of work. Okay, you put it like this... then glue like this... here!.'
		
	
		if msgcontains(msg, 'addon') then
			selfSay('Pretty, isnt it? I love wearing this outfit!')

		elseif msgcontains(msg, 'job') then
			selfSay('I am an adventurer , i have no home , so i put my step on the road!')

		elseif msgcontains(msg, 'offer') then
			selfSay('The only thing i can offer you is the knowledge of what i have experienced until now!')

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

		elseif msgcontains(msg, 'outfit') then
			if isPremium(cid) then
				if getPlayerItemCount(cid,5902) >= 50 then
					selfSay('Oh, youre back already? Did you bring a legion helmet, 100 chicken feathers and 50 honeycombs?')
					talk_state = 3
				else
					selfSay('Pretty, isnt it? My friend Amber taught me how to make it, but I could help you with one if you like. What do you say?')
					talk_state = 2
				end
			else
				selfSay(addon_need_premium)
				talk_state = 0
			end



		elseif msgcontains(msg, 'yes') and talk_state == 2 then
				addon = getPlayerStorageValue(cid,10002)
				if addon == -1 then
		selfSay('Okay, here we go, listen closely! I need a few things... a basic hat of course, maybe a legion helmet would do. Then about 100 chicken feathers... and 50 honeycombs as glue. Thats it, come back to me once you gathered it!')
		talk_state = 0
				else
					selfSay(addon_have_already)
				end



		elseif msgcontains(msg, 'yes') and talk_state == 3 then
		if getPlayerItemCount(cid,5902) >= 50 then
				addon = getPlayerStorageValue(cid,10002)
				if addon == -1 then
					if doPlayerTakeItem(cid,5902,100) == 0 then
						selfSay('msg nunca lida')
						else
						setPlayerStorageValue(cid,10002,1)
						selfSay('Great! Alright, come back and ask for your hat anytime!')
						talk_state = 0
					end
				else
					selfSay(addon_have_already)
				end
			else
				selfSay(addon_have_not_items)
			end

		elseif msgcontains(msg, 'hat') then
				addon = getPlayerStorageValue(cid,10002)
				if addon == 1 then
						selfSay(addon_give)
						doPlayerAddAddon(cid, 128, 2)
						doPlayerAddAddon(cid, 136, 2)
						setPlayerStorageValue(cid,10002,2)
				else
					selfSay('Prety, isnt it?')
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