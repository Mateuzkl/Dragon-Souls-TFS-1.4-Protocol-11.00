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
			selfSay('Aceita trocar 10 DSP\'s por 1 bp com 20 runas de 20x de uh? (Requerido 45 de cap)')
			talk_state = 111

		elseif msgcontains(msg, 'dark explo') or msgcontains(msg, 'explosion') then
			selfSay('Aceita trocar 15 DSP\'s por 1 bp com 1 runa de 200x de dark explosion? (Requerido 45 de cap)')
			talk_state = 2

		elseif msgcontains(msg, 'dark sd') then
			selfSay('Aceita trocar 20 DSP\'s por 1 bp com 1 runa de 200x de esd? (Requerido 45 de cap)')
			talk_state = 3

		elseif msgcontains(msg, 'gfb') then
			selfSay('Aceita trocar 10 DSP\'s por 1 bp com 20 runas de 40x de gfb? (Requerido 45 de cap)')
			talk_state = 4

		elseif msgcontains(msg, 'hmm') then
			selfSay('Aceita trocar 5 DSP\'s por 1 bp com 20 runas de 100x de hmm? (Requerido 45 de cap)')
			talk_state = 5

		elseif msgcontains(msg, 'destroy field') then
			selfSay('Aceita trocar 5 DSP\'s por 1 bp com 20 runas de 60x de destroy field? (Requerido 45 de cap)')
			talk_state = 6

		elseif msgcontains(msg, 'premium') then
			selfSay('Aceita trocar 100 DSP\'s por 30 dias de premium?')
			talk_state = 21

		elseif msgcontains(msg, 'cirurgia') then
			selfSay('Aceita trocar 10 GP\´s por uma cirurgia de troca de sexo?')
			talk_state = 22

		elseif msgcontains(msg, 'premmy por gps') then
			selfSay('Esse sistema foi desativado por enquanto.')
			--talk_state = 23

			-- selfSay('Aceita pagar 150k por 10 dias de premium?')

		elseif msgcontains(msg, 'life ring') then
			selfSay('Aceita trocar 10 DSP\'s por 1 bp com 20 life rings? (Requerido 35 de cap)')
			talk_state = 31

		elseif msgcontains(msg, 'ring of healing') then
			selfSay('Aceita trocar 20 DSP\'s por 1 bp com 20 ring of healings? (Requerido 35 de cap)')
			talk_state = 32

		elseif msgcontains(msg, 'mana fluid') then
			selfSay('Aceita trocar 15 DSP\'s por 1 Large Mana Fluid com 100 cargas? (Requerido 100 de cap)')
			talk_state = 33

		elseif msgcontains(msg, 'blessed ring') then
			selfSay('Aceita trocar 40 DSP\'s por 1 bp com 20 Blessed rings? (Requerido 170 de cap)')
			talk_state = 34

		elseif msgcontains(msg, 'teleport') then
			selfSay('Aceita trocar 25 DSP\'s por 10 Teleports? (Requerido 10 de cap)')
			talk_state = 35

		elseif msgcontains(msg, 'small elixir of experience') then
			selfSay('Aceita trocar 30 DSP\'s por 50 Small Elixir of Experience? (Requerido 60 de cap)')
			talk_state = 36

		elseif msgcontains(msg, 'normal elixir of experience') then
			selfSay('Aceita trocar 50 DSP\'s por 50 Normal Elixir of Experience? (Requerido 160 de cap)')
			talk_state = 37

		elseif msgcontains(msg, 'fighting spirit') then
			selfSay('Aceita trocar 50 DSP\'s por 1 Fighting Spirit? (Requerido 2 de cap)')
			talk_state = 38

		elseif msgcontains(msg, 'energetico') then
			selfSay('Aceita trocar 20 DSP\'s por 1 Energético? (Requerido 30 de cap)')
			talk_state = 39

		elseif msgcontains(msg, 'blood') then
			selfSay('Aceita trocar 50 DSP\'s por 1 Backpack com 20 Blood of God\'s? (Requerido 1550 de cap)')
			talk_state = 40


		elseif msgcontains(msg, 'dsp') then
			selfSay('Aceita trocar 1kk por 100 Dragon Souls Points?')
			talk_state = 41

