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

  		storevalue2 = 7000
  		alerttime2 = 300
  		storevalue = 2222
  		alerttime = 1800
		level = getPlayerLevel(cid)
		addon = getPlayerStorageValue(cid,30004)
		karce = getPlayerStorageValue(cid,31001)
		karce2 = getPlayerStorageValue(cid,31002)
		addon_need_premium = 'Sorry, you need a premium account to receive it.'
		addon_have_already = 'Sorry, you already have taken your.'
		addon_have_not_items = 'Sorry, you don\'t have the item.'
		addon_give = 'Just in time , hope you like it.'
		
	
		if msgcontains(msg, 'monster') then
			selfSay('I kill monsters.')

		elseif msgcontains(msg, 'job') then
			selfSay('Oh my young, now im just a blacksmith, only for hobby!')

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

		elseif msgcontains(msg, 'mission') and karce == -1 then
			selfSay('I am not geting involved in missions anymore!')

		elseif msgcontains(msg, 'knownledge') then
			selfSay('I have been in long trips and quests! One more dangerous than the other, now i am just a blacksmith!')

		elseif msgcontains(msg, 'Warkh') and karce2 == 1 then
			selfSay('Warkh is a older Devil, but him become to be good, is a longer history! You can find him on edron, the fires elementals next him, keep him strong and happy.')

		elseif msgcontains(msg, 'mission') and karce == 4 and karce2 == -1 then
			selfSay('Oh, you back, this destruction cant be made by my hands, this must be destruct at the same place that was made, but im old for this, wanna really try destruct this?')
			talk_state = 5

		elseif msgcontains(msg, 'mission') and karce2 == 1 then
			selfSay('Oh, you here again? so, how are your trip for the montain Dhur?')
			talk_state = 0

		elseif msgcontains(msg, 'small diamond') and karce == 2 then
		if getPlayerItemCount(cid,2145) >= 10 and getPlayerItemCount(cid,2392) >= 1 then
  		if (alert(cid, storevalue, alerttime) == 0) then
			selfSay('Not done yet, i need more time!')
			else
			selfSay('Nice job young! I will need some time, come back here on 30 minutes, and ask me if i did.')
			doPlayerTakeItem(cid,2145,10)
			doPlayerTakeItem(cid,2392,1)
  			doSendMagicEffect(getPlayerPosition(cid),12)
			setPlayerStorageValue(cid,31001,3)
			end
			else
			selfSay('I need the diamonds and the Kar\'ce sword!')
			end

		elseif msgcontains(msg, 'did') and karce == 3 then
  		if (alert(cid, storevalue, alerttime) == 0) then
			selfSay('Not done yet, i need more time!')
			else
			selfSay('Oh, you back, sorry this destruction cant be made by my hands, this must be destruct at the same place that was made, but im old for this, get this item for yours royality, wanna really try destruct this?')
  			doSendMagicEffect(getPlayerPosition(cid),12)
     		doPlayerSendTextMessage(cid,22,"You receive an Silver mace.")
   			silver = doPlayerAddItem(cid,2424,1)
			doSetItemSpecialDescription(silver,"Its a gift of Thordain.")
			setPlayerStorageValue(cid,31001,4)
			talk_state = 5
			end

		elseif msgcontains(msg, 'kar') then
		if karce == 1 then
		if getPlayerItemCount(cid,2392) >= 1 then
			selfSay('This presence! That on your hand! I can feel the presence of Kar\'ce here! You need Destroy it!')
			selfSay('I can try destroy it, but need one thing, bring me 10 pures small diamonds, more fast that you can!')
  			doSendMagicEffect(getPlayerPosition(cid),12)
			setPlayerStorageValue(cid,31001,2)
			else
			selfSay('Kar\'ce, Kar\'ce, a great enemy, just the presence of him on the war, burned ours hearth!')
			end
			else
			selfSay('Kar\'ce, Kar\'ce, a great enemy, just the presence of him on the war, burned ours hearth!')
			end


		elseif msgcontains(msg, 'yes') and talk_state == 2 then
				addon = getPlayerStorageValue(cid,30004)
				if addon == -1 then
					selfSay('Great! I will be waiting you!')
			doPlayerSendTextMessage(cid,19,"Nova quest adicionada 'Uma simples troca.'")
  			doSendMagicEffect(getPlayerPosition(cid),12)
					setPlayerStorageValue(cid,30004,1)
					talk_state = 0
				else
					selfSay(addon_have_already)
				end


		elseif msgcontains(msg, 'yes') and talk_state == 3 then
		if getPlayerItemCount(cid,2388) >= 1 then
				addon = getPlayerStorageValue(cid,30004)
				if addon == -1 or addon == 1 then
  					if (alert(cid, storevalue2, alerttime2) == 0) then
						selfSay('You dont have it!')
						else
  						doSendMagicEffect(getPlayerPosition(cid),12)
						setPlayerStorageValue(cid,30004,2)
						doPlayerTakeItem(cid,2388,1)
						selfSay('Great! It will be done in 5 minutes! Come back later and ask for your axe!')
						talk_state = 0
					end
				else
					selfSay(addon_have_already)
				end
		else
			selfSay('Where are the hatchet?')
		end

		elseif msgcontains(msg, 'yes') and talk_state == 5 then
			if level >= 100 then
				selfSay('You are really brave! So that is what we want do, where the Kar\'ce made this sword, on Montain Dhur is really really hot there, you will not support, so we need up your resistence!')
				selfSay('I got an old friend that can help you, his name is Warkh, don\' be afrayd, he is a good devil, tell him Thordain send you, and you must train the resistence, dont, i say DONT tell him about Kar\'ce!')
				selfSay('Get that! And good luck, so many things deppends of you!')
				sword = doPlayerAddItem(cid,2392,1)
