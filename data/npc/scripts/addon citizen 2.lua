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

    		time = rl2tib(os.date('%H'), os.date('%M'))
  		storevalue = 2224
  		alerttime = 3600
  		storevalue2 = 2225
  		alerttime2 = 3600
		post = getPlayerStorageValue(cid,2078)
		noble1 = getPlayerStorageValue(cid,40004)
		noble2 = getPlayerStorageValue(cid,40005)
		addon = getPlayerStorageValue(cid,40001)
		addon_need_premium = 'Sorry, you need a premium account to get addons.'
		addon_have_already = 'Sorry, you already have this addon.'
		addon_have_not_items = 'Sorry, you don\'t have these items.'
		addon_give = 'Great job! That must have taken a lot of work. Okay, you put it like this... then glue like this... here!'
		
	
		if msgcontains(msg, 'job') then
			selfSay('I am an adventurer , i have no home , so i put my step on the road!')

		elseif msgcontains(msg, 'offer') then
			selfSay('Hmm... Now i don\'t have nothing ready just some things to sell, but... Im buying some chicken feathers and honeycombs!')

		elseif msgcontains(msg, 'sell') then
			selfSay('Oh! Im selling Noble Hats and Noble Coats, and some others things.')

		elseif msgcontains(msg, 'buy') then
			selfSay('Oh, i buy chicken feathers and honeycombs!')

		elseif msgcontains(msg, 'quest') then
			selfSay('I am not geting involved in quests anymore!')

		elseif msgcontains(msg, 'mission') then
			selfSay('I am not geting involved in missions anymore!')

		elseif msgcontains(msg, 'knownledge') then
			selfSay('I have been in long trips and quests! One more dangerous than the other, now i am just traveling and wondering the world beauties!')

		elseif msgcontains(msg, 'hat') and addon == -1 then
				selfSay('Pretty, isnt it?')

		elseif msgcontains(msg, 'addon') and addon == 1 then
				selfSay('You will love this hat!')

		elseif msgcontains(msg, 'hat') and addon >= 2 then
				selfSay('I do a great job on your hat, hehe.')

		elseif msgcontains(msg, 'addon') and addon >= 2 then
				selfSay('I do a great job on your hat, hehe.')


		elseif msgcontains(msg, 'noble hats') and noble1 == -1 then
				selfSay('Oh, dear nobleman, i can sell an wonderfull noble hat for you, the price is 500,000 gps, can i start make your hat?')
				talk_state = 20

		elseif msgcontains(msg, 'noble hats') and noble1 == 2 then
				selfSay('I do a great job on your noble hat, hehe.')

		elseif msgcontains(msg, 'noble coats') and noble2 == -1 then
				selfSay('Oh, dear nobleman, i can sell an wonderfull noble coat for you, the price is 500,000 gps, can i start make your coat?')
				talk_state = 21

		elseif msgcontains(msg, 'noble coats') and noble2 == 2 then
				selfSay('I do a great job on your noble coat, hehe.')


-- addon (busca)

		elseif msgcontains(msg, 'addon') and addon == -1 then
			if isPremium(cid) then
				selfSay('Pretty, isnt it? My friend Arber taught me how to make it, but I could help you with one if you like. What do you say?')
				talk_state = 2
			else
				selfSay(addon_need_premium)
				talk_state = 0
			end


		elseif msgcontains(msg, 'yes') and talk_state == 2 then
				selfSay('Okay, here we go, listen closely! I need a few things... A basic hat of course, maybe a legion helmet would do. Then about 100 chicken feathers... And 50 honeycombs as glue. Thats it, come back to me once you gathered it!')
			doPlayerSendTextMessage(cid,19,"Nova quest adicionada '(Addon) Citizen Hat.'.")
  			doSendMagicEffect(getPlayerPosition(cid),12)
				setPlayerStorageValue(cid,40001,1)
		talk_state = 0

-- addon (entrega)

		elseif msgcontains(msg, 'hat') and addon == 1 then
			if isPremium(cid) then
				selfSay('Oh, you\'re back already? Did you bring a legion helmet, 100 chicken feathers and 50 honeycombs?')
				talk_state = 3
			else
				selfSay(addon_need_premium)
				talk_state = 0
			end
				
		elseif msgcontains(msg, 'yes') and talk_state == 3 then
			if getPlayerItemCount(cid,5902) >= 50 and getPlayerItemCount(cid,5890) >= 100 and getPlayerItemCount(cid,2480) >= 1 then
				doPlayerTakeItem(cid,5902,50)
				doPlayerTakeItem(cid,2480,1)
				doPlayerTakeItem(cid,5890,100)
				doPlayerAddAddon(cid, 128, 2)
				doPlayerAddAddon(cid, 136, 2)
  			doPlayerSendTextMessage(cid,19,"Quest '(Addon) Citizen Hat.' completada.")
  				doSendMagicEffect(getPlayerPosition(cid),12)
				setPlayerStorageValue(cid,40001,2)
				selfSay('Great job! That must have taken a lot of work. Okay, you put it like this... then glue like this... here!')
				talk_state = 0
			else
				selfSay('You dont have the itens with you!')
			end
