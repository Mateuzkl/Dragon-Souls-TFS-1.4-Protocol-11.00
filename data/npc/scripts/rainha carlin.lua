
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

	preco = getPlayerLevel(cid)*3
    	bless = getPlayerBlessing(cid,1)
	vezes = getResets(cid)
	rubys = (getPlayerLevel(cid)*4000)*(vezes*30*2)/1000000
	
		if msgcontains(msg, 'neckla4ce') then
			selfSay('I only need a mysterious, dragon breath, scorpion, platinum, fluids and vampire tooth, accept change all for a Elemental necklace?')
			talk_state = 1

		elseif msgcontains(msg, 'amul3et') then
			selfSay('I only need a Ialamar, frozzen, sickness, Samantha, Mastafar, priest and eletric, accept change all for a Spirit Elemental amulet?')
			talk_state = 2

		elseif msgcontains(msg, 'mag3ic') then
			selfSay('I only need a Merlian, relic of the hell, Broonier, Thordain, dark wyzard, angel and gaya, accept change all for a Elemental magic amulet?')
			talk_state = 3

		elseif msgcontains(msg, 'ener3gyze') then
			selfSay('I can energyze your necklace for 50k, amulet for 100k or your magic amulet for 150k, do you want energyze?')
			talk_state = 4

		elseif msgcontains(msg, 'bles3s') or msgcontains(msg, 'blessing') then
			selfSay('Bless a mortal? Hmm... Sure I can bless, but it will not be cheap, what do you say about ' .. preco .. 'k?')
			talk_state = 5

		elseif msgcontains(msg, 'valan') then
		if vezes == -1 or vezes == 0 then
			selfSay('Reset a valan? Hmm... First time? Ok, i will do it free this time!')
			talk_state = 6
		else
			selfSay('Reset a valan? Hmm.. Sure I can, But it will not be cheap, what do you say about 10 ruby coins?')
			talk_state = 6
		end


		elseif msgcontains(msg, 'job') then
			selfSay('I am a servent of Merlian!')

		elseif msgcontains(msg, 'offer') then
			selfSay('say valan')

		elseif msgcontains(msg, 'sell') then
			selfSay('I am not a merchant!')

		elseif msgcontains(msg, 'buy') then
			selfSay('I am not a merchant!')

		elseif msgcontains(msg, 'quest') then
			selfSay('Ha! You are only a novice!')

		elseif msgcontains(msg, 'mission') then
			selfSay('Ha! You are only a novice!')

-- neck
	elseif talk_state == 1 then
	if msgcontains(msg, 'yes') then
		if getPlayerItemCount(cid,2198) >= 1 and getPlayerItemCount(cid,2161) >= 1 and getPlayerItemCount(cid,2170) >= 1 and getPlayerItemCount(cid,2171) >= 1 and getPlayerItemCount(cid,2172) >= 1 and getPlayerItemCount(cid,2201) >= 1 then
			selfSay('Its all yours!')
			doPlayerSendTextMessage(cid,22,"Voce recebeu um Elemental necklace.")
  			doSendMagicEffect(getPlayerPosition(cid),12)
			doPlayerRemoveItem(cid,2198,1)
			doPlayerRemoveItem(cid,2161,1)
			doPlayerRemoveItem(cid,2170,1)
			doPlayerRemoveItem(cid,2171,1)
			doPlayerRemoveItem(cid,2172,1)
			doPlayerRemoveItem(cid,2201,1)
			doPlayerAddItem(cid,2197,1)
			talk_state = 0
			else
			selfSay('You dont have this itens!')
			talk_state = 0
			end
		end
