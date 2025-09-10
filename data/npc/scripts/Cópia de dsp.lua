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

		dsp = getPlayerItemCount(cid,6527)


		if msgcontains(msg, 'job') then
			selfSay('I am a merchant, lost in the wonders of this world!')

		elseif msgcontains(msg, 'offer') then
			selfSay('I change runes and premium days for Dragon Souls points!')

		elseif msgcontains(msg, 'sell') then
			selfSay('Just change!')

		elseif msgcontains(msg, 'buy') then
			selfSay('Just change!')

		elseif msgcontains(msg, 'quest') then
			selfSay('I am not geting involved in quests anymore!')

		elseif msgcontains(msg, 'mission') then
			selfSay('I am not geting involved in missions anymore!')

		elseif msgcontains(msg, 'knownledge') then
			selfSay('I have been in long trips and quests! One more dangerous than the other, now i am just traveling and wondering the world beauties!')


		elseif msgcontains(msg, 'addon') then
				selfSay('Ahh, this backpack? It\'s a present from Brian.')

		elseif msgcontains(msg, 'backpack') then
				selfSay('Ahh, this backpack? It\'s a present from Brian.')

---------------------------------- itens

		elseif msgcontains(msg, 'uh') then
			selfSay('Aceita trocar 10 DSP\'s por 1 bp com 20 runas de 10x de uh?')
			talk_state = 1

		elseif msgcontains(msg, 'expl') or msgcontains(msg, 'explosion') then
			selfSay('Aceita trocar 25 DSP\'s por 1 bp com 20 runas de 30x de explosion?')
			talk_state = 2

		elseif msgcontains(msg, 'sd') then
			selfSay('Aceita trocar 40 DSP\'s por 1 bp com 20 runas de 10x de sd?')
			talk_state = 3

		elseif msgcontains(msg, 'gfb') then
			selfSay('Aceita trocar 10 DSP\'s por 1 bp com 20 runas de 20x de gfb?')
			talk_state = 4

		elseif msgcontains(msg, 'hmm') then
			selfSay('Aceita trocar 5 DSP\'s por 1 bp com 20 runas de 50x de hmm?')
			talk_state = 5

		elseif msgcontains(msg, 'destroy field') then
			selfSay('Aceita trocar 5 DSP\'s por 1 bp com 20 runas de 30x de destroy field?')
			talk_state = 6

		elseif msgcontains(msg, 'eb') or msgcontains(msg, 'energy bomb') then
			selfSay('Aceita trocar 10 DSP\'s por 1 bp com 20 runas de 10x de uh?')
			talk_state = 1

		elseif msgcontains(msg, 'ih') then
			selfSay('Aceita trocar 10 DSP\'s por 1 bp com 20 runas de 10x de uh?')
			talk_state = 1

		elseif msgcontains(msg, 'paralyze') then
			selfSay('Aceita trocar 10 DSP\'s por 1 bp com 20 runas de 10x de uh?')
			talk_state = 1

		elseif msgcontains(msg, 'ef') or msgcontains(msg, 'energy field') then
			selfSay('Aceita trocar 10 DSP\'s por 1 bp com 20 runas de 10x de uh?')
			talk_state = 1

		elseif msgcontains(msg, 'poison field') then
			selfSay('Aceita trocar 10 DSP\'s por 1 bp com 20 runas de 10x de uh?')
			talk_state = 1

		elseif msgcontains(msg, 'poison bomb') then
			selfSay('Aceita trocar 10 DSP\'s por 1 bp com 20 runas de 10x de uh?')
			talk_state = 1

		elseif msgcontains(msg, 'lmm') then
			selfSay('Aceita trocar 10 DSP\'s por 1 bp com 20 runas de 10x de uh?')
			talk_state = 1

		elseif msgcontains(msg, 'convince') then
			selfSay('Aceita trocar 10 DSP\'s por 1 bp com 20 runas de 10x de uh?')
			talk_state = 1

		elseif msgcontains(msg, 'chamaleon') then
			selfSay('Aceita trocar 10 DSP\'s por 1 bp com 20 runas de 10x de uh?')
			talk_state = 1

		elseif msgcontains(msg, 'mw') or msgcontains(msg, 'magic wall') then
			selfSay('Aceita trocar 10 DSP\'s por 1 bp com 20 runas de 10x de uh?')
			talk_state = 1

		elseif msgcontains(msg, 'ff') or msgcontains(msg, 'fire field') then
			selfSay('Aceita trocar 10 DSP\'s por 1 bp com 20 runas de 10x de uh?')
			talk_state = 1

		elseif msgcontains(msg, 'fb') or msgcontains(msg, 'fire bomb') then
			selfSay('Aceita trocar 10 DSP\'s por 1 bp com 20 runas de 10x de uh?')
			talk_state = 1

		elseif msgcontains(msg, 'sf') or msgcontains(msg, 'soul fire') then
			selfSay('Aceita trocar 10 DSP\'s por 1 bp com 20 runas de 10x de uh?')
			talk_state = 1

		elseif msgcontains(msg, 'desintegrate') then
			selfSay('Aceita trocar 10 DSP\'s por 1 bp com 20 runas de 10x de uh?')
			talk_state = 1

		elseif msgcontains(msg, 'premium') then
			selfSay('Aceita trocar 100 DSP\'s por 30 dias de premium?')
			talk_state = 21

