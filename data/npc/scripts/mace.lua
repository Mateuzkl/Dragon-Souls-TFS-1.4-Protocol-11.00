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

		mace = getPlayerStorageValue(cid,30005)
		addon_need_premium = 'Sorry, you need a premium account to receive it.'
		addon_have_already = 'Sorry, you already have taken your.'
		addon_have_not_items = 'Sorry, you don\'t have the item.'
		addon_give = 'Just in time , hope you like it.'
		
	
		if msgcontains(msg, 'monster') then
			selfSay('I kill monsters.')

		elseif msgcontains(msg, 'job') then
			selfSay('I am a traveler, lost in the wonders of this world!')

		elseif msgcontains(msg, 'offer') then
			selfSay('The only thing i can offer you is the knownledge of what i have experienced until now!')

		elseif msgcontains(msg, 'sell') then
			selfSay('I am not a merchant!')

		elseif msgcontains(msg, 'buy') then
			selfSay('I am not a merchant!')

		elseif msgcontains(msg, 'quest') then
			selfSay('I am not geting involved in quests anymore!')

		elseif msgcontains(msg, 'dwarf') then
			selfSay('I am a dwarfcrafter! I can make you an dwarven axe!')

		elseif msgcontains(msg, 'mission') then
			selfSay('I am not geting involved in missions anymore!')

		elseif msgcontains(msg, 'knownledge') then
			selfSay('I have been in long trips and quests! One more dangerous than the other, now i am just traveling and wondering the world beauties!')


------------------------------------------------ mace ------------------------------------------------
		elseif msgcontains(msg, 'mace') then
				if mace == -1 then
				if getPlayerItemCount(cid,2398) >= 1 then
					selfSay('I dont belive you have it! Wana trade it for my Clerical Mace?')
					talk_state = 3
				else
					selfSay('When i was training in Recruiting island, i lost my mace...It was my fathers present! Its very important for me, but i am already giving up...')
				end
				else
					selfSay(addon_have_already)
				end


		elseif msgcontains(msg, 'yes') and talk_state == 3 then
		if getPlayerItemCount(cid,2398) >= 1 then
				if mace == 0 then
						selfSay('You dont have it!')
						else
						setPlayerStorageValue(cid,30005,1)
						doPlayerTakeItem(cid,2398,1)
						doPlayerGiveItem(cid, 2423, 1, 1)
						selfSay('Oh my god! A lot of thanks sir! But... would you like to help me in another thing?')
						talk_state = 2
					end
			else
				selfSay(addon_have_not_items)
			end


		elseif msgcontains(msg, 'yes') and talk_state == 2 then
				mace =getPlayerStorageValue(cid,30005)
				if mace == 1 then
					selfSay('In a Wild Warrior house, located North East from here, they have a locked chest. Use the mace i just gave you to break it, bring me the inside item. I will be waiting.')
						setPlayerStorageValue(cid,30005,2)
					talk_state = 0
				else
					selfSay(addon_have_already)
				end


		elseif msgcontains(msg, 'ITEM') then
				mace =getPlayerStorageValue(cid,30005)
				if mace == 2 then
				if getPlayerItemCount(cid,2423) >= 1 then
					setPlayerStorageValue(cid,30005,3)
					doPlayerTakeItem(cid,2423,1)
					doPlayerGiveItem(cid, 2391, 1, 1)
					selfSay('I dont have words to say thanks! Take this , its yours now!')
				else
					selfSay('What?')
				end
			else
					selfSay(addon_have_already)
				talk_state = 0
			end


		elseif msgcontains(msg, 'yes') and talk_state == 4 then
			if getPlayerItemCount(cid,9999) >= 1 then
						selfSay('You dont have it!')
			else
						setPlayerStorageValue(cid,30005,3)
						doPlayerTakeItem(cid,9999,1)
						doPlayerGiveItem(cid, 2391, 1, 1)
						selfSay('I dont have words to say thanks! Take this , its yours now!')
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