doSetItemSpecialDescription(sword,"The sword of Kar'ce 'The Flame of Kar'ce' is engraved on it.")
				doSetItemActionId(sword,100)
     		doPlayerSendTextMessage(cid,22,"You receive the sword of Kar'ce.")
				setPlayerStorageValue(cid,31002,1)
  			doSendMagicEffect(getPlayerPosition(cid),12)
				talk_state = 0
				else
				selfSay("You are really novice for that, i guess level 100 is good for you try. Ask about mission when you ready!")
				end

		elseif msgcontains(msg, 'no') and talk_state == 5 then
			selfSay('Ok, back when you are ready!')

------------------------------------------------ addon ------------------------------------------------

		elseif msgcontains(msg, 'dwarven') and addon == -1 then
				selfSay('Hmm... I can give you it, a gift for you are so far of home, just bring me an hatchet, ok?')
				talk_state = 2

		elseif msgcontains(msg, 'dwarven') and addon == 1 then
				selfSay('Did you bring me the hatchet?')
				talk_state = 3

		elseif msgcontains(msg, 'dwarven') and addon == 2 then
			selfSay('A great job, just ask me for your axe!')

		elseif msgcontains(msg, 'dwarven') and addon >= 3 then
			selfSay('I did a great job on your\'s yet?')

-------------------------------------------------------------------------------------------------------

------------------------------------------------ confirm yes ------------------------------------------------


		elseif msgcontains(msg, 'axe') then
			talk_state = 0
			if getPlayerItemCount(cid,2388) >= 0 then
		addon = getPlayerStorageValue(cid,30004)
			if addon == 2 then
			if doPlayerTakeItem(cid,2388,0) == 0 then
  			if (alert(cid, storevalue2, alerttime2) == 0) then
				selfSay('The axe is not done yet , come back later.')
			else
				doPlayerGiveItem(cid, 2435, 1, 1)
				selfSay('Just in time! Hope you like it, my gift!')
  			doPlayerSendTextMessage(cid,19,"Quest 'Uma simples troca.' completada.")
  				doSendMagicEffect(getPlayerPosition(cid),12)
				setPlayerStorageValue(cid,30004,3)
			end
					end
				else
					selfSay('Strong , isnt it?')
				end
			else
				selfSay('Where are the hatchet?')
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