-- bps de runas 10x


		elseif talk_state == 111 then
		if msgcontains(msg, 'yes') then	-- uh
		if getPlayerItemCount(cid,6527) >= 10 then
		if talk_state == 111 then
			doPlayerTakeItem(cid,6527,10)
			selfSay('Aqui esta! Obrigado e volte sempre.')
			doPlayerSendTextMessage(cid,22,"Voce recebeu uma bp de uh.")
			doPlayerSendTextMessage(cid, 20, 'Ainda lhe resta ' .. dsp - 10 .. ' Dragon Souls Points.')
			container = doPlayerAddItem(cid, 2002, 1)
			doAddContainerItem(container, 2273, 20)
			doAddContainerItem(container, 2273, 20)
			doAddContainerItem(container, 2273, 20)
			doAddContainerItem(container, 2273, 20)
			doAddContainerItem(container, 2273, 20)
			doAddContainerItem(container, 2273, 20)
			doAddContainerItem(container, 2273, 20)
			doAddContainerItem(container, 2273, 20)
			doAddContainerItem(container, 2273, 20)
			doAddContainerItem(container, 2273, 20)
			doAddContainerItem(container, 2273, 20)
			doAddContainerItem(container, 2273, 20)
			doAddContainerItem(container, 2273, 20)
			doAddContainerItem(container, 2273, 20)
			doAddContainerItem(container, 2273, 20)
			doAddContainerItem(container, 2273, 20)
			doAddContainerItem(container, 2273, 20)
			doAddContainerItem(container, 2273, 20)
			doAddContainerItem(container, 2273, 20)
			doAddContainerItem(container, 2273, 20)
			talk_state = 0
		else
			selfSay('Desculpe, repita tudo dinovo.')
		end
		else
			selfSay('Desculpe, mas voce não tem DSP\'s suficiente.')
		end
		end

		elseif talk_state == 2 and msgcontains(msg, 'yes') then	-- expl
		if getPlayerItemCount(cid,6527) >= 15 then
			doPlayerTakeItem(cid,6527,20)
			selfSay('Aqui esta! Obrigado e volte sempre.')
			doPlayerSendTextMessage(cid,22,"Voce recebeu uma dark explosion.")
			doPlayerSendTextMessage(cid, 20, 'Ainda lhe resta ' .. dsp - 15 .. ' Dragon Souls Points.')
			container = doPlayerAddItem(cid, 2001, 1)
			doAddContainerItem(container, 2315, 200)
			talk_state = 0
		else
			selfSay('Desculpe, mas voce não tem DSP\'s suficiente.')
		end

		elseif talk_state == 3 and msgcontains(msg, 'yes') then	-- sd
		if getPlayerItemCount(cid,6527) >= 20 then
			doPlayerTakeItem(cid,6527,50)
			selfSay('Aqui esta! Obrigado e volte sempre.')
			doPlayerSendTextMessage(cid,22,"Voce recebeu uma dark sd.")
			doPlayerSendTextMessage(cid, 20, 'Ainda lhe resta ' .. dsp - 20 .. ' Dragon Souls Points.')
			container = doPlayerAddItem(cid, 2003, 1)
			doAddContainerItem(container, 2267, 200)
			talk_state = 0
		else
			selfSay('Desculpe, mas voce não tem DSP\'s suficiente.')
		end

		elseif talk_state == 4 and msgcontains(msg, 'yes') then	-- gfb
		if getPlayerItemCount(cid,6527) >= 10 then
			doPlayerTakeItem(cid,6527,10)
			selfSay('Aqui esta! Obrigado e volte sempre.')
			doPlayerSendTextMessage(cid,22,"Voce recebeu uma bp de gfb.")
			doPlayerSendTextMessage(cid, 20, 'Ainda lhe resta ' .. dsp - 10 .. ' Dragon Souls Points.')
			container = doPlayerAddItem(cid, 2000, 1)
			doAddContainerItem(container, 2304, 40)
			doAddContainerItem(container, 2304, 40)
			doAddContainerItem(container, 2304, 40)
			doAddContainerItem(container, 2304, 40)
			doAddContainerItem(container, 2304, 40)
			doAddContainerItem(container, 2304, 40)
			doAddContainerItem(container, 2304, 40)
			doAddContainerItem(container, 2304, 40)
			doAddContainerItem(container, 2304, 40)
			doAddContainerItem(container, 2304, 40)
			doAddContainerItem(container, 2304, 40)
			doAddContainerItem(container, 2304, 40)
			doAddContainerItem(container, 2304, 40)
			doAddContainerItem(container, 2304, 40)
			doAddContainerItem(container, 2304, 40)
			doAddContainerItem(container, 2304, 40)
			doAddContainerItem(container, 2304, 40)
			doAddContainerItem(container, 2304, 40)
			doAddContainerItem(container, 2304, 40)
			doAddContainerItem(container, 2304, 40)
			talk_state = 0
		else
			selfSay('Desculpe, mas voce não tem DSP\'s suficiente.')
		end

		elseif talk_state == 5 and msgcontains(msg, 'yes') then	-- hmm
		if getPlayerItemCount(cid,6527) >= 5 then
			doPlayerTakeItem(cid,6527,5)
			selfSay('Aqui esta! Obrigado e volte sempre.')
			doPlayerSendTextMessage(cid,22,"Voce recebeu uma bp de hmm.")
			doPlayerSendTextMessage(cid, 20, 'Ainda lhe resta ' .. dsp - 5 .. ' Dragon Souls Points.')
			container = doPlayerAddItem(cid, 2001, 1)
			doAddContainerItem(container, 2311, 100)
			doAddContainerItem(container, 2311, 100)
			doAddContainerItem(container, 2311, 100)
			doAddContainerItem(container, 2311, 100)
			doAddContainerItem(container, 2311, 100)
			doAddContainerItem(container, 2311, 100)
			doAddContainerItem(container, 2311, 100)
			doAddContainerItem(container, 2311, 100)
			doAddContainerItem(container, 2311, 100)
			doAddContainerItem(container, 2311, 100)
			doAddContainerItem(container, 2311, 100)
			doAddContainerItem(container, 2311, 100)
			doAddContainerItem(container, 2311, 100)
			doAddContainerItem(container, 2311, 100)
			doAddContainerItem(container, 2311, 100)
			doAddContainerItem(container, 2311, 100)
			doAddContainerItem(container, 2311, 100)
			doAddContainerItem(container, 2311, 100)
			doAddContainerItem(container, 2311, 100)
			doAddContainerItem(container, 2311, 100)
			talk_state = 0
		else
			selfSay('Desculpe, mas voce não tem DSP\'s suficiente.')
		end

		elseif talk_state == 6 and msgcontains(msg, 'yes') then	-- df
		if getPlayerItemCount(cid,6527) >= 5 then
			doPlayerTakeItem(cid,6527,5)
			selfSay('Aqui esta! Obrigado e volte sempre.')
			doPlayerSendTextMessage(cid,22,"Voce recebeu uma bp de destroy field.")
			doPlayerSendTextMessage(cid, 20, 'Ainda lhe resta ' .. dsp - 5 .. ' Dragon Souls Points.')
			container = doPlayerAddItem(cid, 2003, 1)
			doAddContainerItem(container, 2261, 60)
			doAddContainerItem(container, 2261, 60)
			doAddContainerItem(container, 2261, 60)
			doAddContainerItem(container, 2261, 60)
			doAddContainerItem(container, 2261, 60)
			doAddContainerItem(container, 2261, 60)
			doAddContainerItem(container, 2261, 60)
			doAddContainerItem(container, 2261, 60)
			doAddContainerItem(container, 2261, 60)
			doAddContainerItem(container, 2261, 60)
			doAddContainerItem(container, 2261, 60)
			doAddContainerItem(container, 2261, 60)
			doAddContainerItem(container, 2261, 60)
			doAddContainerItem(container, 2261, 60)
			doAddContainerItem(container, 2261, 60)
			doAddContainerItem(container, 2261, 60)
			doAddContainerItem(container, 2261, 60)
			doAddContainerItem(container, 2261, 60)
			doAddContainerItem(container, 2261, 60)
			doAddContainerItem(container, 2261, 60)
			talk_state = 0
		else
			selfSay('Desculpe, mas voce não tem DSP\'s suficiente.')
		end

