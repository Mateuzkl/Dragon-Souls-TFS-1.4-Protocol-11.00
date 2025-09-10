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
			selfSay('Aceita uma "missao" ou deseja "trocar" algo?')

		elseif msgcontains(msg, 'knownledge') then
			selfSay('I have been in long trips and quests! One more dangerous than the other, now i am just traveling and wondering the world beauties!')

-- arena "Protect the King"

		elseif msgcontains(msg, 'missao') then
			if getPlayerStorageValue(cid,8113) == 1 then -- item 1
			if getPlayerItemCount(cid,2149) >= 10 then
				selfSay('Como prometido.')

        		if getPlayerVocation(cid) == 9 or getPlayerVocation(cid) == 13 then	
				doPlayerSendTextMessage(cid,22,"Voce recebeu 10 magic leveis.")
				doPlayerMagicLevel(cid,10)
  				doSendMagicEffect(getPlayerPosition(cid),12)
				doPlayerTakeItem(cid,2149,10)
				talk_state = 0
			end
       		 	if getPlayerVocation(cid) == 10 or getPlayerVocation(cid) == 14 then
				doPlayerSendTextMessage(cid,22,"Voce recebeu 10 magic leveis.")
				doPlayerMagicLevel(cid,10)
  				doSendMagicEffect(getPlayerPosition(cid),12)
				doPlayerTakeItem(cid,2149,10)
				talk_state = 0
			end
        		if getPlayerVocation(cid) == 11 or getPlayerVocation(cid) == 15 then
				doPlayerSendTextMessage(cid,22,"Voce recebeu 2 magic leveis e 10 skills.")
				doPlayerMagicLevel(cid,2)
				doPlayerAddSkill(cid,4,10)
				doPlayerAddSkill(cid,5,10)
  				doSendMagicEffect(getPlayerPosition(cid),12)
				doPlayerTakeItem(cid,2149,10)
				talk_state = 0
			end
			if getPlayerVocation(cid) == 12 or getPlayerVocation(cid) == 16 then
				doPlayerSendTextMessage(cid,22,"Voce recebeu 10 skills.")
				doPlayerAddSkill(cid,0,10)
				doPlayerAddSkill(cid,1,10)
				doPlayerAddSkill(cid,2,10)
				doPlayerAddSkill(cid,3,10)
				doPlayerAddSkill(cid,5,10)
  				doSendMagicEffect(getPlayerPosition(cid),12)
				doPlayerTakeItem(cid,2149,10)
				talk_state = 0
			end
				setPlayerStorageValue(cid,8113,2)
				

			else
				selfSay('Se você me conseguir 10 small emeralds posso lhe conseguir alguns atributos extras, o resto é com você.')
			end
			end

			if getPlayerStorageValue(cid,8113) == 2 then -- item 2
			if getPlayerItemCount(cid,2150) >= 10 then
				selfSay('Como prometido.')
				setPlayerStorageValue(cid,8113,3)

        		if getPlayerVocation(cid) == 9 or getPlayerVocation(cid) == 13 then	
				doPlayerSendTextMessage(cid,22,"Voce recebeu 20 magic leveis.")
				doPlayerMagicLevel(cid,20)
  				doSendMagicEffect(getPlayerPosition(cid),12)
				doPlayerTakeItem(cid,2150,10)
				talk_state = 0
			end
       		 	if getPlayerVocation(cid) == 10 or getPlayerVocation(cid) == 14 then
				doPlayerSendTextMessage(cid,22,"Voce recebeu 20 magic leveis.")
				doPlayerMagicLevel(cid,20)
  				doSendMagicEffect(getPlayerPosition(cid),12)
				doPlayerTakeItem(cid,2150,10)
				talk_state = 0
			end
        		if getPlayerVocation(cid) == 11 or getPlayerVocation(cid) == 15 then
				doPlayerSendTextMessage(cid,22,"Voce recebeu 4 magic leveis e 20 skills.")
				doPlayerMagicLevel(cid,4)
				doPlayerAddSkill(cid,4,20)
				doPlayerAddSkill(cid,5,20)
  				doSendMagicEffect(getPlayerPosition(cid),12)
				doPlayerTakeItem(cid,2150,10)
				talk_state = 0
			end
			if getPlayerVocation(cid) == 12 or getPlayerVocation(cid) == 16 then
				doPlayerSendTextMessage(cid,22,"Voce recebeu 20 skills.")
				doPlayerAddSkill(cid,0,20)
				doPlayerAddSkill(cid,1,20)
				doPlayerAddSkill(cid,2,20)
				doPlayerAddSkill(cid,3,20)
				doPlayerAddSkill(cid,5,20)
  				doSendMagicEffect(getPlayerPosition(cid),12)
				doPlayerTakeItem(cid,2150,10)
				talk_state = 0
			end

			else
				selfSay('Se você me conseguir 10 small amethysts posso lhe conseguir alguns atributos extras, o resto é com você.')
			end
			end

			if getPlayerStorageValue(cid,8113) == 3 then -- item 3
			if getPlayerItemCount(cid,2146) >= 10 then
				selfSay('Como prometido.')
				setPlayerStorageValue(cid,8113,4)

        		if getPlayerVocation(cid) == 9 or getPlayerVocation(cid) == 13 then	
				doPlayerSendTextMessage(cid,22,"Voce recebeu 30 magic leveis.")
				doPlayerMagicLevel(cid,30)
  				doSendMagicEffect(getPlayerPosition(cid),12)
				doPlayerTakeItem(cid,2146,10)
				talk_state = 0
			end
       		 	if getPlayerVocation(cid) == 10 or getPlayerVocation(cid) == 14 then
				doPlayerSendTextMessage(cid,22,"Voce recebeu 30 magic leveis.")
				doPlayerMagicLevel(cid,30)
  				doSendMagicEffect(getPlayerPosition(cid),12)
				doPlayerTakeItem(cid,2146,10)
				talk_state = 0
			end
        		if getPlayerVocation(cid) == 11 or getPlayerVocation(cid) == 15 then
				doPlayerSendTextMessage(cid,22,"Voce recebeu 6 magic leveis e 30 skills.")
				doPlayerMagicLevel(cid,6)
				doPlayerAddSkill(cid,4,30)
				doPlayerAddSkill(cid,5,30)
  				doSendMagicEffect(getPlayerPosition(cid),12)
				doPlayerTakeItem(cid,2146,10)
				talk_state = 0
			end
			if getPlayerVocation(cid) == 12 or getPlayerVocation(cid) == 16 then
				doPlayerSendTextMessage(cid,22,"Voce recebeu 30 skills.")
				doPlayerAddSkill(cid,0,30)
				doPlayerAddSkill(cid,1,30)
				doPlayerAddSkill(cid,2,30)
				doPlayerAddSkill(cid,3,30)
				doPlayerAddSkill(cid,5,30)
  				doSendMagicEffect(getPlayerPosition(cid),12)
				doPlayerTakeItem(cid,2146,10)
				talk_state = 0
			end

			else
				selfSay('Se você me conseguir 10 small sapphires posso lhe conseguir alguns atributos extras, o resto é com você.')
			end
			end

			if getPlayerStorageValue(cid,8113) == 4 then -- item 4
			if getPlayerItemCount(cid,2147) >= 10 then
				selfSay('Como prometido.')
				setPlayerStorageValue(cid,8113,5)

        		if getPlayerVocation(cid) == 9 or getPlayerVocation(cid) == 13 then	
				doPlayerSendTextMessage(cid,22,"Voce recebeu 40 magic leveis.")
				doPlayerMagicLevel(cid,40)
  				doSendMagicEffect(getPlayerPosition(cid),12)
				doPlayerTakeItem(cid,2147,10)
				talk_state = 0
			end
       		 	if getPlayerVocation(cid) == 10 or getPlayerVocation(cid) == 14 then
				doPlayerSendTextMessage(cid,22,"Voce recebeu 40 magic leveis.")
				doPlayerMagicLevel(cid,40)
  				doSendMagicEffect(getPlayerPosition(cid),12)
				doPlayerTakeItem(cid,2147,10)
				talk_state = 0
			end
        		if getPlayerVocation(cid) == 11 or getPlayerVocation(cid) == 15 then
				doPlayerSendTextMessage(cid,22,"Voce recebeu 8 magic leveis e 40 skills.")
				doPlayerMagicLevel(cid,8)
				doPlayerAddSkill(cid,4,40)
				doPlayerAddSkill(cid,5,40)
  				doSendMagicEffect(getPlayerPosition(cid),12)
				doPlayerTakeItem(cid,2147,10)
				talk_state = 0
			end
			if getPlayerVocation(cid) == 12 or getPlayerVocation(cid) == 16 then
				doPlayerSendTextMessage(cid,22,"Voce recebeu 40 skills.")
				doPlayerAddSkill(cid,0,40)
				doPlayerAddSkill(cid,1,40)
				doPlayerAddSkill(cid,2,40)
				doPlayerAddSkill(cid,3,40)
				doPlayerAddSkill(cid,5,40)
  				doSendMagicEffect(getPlayerPosition(cid),12)
				doPlayerTakeItem(cid,2147,10)
				talk_state = 0
			end

			else
				selfSay('Se você me conseguir 10 small rubys posso lhe conseguir alguns atributos extras, o resto é com você.')
			end
			end

			if getPlayerStorageValue(cid,8113) == 5 then -- item 5
			if getPlayerItemCount(cid,2145) >= 10 then
				selfSay('Como prometido.')
				setPlayerStorageValue(cid,8113,6)

        		if getPlayerVocation(cid) == 9 or getPlayerVocation(cid) == 13 then	
				doPlayerSendTextMessage(cid,22,"Voce recebeu 50 magic leveis.")
				doPlayerMagicLevel(cid,50)
  				doSendMagicEffect(getPlayerPosition(cid),12)
				doPlayerTakeItem(cid,2145,10)
				talk_state = 0
			end
       		 	if getPlayerVocation(cid) == 10 or getPlayerVocation(cid) == 14 then
				doPlayerSendTextMessage(cid,22,"Voce recebeu 50 magic leveis.")
				doPlayerMagicLevel(cid,50)
  				doSendMagicEffect(getPlayerPosition(cid),12)
				doPlayerTakeItem(cid,2145,10)
				talk_state = 0
			end
        		if getPlayerVocation(cid) == 11 or getPlayerVocation(cid) == 15 then
				doPlayerSendTextMessage(cid,22,"Voce recebeu 10 magic leveis e 50 skills.")
				doPlayerMagicLevel(cid,10)
				doPlayerAddSkill(cid,4,50)
				doPlayerAddSkill(cid,5,50)
  				doSendMagicEffect(getPlayerPosition(cid),12)
				doPlayerTakeItem(cid,2145,10)
				talk_state = 0
			end
			if getPlayerVocation(cid) == 12 or getPlayerVocation(cid) == 16 then
				doPlayerSendTextMessage(cid,22,"Voce recebeu 50 skills.")
				doPlayerAddSkill(cid,0,50)
				doPlayerAddSkill(cid,1,50)
				doPlayerAddSkill(cid,2,50)
				doPlayerAddSkill(cid,3,50)
				doPlayerAddSkill(cid,5,50)
  				doSendMagicEffect(getPlayerPosition(cid),12)
				doPlayerTakeItem(cid,2145,10)
				talk_state = 0
			end

			else
				selfSay('Se você me conseguir 10 small diamonds posso lhe conseguir alguns atributos extras, o resto é com você.')
			end
			end

		elseif msgcontains(msg, 'trocar') then
				selfSay('Troco big emerald, violet gem, blue gem, big ruby e yellow gem pelos devidos atributos!')
		
		elseif msgcontains(msg, 'big emerald') then
				selfSay('Aceita trocar big emerald por 10% de life e mana?')
				talk_state = 1
		
		elseif msgcontains(msg, 'yes') and talk_state == 1 then
			if getPlayerItemCount(cid,2155) >= 1 then
				selfSay('Muito obrigado!')

				health = (getCreatureMaxHealth(cid)/10)
				mana = (getCreatureMaxMana(cid)/10)
				hpnew = getCreatureMaxHealth(cid)+health
				mpnew = getCreatureMaxMana(cid)+mana

				doCreatureChangeMaxHealth(cid, hpnew)
				doCreatureAddHealth(cid,hpnew)
				doCreatureChangeMaxMana(cid, mpnew)
				doPlayerAddMana(cid,mpnew)
  				doSendMagicEffect(getPlayerPosition(cid),12)
				doPlayerTakeItem(cid,2155,1)

				doPlayerSendTextMessage(cid,22,"Voce recebeu "..health.." pontos de vida e "..mana.." pontos de mana.")
			else
				selfSay('Você não tem este item!')
			end

		elseif msgcontains(msg, 'violet gem') then
				selfSay('Aceita trocar violet gem por 20% de life e mana?')
				talk_state = 2
		
		elseif msgcontains(msg, 'yes') and talk_state == 2 then
			if getPlayerItemCount(cid,2153) >= 1 then
				selfSay('Muito obrigado!')

				health = (getCreatureMaxHealth(cid)/10)*2
				mana = (getCreatureMaxMana(cid)/10)*2
				hpnew = getCreatureMaxHealth(cid)+health
				mpnew = getCreatureMaxMana(cid)+mana

				doCreatureChangeMaxHealth(cid, hpnew)
				doCreatureAddHealth(cid,hpnew)
				doCreatureChangeMaxMana(cid, mpnew)
				doPlayerAddMana(cid,mpnew)
  				doSendMagicEffect(getPlayerPosition(cid),12)
				doPlayerTakeItem(cid,2153,1)

				doPlayerSendTextMessage(cid,22,"Voce recebeu "..health.." pontos de vida e "..mana.." pontos de mana.")
			else
				selfSay('Você não tem este item!')
			end


		elseif msgcontains(msg, 'blue gem') then
				selfSay('Aceita trocar blue gem por 30% de life e mana?')
				talk_state = 3
		
		elseif msgcontains(msg, 'yes') and talk_state == 3 then
			if getPlayerItemCount(cid,2158) >= 1 then
				selfSay('Muito obrigado!')

				health = (getCreatureMaxHealth(cid)/10)*3
				mana = (getCreatureMaxMana(cid)/10)*3
				hpnew = getCreatureMaxHealth(cid)+health
				mpnew = getCreatureMaxMana(cid)+mana

				doCreatureChangeMaxHealth(cid, hpnew)
				doCreatureAddHealth(cid,hpnew)
				doCreatureChangeMaxMana(cid, mpnew)
				doPlayerAddMana(cid,mpnew)
  				doSendMagicEffect(getPlayerPosition(cid),12)
				doPlayerTakeItem(cid,2158,1)

				doPlayerSendTextMessage(cid,22,"Voce recebeu "..health.." pontos de vida e "..mana.." pontos de mana.")
			else
				selfSay('Você não tem este item!')
			end


		elseif msgcontains(msg, 'big ruby') then
				selfSay('Aceita trocar big ruby por 40% de life e mana?')
				talk_state = 4
		
		elseif msgcontains(msg, 'yes') and talk_state == 4 then
			if getPlayerItemCount(cid,2156) >= 1 then
				selfSay('Muito obrigado!')

				health = (getCreatureMaxHealth(cid)/10)*4
				mana = (getCreatureMaxMana(cid)/10)*4
				hpnew = getCreatureMaxHealth(cid)+health
				mpnew = getCreatureMaxMana(cid)+mana

				doCreatureChangeMaxHealth(cid, hpnew)
				doCreatureAddHealth(cid,hpnew)
				doCreatureChangeMaxMana(cid, mpnew)
				doPlayerAddMana(cid,mpnew)
  				doSendMagicEffect(getPlayerPosition(cid),12)
				doPlayerTakeItem(cid,2156,1)

				doPlayerSendTextMessage(cid,22,"Voce recebeu "..health.." pontos de vida e "..mana.." pontos de mana.")
			else
				selfSay('Você não tem este item!')
			end


		elseif msgcontains(msg, 'yellow gem') then
				selfSay('Aceita trocar yellow gem por 50% de life e mana?')
				talk_state = 5
		
		elseif msgcontains(msg, 'yes') and talk_state == 5 then
			if getPlayerItemCount(cid,2154) >= 1 then
				selfSay('Muito obrigado!')

				health = (getCreatureMaxHealth(cid)/10)*5
				mana = (getCreatureMaxMana(cid)/10)*5
				hpnew = getCreatureMaxHealth(cid)+health
				mpnew = getCreatureMaxMana(cid)+mana

				doCreatureChangeMaxHealth(cid, hpnew)
				doCreatureAddHealth(cid,hpnew)
				doCreatureChangeMaxMana(cid, mpnew)
				doPlayerAddMana(cid,mpnew)
  				doSendMagicEffect(getPlayerPosition(cid),12)
				doPlayerTakeItem(cid,2154,1)

				doPlayerSendTextMessage(cid,22,"Voce recebeu "..health.." pontos de vida e "..mana.." pontos de mana.")
			else
				selfSay('Você não tem este item!')
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