-- amulet

	elseif talk_state == 2 then
	if msgcontains(msg, 'yes') then
		if getPlayerItemCount(cid,2129) >= 1 and getPlayerItemCount(cid,2133) >= 1 and getPlayerItemCount(cid,2130) >= 1 and getPlayerItemCount(cid,2199) >= 1 and getPlayerItemCount(cid,2135) >= 1 and getPlayerItemCount(cid,2126) >= 1 and getPlayerItemCount(cid,2131) >= 1 then
			selfSay('Its all yours!')
			doPlayerSendTextMessage(cid,22,"Voce recebeu um Spirit Elemental amulet.")
  			doSendMagicEffect(getPlayerPosition(cid),12)
			doPlayerRemoveItem(cid,2129,1)
			doPlayerRemoveItem(cid,2133,1)
			doPlayerRemoveItem(cid,2130,1)
			doPlayerRemoveItem(cid,2199,1)
			doPlayerRemoveItem(cid,2135,1)
			doPlayerRemoveItem(cid,2126,1)
			doPlayerRemoveItem(cid,2131,1)
			doPlayerAddItem(cid,2173,1)
			talk_state = 0
			else
			selfSay('You dont have this itens!')
			talk_state = 5
			end
		end

	elseif talk_state == 3 then
	if msgcontains(msg, 'yes') then
		if getPlayerItemCount(cid,2218) >= 1 and getPlayerItemCount(cid,2142) >= 1 and getPlayerItemCount(cid,2132) >= 1 and getPlayerItemCount(cid,2136) >= 1 and getPlayerItemCount(cid,2138) >= 1 and getPlayerItemCount(cid,2200) >= 1 and getPlayerItemCount(cid,2196) >= 1 then
			selfSay('Its all yours!')
			doPlayerSendTextMessage(cid,22,"Voce recebeu um Elemental magic amulet.")
  			doSendMagicEffect(getPlayerPosition(cid),12)
			doPlayerRemoveItem(cid,2218,1)
			doPlayerRemoveItem(cid,2142,1)
			doPlayerRemoveItem(cid,2132,1)
			doPlayerRemoveItem(cid,2136,1)
			doPlayerRemoveItem(cid,2138,1)
			doPlayerRemoveItem(cid,2200,1)
			doPlayerRemoveItem(cid,2196,1)
			doPlayerAddItem(cid,2125,1)
			talk_state = 0
			else
			selfSay('You dont have this itens!')
			talk_state = 5
			end
		end
-- energ

	elseif talk_state == 4 then
	if msgcontains(msg, 'yes') and getPlayerItemCount(cid,2197) >= 1 then
		if pay(cid,50000) then
			selfSay('Its all yours!')
			doPlayerSendTextMessage(cid,22,"Voce recebeu Energizou seu Elemental necklace.")
  			doSendMagicEffect(getPlayerPosition(cid),12)
			doPlayerRemoveItem(cid,2197,1)
			doPlayerAddItem(cid,13682,1)
			talk_state = 0
			else
			selfSay('You dont have this money!')
			talk_state = 0
			end

	elseif msgcontains(msg, 'yes') and getPlayerItemCount(cid,2173) >= 1 then
		if pay(cid,100000) then
			selfSay('Its all yours!')
			doPlayerSendTextMessage(cid,22,"Voce recebeu Energizou seu Spirit Elemental amulet.")
  			doSendMagicEffect(getPlayerPosition(cid),12)
			doPlayerRemoveItem(cid,2173,1)
			doPlayerAddItem(cid,13683,1)
			talk_state = 0
			else
			selfSay('You dont have this money!')
			talk_state = 0
			end

	elseif msgcontains(msg, 'yes') and getPlayerItemCount(cid,2125) >= 1 then
		if pay(cid,150000) then
			selfSay('Its all yours!')
			doPlayerSendTextMessage(cid,22,"Voce recebeu Energizou seu Elemental magic amulet.")
  			doSendMagicEffect(getPlayerPosition(cid),12)
			doPlayerRemoveItem(cid,2125,1)
			doPlayerAddItem(cid,13684,1)
			talk_state = 0
			else
			selfSay('You dont have this money!')
			talk_state = 0
			end

	elseif msgcontains(msg, 'yes') and getPlayerItemCount(cid,2197) >= 0 and getPlayerItemCount(cid,2125) >= 0 and getPlayerItemCount(cid,2173) >= 0 then
			selfSay('You dont have this item!')
			talk_state = 0



		end

-- bless

	elseif talk_state == 5 then
	if msgcontains(msg, 'yes') then
	if bless then
		selfSay('You are already blessed my little mortal.')
		talk_state = 0
		else
        if isPremium(cid) then
	if pay(cid,preco*1000) then
		selfSay('Receive this bless mortal, with the gods touch i bless you!')
		doPlayerSendTextMessage(cid,22,"Voce recebeu a benção de Isolda.")
                doPlayerAddBlessing(cid, 1)
                doPlayerAddBlessing(cid, 2)
  		doSendMagicEffect(getPlayerPosition(cid),12)
		talk_state = 0
		else
		selfSay('Sorry mortal, but you dont have this monney!')
		talk_state = 0
		end
		else
		selfSay('Sorry but only can bless a mortal premmy.')
		talk_state = 0
		end

		end
		end