---- premy 30 dias

		elseif talk_state == 21 and msgcontains(msg, 'yes') then	-- premy
		if getPlayerItemCount(cid,6527) >= 100 then
			doPlayerTakeItem(cid,6527,100)
			selfSay('/premium '.. creatureGetName(cid) ..', 30')
			selfSay('Obrigado e volte sempre.')
			doPlayerSendTextMessage(cid,22,"Voce recebeu 30 dias de Premium Account.")
			doPlayerSendTextMessage(cid, 20, 'Ainda lhe resta ' .. dsp - 100 .. ' Dragon Souls Points.')
			talk_state = 0
		else
			selfSay('Desculpe, mas voce não tem DSP\'s suficiente.')
		end

		elseif msgcontains(msg, 'azafyses') and talk_state == 23 then	-- premy gps
		if isPremium(cid) then
			selfSay('Desculpe, apenas free accounts podem comprar premmy por gps.')
			talk_state = 0
		else
		if pay(cid,150000) then
			selfSay('/premium '.. creatureGetName(cid) ..', 10')
			selfSay('Obrigado e volte sempre.')
			doPlayerSendTextMessage(cid,22,"Voce recebeu 10 dias de Premium Account.")
			talk_state = 0
		else
			selfSay('Desculpe, mas voce não tem dinheiro suficiente.')
		end
		end

