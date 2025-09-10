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

		if msgcontains(msg, 'job') then
			selfSay('I am a gladiator, lost in the wonders of this world!')

		elseif msgcontains(msg, 'offer') then
			selfSay('Posso lhe oferecer diferentes tipos de arenas! Mas por enquanto somente a "Protect the King".')

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


		elseif msgcontains(msg, 'addon') then
				selfSay('Hun?!')

-- arena "Protect the King"

		elseif msgcontains(msg, 'asdkingzz') then
			if isPremium(cid) then
			if getPlayerVocation(cid) > 8 then
			if getPlayerItemCount(cid,6500) == 0 and getPlayerItemCount(cid,2145) == 0 and getPlayerItemCount(cid,2146) == 0 and getPlayerItemCount(cid,2147) == 0 and getPlayerItemCount(cid,2149) == 0 and getPlayerItemCount(cid,2150) == 0 and getPlayerItemCount(cid,2153) == 0 and getPlayerItemCount(cid,2154) == 0 and getPlayerItemCount(cid,2155) == 0 and getPlayerItemCount(cid,2156) == 0 and getPlayerItemCount(cid,2158) == 0 then

				selfSay('Tem certeza que deseja entrar na arena "Protect the King"?')
				talk_state = 1
			else
				selfSay('Você não pode entrar nessa arena carregando: demonic essences, small diamond, small sapphire, small ruby, small emerald, small amethyst, big emerald, violet gem, yellow gem, big ruby e blue gem.')
				talk_state = 0
			end
			else
				selfSay('Somente Valans podem entrar nesta arena.')
				talk_state = 0
			end
			else
				selfSay('Essa arena é somente para premiuns.')
				talk_state = 0
			end

		elseif msgcontains(msg, 'yes') and talk_state == 1 then
				selfSay('Esta pronto?')
				--setPlayerStorageValue(cid,8111,getPlayerLevel(cid))
				--doPlayerAddItem(cid,2671,1)
				--doPlayerSave(cid, cid)
				talk_state = 2

		elseif msgcontains(msg, 'yes') and talk_state == 2 then
				doPlayerSave(cid, cid)
				selfSay('Boa sorte!')
				travel(cid, 405, 496, 5)
				talk_state = 0

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