-- reset

	elseif talk_state == 6 then
	--rubys = (getPlayerLevel(cid)*4000)*(vezes*10)/1000000)
	if msgcontains(msg, 'yes') then
        if isPremium(cid) then
        if getPlayerLevel(cid) >= 200 then
        if getPlayerVocation(cid) >= 1 then
	--if pay(cid,(getPlayerLevel(cid)*4000)*(vezes*10)) then
	

        if getPlayerVocation(cid) == 13 then	-- deuses
        if getPlayerLevel(cid) >= 500 then
	if getPlayerItemCount(cid,13685) >= rubys then
		selfSay('Welcome new god!')
		doPlayerSendTextMessage(cid,22,"Você resetou seu personagem.")
		health = getPlayerMaxHealth(cid)
		mana = getPlayerMaxMana(cid)
		doPlayerAbortExp(cid,getPlayerExperience(cid))
           doPlayerIncExp(cid,4200)
		setPlayerMaxHealth(cid, (health/10)*(vezes+1))
		doPlayerAddHealth(cid,(health/10)*(vezes+1))
		setPlayerMaxMana(cid, (mana/15)*(vezes+1))
		doPlayerAddMana(cid,(mana/15)*(vezes+1))
           setPlayerMaxCapacity(cid,360)
		doPlayerAddMagicLevel(cid,25)
  		doSendMagicEffect(getPlayerPosition(cid),12)
		doPlayerAddResets(cid,1)
		doPlayerRemoveItem(cid,13685,rubys)
		talk_state = 0
		else
		selfSay('Sorry mortal, but you dont have this monney!')
		talk_state = 0
		end
		else
		selfSay('Sorry, but only gods level 500 or above can do that!')
		talk_state = 0
		end
	end
        if getPlayerVocation(cid) == 14 then
        if getPlayerLevel(cid) >= 500 then
	if getPlayerItemCount(cid,13685) >= rubys then
		selfSay('Welcome new god!')
		doPlayerSendTextMessage(cid,22,"Você resetou seu personagem.")
		health = getPlayerMaxHealth(cid)
		mana = getPlayerMaxMana(cid)
		doPlayerAbortExp(cid,getPlayerExperience(cid))
           doPlayerIncExp(cid,4200)
		setPlayerMaxHealth(cid, (health/10)*(vezes+1))
		doPlayerAddHealth(cid,(health/10)*(vezes+1))
		setPlayerMaxMana(cid, (mana/15)*(vezes+1))
		doPlayerAddMana(cid,(mana/15)*(vezes+1))
           setPlayerMaxCapacity(cid,360)
		doPlayerAddMagicLevel(cid,25)
  		doSendMagicEffect(getPlayerPosition(cid),12)
		doPlayerAddResets(cid,1)
		doPlayerRemoveItem(cid,13685,rubys)
		talk_state = 0
		else
		selfSay('Sorry mortal, but you dont have this monney!')
		talk_state = 0
		end
		else
		selfSay('Sorry, but only gods level 500 or above can do that!')
		talk_state = 0
		end
	end
        if getPlayerVocation(cid) == 15 then
        if getPlayerLevel(cid) >= 500 then
	if getPlayerItemCount(cid,13685) >= rubys then
		selfSay('Welcome new god!')
		doPlayerSendTextMessage(cid,22,"Você resetou seu personagem.")
           
		health = getPlayerMaxHealth(cid)
		mana = getPlayerMaxMana(cid)
		doPlayerAbortExp(cid,getPlayerExperience(cid))
           doPlayerIncExp(cid,4200)
		setPlayerMaxHealth(cid, (health/10)*(vezes+1))
		doPlayerAddHealth(cid,(health/10)*(vezes+1))
		setPlayerMaxMana(cid, (mana/15)*(vezes+1))
		doPlayerAddMana(cid,(mana/15)*(vezes+1))
           setPlayerMaxCapacity(cid,360)
		doPlayerAddMagicLevel(cid,2)
		doPlayerAddSkill(cid,4,25) 
		doPlayerAddSkill(cid,5,25) 
  		doSendMagicEffect(getPlayerPosition(cid),12)
		doPlayerAddResets(cid,1)
		doPlayerRemoveItem(cid,13685,rubys)
		talk_state = 0
		else
		selfSay('Sorry mortal, but you dont have this monney!')
		talk_state = 0
		end
		else
		selfSay('Sorry, but only gods level 500 or above can do that!')
		talk_state = 0
		end
	end

        if getPlayerVocation(cid) == 16 then
        if getPlayerLevel(cid) >= 500 then
	if getPlayerItemCount(cid,13685) >= rubys then
		selfSay('Welcome new god!')
		doPlayerSendTextMessage(cid,22,"Você resetou seu personagem.")
		health = getPlayerMaxHealth(cid)
		mana = getPlayerMaxMana(cid)
		doPlayerAbortExp(cid,getPlayerExperience(cid))
           doPlayerIncExp(cid,4200)
		setPlayerMaxHealth(cid, (health/10)*(vezes+1))
		doPlayerAddHealth(cid,(health/10)*(vezes+1))
		setPlayerMaxMana(cid, (mana/15)*(vezes+1))
		doPlayerAddMana(cid,(mana/15)*(vezes+1))
           setPlayerMaxCapacity(cid,360)
		doPlayerAddSkill(cid,0,25) 
		doPlayerAddSkill(cid,1,25) 
		doPlayerAddSkill(cid,2,25) 
		doPlayerAddSkill(cid,3,25) 
		doPlayerAddSkill(cid,5,25) 
  		doSendMagicEffect(getPlayerPosition(cid),12)
		doPlayerAddResets(cid,1)
		doPlayerRemoveItem(cid,13685,rubys)
		talk_state = 0
		else
		selfSay('Sorry mortal, but you dont have this monney!')
		talk_state = 0
		end
		else
		selfSay('Sorry, but only gods level 500 or above can do that!')
		talk_state = 0
		end
	end

	if getResets(cid) <= 0 and getPlayerVocation(cid) >= 8 and getPlayerLevel(cid) >= 200 then
		setPlayerStorageValue(cid,7772,1)
	end
	
        if getPlayerVocation(cid) >= 1 and getPlayerVocation(cid) < 5 then	-- semis
	if getPlayerItemCount(cid,2160) >= 10 then
		selfSay('Oh! Now you are a Valan!')

        	if getPlayerVocation(cid) >= 1 and getPlayerVocation(cid) < 3 then
		doPlayerAddMagicLevel(cid,15)
           setPlayerMaxCapacity(cid,360)
		end
        	if getPlayerVocation(cid) == 3 then
		doPlayerAddMagicLevel(cid,2)
		doPlayerAddSkill(cid,4,15)
		doPlayerAddSkill(cid,5,15)
           setPlayerMaxCapacity(cid,360)
		end
        	if getPlayerVocation(cid) == 4 then