-- bps de runas 20x


		elseif msgcontains(msg, 'yes') and talk_state == 1 then	-- uh
		if getPlayerItemCount(cid,6527) >= 10 then
			doPlayerTakeItem(cid,6527,10)
			selfSay('Aqui esta! Obrigado e volte sempre.')
			doPlayerSendTextMessage(cid,22,"Voce recebeu uma bp de uh.")
			doPlayerSendTextMessage(cid, 20, 'Ainda lhe resta ' .. dsp - 10 .. ' Dragon Souls Points.')
			container = doPlayerAddItem(cid, 2002, 1)
			doAddContainerItem(container, 2273, 10)
			doAddContainerItem(container, 2273, 10)
			doAddContainerItem(container, 2273, 10)
			doAddContainerItem(container, 2273, 10)
			doAddContainerItem(container, 2273, 10)
			doAddContainerItem(container, 2273, 10)
			doAddContainerItem(container, 2273, 10)
			doAddContainerItem(container, 2273, 10)
			doAddContainerItem(container, 2273, 10)
			doAddContainerItem(container, 2273, 10)
			doAddContainerItem(container, 2273, 10)
			doAddContainerItem(container, 2273, 10)
			doAddContainerItem(container, 2273, 10)
			doAddContainerItem(container, 2273, 10)
			doAddContainerItem(container, 2273, 10)
			doAddContainerItem(container, 2273, 10)
			doAddContainerItem(container, 2273, 10)
			doAddContainerItem(container, 2273, 10)
			doAddContainerItem(container, 2273, 10)
			doAddContainerItem(container, 2273, 10)
			talk_state = 0
		else
			selfSay('Desculpe, mas voce não tem DSP\'s suficiente.')
		end

		elseif msgcontains(msg, 'yes') and talk_state == 2 then	-- expl
		if getPlayerItemCount(cid,6527) >= 25 then
			doPlayerTakeItem(cid,6527,25)
			selfSay('Aqui esta! Obrigado e volte sempre.')
			doPlayerSendTextMessage(cid,22,"Voce recebeu uma bp de explosion.")
			doPlayerSendTextMessage(cid, 20, 'Ainda lhe resta ' .. dsp - 25 .. ' Dragon Souls Points.')
			container = doPlayerAddItem(cid, 2001, 1)
			doAddContainerItem(container, 2313, 30)
			doAddContainerItem(container, 2313, 30)
			doAddContainerItem(container, 2313, 30)
			doAddContainerItem(container, 2313, 30)
			doAddContainerItem(container, 2313, 30)
			doAddContainerItem(container, 2313, 30)
			doAddContainerItem(container, 2313, 30)
			doAddContainerItem(container, 2313, 30)
			doAddContainerItem(container, 2313, 30)
			doAddContainerItem(container, 2313, 30)
			doAddContainerItem(container, 2313, 30)
			doAddContainerItem(container, 2313, 30)
			doAddContainerItem(container, 2313, 30)
			doAddContainerItem(container, 2313, 30)
			doAddContainerItem(container, 2313, 30)
			doAddContainerItem(container, 2313, 30)
			doAddContainerItem(container, 2313, 30)
			doAddContainerItem(container, 2313, 30)
			doAddContainerItem(container, 2313, 30)
			doAddContainerItem(container, 2313, 30)
			talk_state = 0
		else
			selfSay('Desculpe, mas voce não tem DSP\'s suficiente.')
		end

		elseif msgcontains(msg, 'yes') and talk_state == 3 then	-- sd
		if getPlayerItemCount(cid,6527) >= 40 then
			doPlayerTakeItem(cid,6527,40)
			selfSay('Aqui esta! Obrigado e volte sempre.')
			doPlayerSendTextMessage(cid,22,"Voce recebeu uma bp de sd.")
			doPlayerSendTextMessage(cid, 20, 'Ainda lhe resta ' .. dsp - 40 .. ' Dragon Souls Points.')
			container = doPlayerAddItem(cid, 2003, 1)
			doAddContainerItem(container, 2268, 10)
			doAddContainerItem(container, 2268, 10)
			doAddContainerItem(container, 2268, 10)
			doAddContainerItem(container, 2268, 10)
			doAddContainerItem(container, 2268, 10)
			doAddContainerItem(container, 2268, 10)
			doAddContainerItem(container, 2268, 10)
			doAddContainerItem(container, 2268, 10)
			doAddContainerItem(container, 2268, 10)
			doAddContainerItem(container, 2268, 10)
			doAddContainerItem(container, 2268, 10)
			doAddContainerItem(container, 2268, 10)
			doAddContainerItem(container, 2268, 10)
			doAddContainerItem(container, 2268, 10)
			doAddContainerItem(container, 2268, 10)
			doAddContainerItem(container, 2268, 10)
			doAddContainerItem(container, 2268, 10)
			doAddContainerItem(container, 2268, 10)
			doAddContainerItem(container, 2268, 10)
			doAddContainerItem(container, 2268, 10)
			talk_state = 0
		else
			selfSay('Desculpe, mas voce não tem DSP\'s suficiente.')
		end

		elseif msgcontains(msg, 'yes') and talk_state == 4 then	-- gfb
		if getPlayerItemCount(cid,6527) >= 10 then
			doPlayerTakeItem(cid,6527,10)
			selfSay('Aqui esta! Obrigado e volte sempre.')
			doPlayerSendTextMessage(cid,22,"Voce recebeu uma bp de gfb.")
			doPlayerSendTextMessage(cid, 20, 'Ainda lhe resta ' .. dsp - 10 .. ' Dragon Souls Points.')
			container = doPlayerAddItem(cid, 2000, 1)
			doAddContainerItem(container, 2304, 20)
			doAddContainerItem(container, 2304, 20)
			doAddContainerItem(container, 2304, 20)
			doAddContainerItem(container, 2304, 20)
			doAddContainerItem(container, 2304, 20)
			doAddContainerItem(container, 2304, 20)
			doAddContainerItem(container, 2304, 20)
			doAddContainerItem(container, 2304, 20)
			doAddContainerItem(container, 2304, 20)
			doAddContainerItem(container, 2304, 20)
			doAddContainerItem(container, 2304, 20)
			doAddContainerItem(container, 2304, 20)
			doAddContainerItem(container, 2304, 20)
			doAddContainerItem(container, 2304, 20)
			doAddContainerItem(container, 2304, 20)
			doAddContainerItem(container, 2304, 20)
			doAddContainerItem(container, 2304, 20)
			doAddContainerItem(container, 2304, 20)
			doAddContainerItem(container, 2304, 20)
			doAddContainerItem(container, 2304, 20)
			talk_state = 0
		else
			selfSay('Desculpe, mas voce não tem DSP\'s suficiente.')
		end

		elseif msgcontains(msg, 'yes') and talk_state == 5 then	-- hmm
		if getPlayerItemCount(cid,6527) >= 5 then
			doPlayerTakeItem(cid,6527,5)
			selfSay('Aqui esta! Obrigado e volte sempre.')
			doPlayerSendTextMessage(cid,22,"Voce recebeu uma bp de hmm.")
			doPlayerSendTextMessage(cid, 20, 'Ainda lhe resta ' .. dsp - 5 .. ' Dragon Souls Points.')
			container = doPlayerAddItem(cid, 2001, 1)
			doAddContainerItem(container, 2311, 50)
			doAddContainerItem(container, 2311, 50)
			doAddContainerItem(container, 2311, 50)
			doAddContainerItem(container, 2311, 50)
			doAddContainerItem(container, 2311, 50)
			doAddContainerItem(container, 2311, 50)
			doAddContainerItem(container, 2311, 50)
			doAddContainerItem(container, 2311, 50)
			doAddContainerItem(container, 2311, 50)
			doAddContainerItem(container, 2311, 50)
			doAddContainerItem(container, 2311, 50)
			doAddContainerItem(container, 2311, 50)
			doAddContainerItem(container, 2311, 50)
			doAddContainerItem(container, 2311, 50)
			doAddContainerItem(container, 2311, 50)
			doAddContainerItem(container, 2311, 50)
			doAddContainerItem(container, 2311, 50)
			doAddContainerItem(container, 2311, 50)
			doAddContainerItem(container, 2311, 50)
			doAddContainerItem(container, 2311, 50)
			talk_state = 0
		else
			selfSay('Desculpe, mas voce não tem DSP\'s suficiente.')
		end

		elseif msgcontains(msg, 'yes') and talk_state == 6 then	-- df
		if getPlayerItemCount(cid,6527) >= 5 then
			doPlayerTakeItem(cid,6527,5)
			selfSay('Aqui esta! Obrigado e volte sempre.')
			doPlayerSendTextMessage(cid,22,"Voce recebeu uma bp de destroy field.")
			doPlayerSendTextMessage(cid, 20, 'Ainda lhe resta ' .. dsp - 5 .. ' Dragon Souls Points.')
			container = doPlayerAddItem(cid, 2003, 1)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			talk_state = 0
		else
			selfSay('Desculpe, mas voce não tem DSP\'s suficiente.')
		end

---- premy 30 dias

		elseif msgcontains(msg, 'yes') and talk_state == 21 then	-- premy
		if getPlayerItemCount(cid,6527) >= 100 then
			doPlayerTakeItem(cid,6527,100)
			selfSay('/premium '.. creatureGetName(cid) ..', 30')
			selfSay('Obrigado e volte sempre.')
			doPlayerSendTextMessage(cid,22,"Voce recebeu 30 dias de Premium Account.")
			doPlayerSendTextMessage(cid, 20, 'Ainda lhe resta ' .. dsp - 100 .. ' Dragon Souls Points.')
			container = doPlayerAddItem(cid, 2003, 1)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			doAddContainerItem(container, 2261, 30)
			talk_state = 0
		else
			selfSay('Desculpe, mas voce não tem DSP\'s suficiente.')
		end




		elseif msgcontains(msg, 'no') and (talk_state >= 1 and talk_state <= 34) then
			selfSay('Ok than.')
			talk_state = 0
		end
	-- Place all your code in here. Remember that hi, bye and all that stuff is already handled by the npcsystem, so you do not have to take care of that yourself.
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())