-- sexo
		elseif talk_state == 22 and msgcontains(msg, 'yes') then	-- cirurgia
		if getPlayerItemCount(cid,2152) >= 1 then
		if getPlayerSex(cid) == 0 then
			doPlayerTakeItem(cid,2152,1)
			selfSay('Obrigado e volte sempre.')
			doPlayerSetSex(cid, 1)
			doPlayerSendTextMessage(cid,22,"Voce trocou de sexo com sucesso.")
			doPlayerSendTextMessage(cid, 20, 'Ainda lhe resta ' .. dsp - 10 .. ' Dragon Souls Points.')
			talk_state = 0
		else
			doPlayerTakeItem(cid,2152,1)
			selfSay('Obrigado e volte sempre.')
			doPlayerSetSex(cid, 0)
			doPlayerSendTextMessage(cid,22,"Voce trocou de sexo com sucesso.")
			doPlayerSendTextMessage(cid, 20, 'Ainda lhe resta ' .. dsp - 10 .. ' Dragon Souls Points.')
			talk_state = 0
		end
		else
			selfSay('Desculpe, mas voce não tem DSP\'s suficiente.')
		end


---- itens

		elseif talk_state == 31 and msgcontains(msg, 'yes') then	-- life ring
		if getPlayerItemCount(cid,6527) >= 10 then
			doPlayerTakeItem(cid,6527,10)
			selfSay('Aqui esta! Obrigado e volte sempre.')
			doPlayerSendTextMessage(cid,22,"Voce recebeu uma bp de life ring.")
			doPlayerSendTextMessage(cid, 20, 'Ainda lhe resta ' .. dsp - 10 .. ' Dragon Souls Points.')
			container = doPlayerAddItem(cid, 1998, 1)
			doAddContainerItem(container, 2168, 1)
			doAddContainerItem(container, 2168, 1)
			doAddContainerItem(container, 2168, 1)
			doAddContainerItem(container, 2168, 1)
			doAddContainerItem(container, 2168, 1)
			doAddContainerItem(container, 2168, 1)
			doAddContainerItem(container, 2168, 1)
			doAddContainerItem(container, 2168, 1)
			doAddContainerItem(container, 2168, 1)
			doAddContainerItem(container, 2168, 1)
			doAddContainerItem(container, 2168, 1)
			doAddContainerItem(container, 2168, 1)
			doAddContainerItem(container, 2168, 1)
			doAddContainerItem(container, 2168, 1)
			doAddContainerItem(container, 2168, 1)
			doAddContainerItem(container, 2168, 1)
			doAddContainerItem(container, 2168, 1)
			doAddContainerItem(container, 2168, 1)
			doAddContainerItem(container, 2168, 1)
			doAddContainerItem(container, 2168, 1)
			talk_state = 0
		else
			selfSay('Desculpe, mas voce não tem DSP\'s suficiente.')
		end

		elseif talk_state == 32 and msgcontains(msg, 'yes') then	-- roh
		if getPlayerItemCount(cid,6527) >= 20 then
			doPlayerTakeItem(cid,6527,20)
			selfSay('Aqui esta! Obrigado e volte sempre.')
			doPlayerSendTextMessage(cid,22,"Voce recebeu uma bp de life ring.")
			doPlayerSendTextMessage(cid, 20, 'Ainda lhe resta ' .. dsp - 20 .. ' Dragon Souls Points.')
			container = doPlayerAddItem(cid, 2000, 1)
			doAddContainerItem(container, 2214, 1)
			doAddContainerItem(container, 2214, 1)
			doAddContainerItem(container, 2214, 1)
			doAddContainerItem(container, 2214, 1)
			doAddContainerItem(container, 2214, 1)
			doAddContainerItem(container, 2214, 1)
			doAddContainerItem(container, 2214, 1)
			doAddContainerItem(container, 2214, 1)
			doAddContainerItem(container, 2214, 1)
			doAddContainerItem(container, 2214, 1)
			doAddContainerItem(container, 2214, 1)
			doAddContainerItem(container, 2214, 1)
			doAddContainerItem(container, 2214, 1)
			doAddContainerItem(container, 2214, 1)
			doAddContainerItem(container, 2214, 1)
			doAddContainerItem(container, 2214, 1)
			doAddContainerItem(container, 2214, 1)
			doAddContainerItem(container, 2214, 1)
			doAddContainerItem(container, 2214, 1)
			doAddContainerItem(container, 2214, 1)
			talk_state = 0
		else
			selfSay('Desculpe, mas voce não tem DSP\'s suficiente.')
		end

		elseif talk_state == 33 and msgcontains(msg, 'yes') then	-- lmf
		if getPlayerItemCount(cid,6527) >= 15 then
			doPlayerTakeItem(cid,6527,15)
			selfSay('Aqui esta! Obrigado e volte sempre.')
			doPlayerSendTextMessage(cid,22,"Voce recebeu um Large Mana fluid.")
			doPlayerSendTextMessage(cid, 20, 'Ainda lhe resta ' .. dsp - 15 .. ' Dragon Souls Points.')
			doPlayerAddItem(cid, 13690, 100)
			talk_state = 0
		else
			selfSay('Desculpe, mas voce não tem DSP\'s suficiente.')
		end

		elseif talk_state == 34 and msgcontains(msg, 'yes') then	-- B ring
		if getPlayerItemCount(cid,6527) >= 40 then
			doPlayerTakeItem(cid,6527,40)
			selfSay('Aqui esta! Obrigado e volte sempre.')
			doPlayerSendTextMessage(cid,22,"Voce recebeu uma bp de Blessed Ring.")
			doPlayerSendTextMessage(cid, 20, 'Ainda lhe resta ' .. dsp - 40 .. ' Dragon Souls Points.')
			container = doPlayerAddItem(cid, 2000, 1)
			doAddContainerItem(container, 13689, 1)
			doAddContainerItem(container, 13689, 1)
			doAddContainerItem(container, 13689, 1)
			doAddContainerItem(container, 13689, 1)
			doAddContainerItem(container, 13689, 1)
			doAddContainerItem(container, 13689, 1)
			doAddContainerItem(container, 13689, 1)
			doAddContainerItem(container, 13689, 1)
			doAddContainerItem(container, 13689, 1)
			doAddContainerItem(container, 13689, 1)
			doAddContainerItem(container, 13689, 1)
			doAddContainerItem(container, 13689, 1)
			doAddContainerItem(container, 13689, 1)
			doAddContainerItem(container, 13689, 1)
			doAddContainerItem(container, 13689, 1)
			doAddContainerItem(container, 13689, 1)
			doAddContainerItem(container, 13689, 1)
			doAddContainerItem(container, 13689, 1)
			doAddContainerItem(container, 13689, 1)
			doAddContainerItem(container, 13689, 1)
			talk_state = 0
		else
			selfSay('Desculpe, mas voce não tem DSP\'s suficiente.')
		end

		elseif talk_state == 35 and msgcontains(msg, 'yes') then	-- tp
		if getPlayerItemCount(cid,6527) >= 25 then
			doPlayerTakeItem(cid,6527,25)
			selfSay('Aqui esta! Obrigado e volte sempre.')
			doPlayerSendTextMessage(cid,22,"Voce recebeu 10 Teleports.")
			doPlayerSendTextMessage(cid, 20, 'Ainda lhe resta ' .. dsp - 25 .. ' Dragon Souls Points.')
			doPlayerAddItem(cid, 13691, 10)
			talk_state = 0
		else
			selfSay('Desculpe, mas voce não tem DSP\'s suficiente.')
		end

		elseif talk_state == 36 and msgcontains(msg, 'yes') then	-- eoe1
		if getPlayerItemCount(cid,6527) >= 30 then
			doPlayerTakeItem(cid,6527,30)
			selfSay('Aqui esta! Obrigado e volte sempre.')
			doPlayerSendTextMessage(cid,22,"Voce recebeu 50 Small Elixir of Experience.")
			doPlayerSendTextMessage(cid, 20, 'Ainda lhe resta ' .. dsp - 30 .. ' Dragon Souls Points.')
			doPlayerAddItem(cid, 13692, 50)
			talk_state = 0
		else
			selfSay('Desculpe, mas voce não tem DSP\'s suficiente.')
		end

		elseif talk_state == 37 and msgcontains(msg, 'yes') then	-- eoe2
		if getPlayerItemCount(cid,6527) >= 50 then
			doPlayerTakeItem(cid,6527,50)
			selfSay('Aqui esta! Obrigado e volte sempre.')
			doPlayerSendTextMessage(cid,22,"Voce recebeu 50 Normal Elixir of Experience.")
			doPlayerSendTextMessage(cid, 20, 'Ainda lhe resta ' .. dsp - 50 .. ' Dragon Souls Points.')
			doPlayerAddItem(cid, 13693, 50)
			talk_state = 0
		else
			selfSay('Desculpe, mas voce não tem DSP\'s suficiente.')
		end

		elseif talk_state == 38 and msgcontains(msg, 'yes') then	-- ftxp
		if getPlayerItemCount(cid,6527) >= 50 then
			doPlayerTakeItem(cid,6527,50)
			selfSay('Aqui esta! Obrigado e volte sempre.')
			doPlayerSendTextMessage(cid,22,"Voce recebeu 1 Fighting Spirit.")
			doPlayerSendTextMessage(cid, 20, 'Ainda lhe resta ' .. dsp - 50 .. ' Dragon Souls Points.')
			doPlayerAddItem(cid, 4863, 1)
			talk_state = 0
		else
			selfSay('Desculpe, mas voce não tem DSP\'s suficiente.')
		end

		elseif talk_state == 39 and msgcontains(msg, 'yes') then	-- energetico
		if getPlayerItemCount(cid,6527) >= 20 then
			doPlayerTakeItem(cid,6527,20)
			selfSay('Aqui esta! Obrigado e volte sempre.')
			doPlayerSendTextMessage(cid,22,"Voce recebeu um Energético.")
			doPlayerSendTextMessage(cid, 20, 'Ainda lhe resta ' .. dsp - 20 .. ' Dragon Souls Points.')
			doPlayerAddItem(cid, 6106, 1)
			talk_state = 0
		else
			selfSay('Desculpe, mas voce não tem DSP\'s suficiente.')
		end

		elseif talk_state == 40 and msgcontains(msg, 'yes') then	-- Blood
		if getPlayerItemCount(cid,6527) >= 50 then
			doPlayerTakeItem(cid,6527,50)
			selfSay('Aqui esta! Obrigado e volte sempre.')
			doPlayerSendTextMessage(cid,22,"Voce recebeu uma bp de Blood of God's.")
			doPlayerSendTextMessage(cid, 20, 'Ainda lhe resta ' .. dsp - 50 .. ' Dragon Souls Points.')
			container = doPlayerAddItem(cid, 2000, 1)
			doAddContainerItem(container, 6558, 1)
			doAddContainerItem(container, 6558, 1)
			doAddContainerItem(container, 6558, 1)
			doAddContainerItem(container, 6558, 1)
			doAddContainerItem(container, 6558, 1)
			doAddContainerItem(container, 6558, 1)
			doAddContainerItem(container, 6558, 1)
			doAddContainerItem(container, 6558, 1)
			doAddContainerItem(container, 6558, 1)
			doAddContainerItem(container, 6558, 1)
			doAddContainerItem(container, 6558, 1)
			doAddContainerItem(container, 6558, 1)
			doAddContainerItem(container, 6558, 1)
			doAddContainerItem(container, 6558, 1)
			doAddContainerItem(container, 6558, 1)
			doAddContainerItem(container, 6558, 1)
			doAddContainerItem(container, 6558, 1)
			doAddContainerItem(container, 6558, 1)
			doAddContainerItem(container, 6558, 1)
			doAddContainerItem(container, 6558, 1)
			talk_state = 0
		else
			selfSay('Desculpe, mas voce não tem DSP\'s suficiente.')
		end


		elseif talk_state == 41 and msgcontains(msg, 'yes') then	-- Dsp
		 if pay(cid,1000000) then
			doPlayerAddItem(cid,6527,100)
			selfSay('Aqui esta! Obrigado e volte sempre.')
			doPlayerSendTextMessage(cid,22,"Voce recebeu 100 Dragon Souls Points.")
			talk_state = 0
		else
			selfSay('Desculpe, mas voce não tem dinheiro suficiente.')
		end






		elseif msgcontains(msg, 'no') and (talk_state >= 1 and talk_state <= 34) then
			selfSay('Ok then.')
			talk_state = 0
		end
	-- Place all your code in here. Remember that hi, bye and all that stuff is already handled by the npcsystem, so you do not have to take care of that yourself.
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())