-- postman

		elseif msgcontains(msg, 'uniform') and post == 4 then
				selfSay('Hmm, new postman? Hehe, yeah I can do it, no problem, i just need you to bring me 1 brown piece of cloth, 1 leather armor and 1 leather legs, when you gather all this, come back here and I will do one cool uniform for you.')
  			doSendMagicEffect(getPlayerPosition(cid),12)
			setPlayerStorageValue(cid,2078,5)
				talk_state = 0
				
		elseif msgcontains(msg, 'uniform') and post == 5 then
				selfSay('Wow you are quikly, allready actin like a postman! Whell, here we go, did you bring me everything i asked?')
				talk_state = 4
				
		elseif msgcontains(msg, 'yes') and talk_state == 4 then
			if getPlayerItemCount(cid,5913) >= 1 and getPlayerItemCount(cid,2467) >= 1 and getPlayerItemCount(cid,2649) >= 1 then
				doPlayerTakeItem(cid,5913,1)
				doPlayerTakeItem(cid,2467,1)
				doPlayerTakeItem(cid,2649,1)
  				uniform = doPlayerAddItem(cid,6114,1)
				doSetItemSpecialDescription(uniform,"It's your new uniform.")
				doSetItemActionId(uniform,100)
  				doSendMagicEffect(getPlayerPosition(cid),12)
				setPlayerStorageValue(cid,2078,6)
				selfSay('Great job! That must have taken a lot of work. Okay, you put it like this... then glue like this... here! A new uniform!')
				talk_state = 0
			else
				selfSay('You dont have the itens with you!')
			end


-- addon nobles

		elseif msgcontains(msg, 'yes') and talk_state == 20 then
			if isPremium(cid) then
			if pay(cid,500000) then
			if (alert(cid, storevalue, alerttime) == 0) then
			else
				selfSay('Oh, greatifull, will start now! Come back on 1 hour and ask me about your new noble hats!')
			doPlayerSendTextMessage(cid,19,"Nova quest adicionada '(Addon) Nobleman Hat.'")
  			doSendMagicEffect(getPlayerPosition(cid),12)
				setPlayerStorageValue(cid,40004,1)
				talk_state = 0
			end
			else
				selfSay('Sorry, but you dont have this monney!')
				talk_state = 0
			end
			else
				selfSay('Sorry, but only players premium account can pay for that!')
				talk_state = 0
			end
			
		elseif msgcontains(msg, 'yes') and talk_state == 21 then
			if isPremium(cid) then
			if pay(cid,500000) then
			if (alert(cid, storevalue2, alerttime2) == 0) then
			else
				selfSay('Oh, greatifull, will start now! Come back here on 1 hour and ask me about your new noble coat!')
			doPlayerSendTextMessage(cid,19,"Nova quest adicionada '(Addon) Nobleman Coat.'")
  			doSendMagicEffect(getPlayerPosition(cid),12)
				setPlayerStorageValue(cid,40005,1)
				talk_state = 0
			end
			else
				selfSay('Sorry, but you dont have this monney!')
				talk_state = 0
			end
			else
				selfSay('Sorry, but only players premium account can pay for that!')
				talk_state = 0
			end
			
-- addon nobles entrega
	
		elseif msgcontains(msg, 'noble hats') and noble1 == 1 then
			if (alert(cid, storevalue, alerttime) == 0) then
				selfSay('The noble hats is not done yet, come back later.')
			else
				doPlayerAddAddon(cid, 132, 2)
				doPlayerAddAddon(cid, 140, 2)
  			doPlayerSendTextMessage(cid,19,"Quest '(Addon) Nobleman Hat.' completada.")
  				doSendMagicEffect(getPlayerPosition(cid),12)
				setPlayerStorageValue(cid,40004,2)
				selfSay('Its a great job! Here are your new noble hat!')
				talk_state = 0
			end

		elseif msgcontains(msg, 'noble coat') and noble2 == 1 then
			if (alert(cid, storevalue2, alerttime2) == 0) then
				selfSay('The noble coat is not done yet, come back later.')
			else
				doPlayerAddAddon(cid, 132, 1)
				doPlayerAddAddon(cid, 140, 1)
  			doPlayerSendTextMessage(cid,19,"Quest '(Addon) Nobleman Coat.' completada.")
  				doSendMagicEffect(getPlayerPosition(cid),12)
				setPlayerStorageValue(cid,40005,2)
				selfSay('Its a great job! Here are your new noble coat!')
				talk_state = 0
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



 function rl2tib(min, sec, twentyfour)
 -- Convert RL time to ingame Tibia time - by Alreth (v1.13)
     suffix = ''
     varh = (min*60+sec)/150
     tibH = math.floor(varh)             -- Tibian hour
     tibM = math.floor(60*(varh-tibH))   -- Tibian minute
     
     if (twentyfour == false) then
         if (tonumber(tibH) > 11) then
             tibH = tonumber(tibH) - 12
             suffix = ' pm'
         else
             suffix = ' am'
         end
         if (tibH == 0) then
             tibH = 12
         end
     end
     if (tibH < 10) then
         tibH = '0'..tibH
     end
     if (tibM < 10) then
         tibM = '0'..tibM
     end
     return (os.date('%H')..':'..os.date('%M')..suffix)
 end