doPlayerAddMagicLevel(cid,1)
           doPlayerAddSkill(cid,0,15)
           doPlayerAddSkill(cid,1,15)
           doPlayerAddSkill(cid,2,15)
           doPlayerAddSkill(cid,3,15)
           doPlayerAddSkill(cid,5,15)
           setPlayerMaxCapacity(cid,360)
		end

		doPlayerSendTextMessage(cid,22,"Você evoluiu seu espírito a Valan.")
		doPlayerAbortExp(cid,getPlayerExperience(cid))
           doPlayerIncExp(cid,4200)
		setPlayerMaxHealth(cid,185)
		doPlayerAddHealth(cid,185)
		setPlayerMaxMana(cid,35)
		doPlayerAddMana(cid,35)
		doPlayerSetVocation(cid, getPlayerVocation(cid)+8)
  		doSendMagicEffect(getPlayerPosition(cid),12)
		doPlayerRemoveItem(cid,2160,10)
		talk_state = 0

		else
		selfSay('Sorry, but you dont have the 10 Crystal Coin!')
		talk_state = 0
		end
	end

		else
		selfSay('Sorry, but only gods i can do that!')
		talk_state = 0
		end
		else
		selfSay('Sorry, but only mortais level 200 or above can do that!')
		talk_state = 0
		end
		else
		selfSay('Sorry but only can reset a valan premmy.')
		talk_state = 0
		end

		end

------------------------------------------------ confirm no ------------------------------------------------
		elseif msgcontains(msg, 'no') and (talk_state >= 1 and talk_state <= 34) then
			selfSay('Ok than.')
			talk_state = 0
		end
	-- Place all your code in here. Remember that hi, bye and all that stuff is already handled by the npcsystem, so you do not have to take care of that yourself.
	return true
end

function teste(cid)

end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())


	


