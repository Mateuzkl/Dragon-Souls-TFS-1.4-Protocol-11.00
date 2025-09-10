
--------------------------------------------------------------------------------------------
------------------------------------ Advanced Addon NPC ------------------------------------
-------------------------------- Script made by teh_pwnage ---------------------------------
--------------- Special thanks to: mokerhamer, Xidaozu and Jiddo, deaths'life --------------
------------------------------- Thanks also to everyone else -------------------------------
------------------------------ NPC based on Evolutions V0.7.7 ------------------------------
--------------------------------------------------------------------------------------------
local emo = createConditionObject(CONDITION_REGENERATION)
setConditionParam(emo, COMBAT_PARAM_DISPEL, 60)


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

	
		if msgcontains(msg, 'offer') then
			selfSay('Oh, i can heal you.')
			talk_state = 1

		elseif msgcontains(msg, 'job') then
			selfSay('I am the doctor of this town!')

		elseif msgcontains(msg, 'offer') then
			selfSay('I can heal you.')

		elseif msgcontains(msg, 'sell') then
			selfSay('I am not a merchant!')

		elseif msgcontains(msg, 'buy') then
			selfSay('I am not a merchant!')

		elseif msgcontains(msg, 'quest') then
			selfSay('Hmm... I dont know!')

		elseif msgcontains(msg, 'mission') then
			selfSay('I dont have nothing to you do!')


		elseif msgcontains(msg, 'heal') then
			selfSay('Want i heal you for 100 gps?')
			talk_state = 1

		elseif msgcontains(msg, 'poisoned') then
			selfSay('I dont have nothing to you do!')
			talk_state = 2

		elseif msgcontains(msg, 'blending') then
			selfSay('Wanna i cure your blending for 1000 gps?')
			talk_state = 3

		elseif msgcontains(msg, 'yes') and talk_state == 1 then
		if pay(cid,100) then
     		doSendAnimatedText(getPlayerPosition(cid),"Health!",71)
  		doSendMagicEffect(getPlayerPosition(cid),12)
   		doPlayerAddHealth(cid,99999)
		selfSay('Brandnew!')
		talk_state = 0
		else
		selfSay('You don\'t have this money.')
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