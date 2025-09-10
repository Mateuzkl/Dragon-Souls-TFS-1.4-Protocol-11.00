
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

		post = getPlayerStorageValue(cid,2078)
		
	
		if msgcontains(msg, 'mission') and post == 0 then
			selfSay('I am realy desapointed with you, but i realy need a hand, it will be like this, its your last chance, do you accept?')
			talk_state = 1

		elseif msgcontains(msg, 'mission') and post == -1 then
			selfSay('Oh, a helper, i really will need that, but this is not a simple job, but you accept to be my Assistant Postman?')
			talk_state = 1

		elseif msgcontains(msg, 'mission') and post == 1 then
			selfSay('Already lost? I will repeat, we have a problem in one mailbox not far from here, It is locked and i realy need those letters, I think you will need one Crowbar to break it, the mailbox is near the Amazon Camp, west from here.')
			talk_state = 0

		elseif msgcontains(msg, 'mission') and post == 2 then
			selfSay('oh, you back? you bring me my letters?')
			talk_state = 2

		elseif msgcontains(msg, 'mission') and post == 3 then
			selfSay('Oh, you think you are up to the next step? well here we go, now that you work for me I cant let you walk with this terrible cloths, we will do an uniform for you, go to Lina in Carlin and talk about Uniform, she will make one for you.')
  			doSendMagicEffect(getPlayerPosition(cid),12)
			setPlayerStorageValue(cid,2078,4)
			talk_state = 0

		elseif msgcontains(msg, 'mission') and post == 4 then
			selfSay('Already lost? Well i will repeat, go to Lina in Carlin and talk about Uniform, she will do one for you.')
			talk_state = 0

		elseif msgcontains(msg, 'mission') and post == 5 then
			selfSay('I said you to run to the Uniform , Didnt I??')
			talk_state = 0

		elseif msgcontains(msg, 'mission') and post == 6 then
			selfSay('I said you to run to the Uniform , Didnt I??')
			talk_state = 0

		elseif msgcontains(msg, 'mission') and post == 7 then
			selfSay('lets see if you are ready, i got something for you, i received a letter and we need to deliver something, remenber that we never open the clients deliverys, well, hes name is Stelios, you must find him, he locates in Femur Hills, but I dont have the locate place.')
			selfSay('go after him and ask about delivery, he will give the delivery for you and will say for who you must deliver, good luck!')
  			doSendMagicEffect(getPlayerPosition(cid),12)
			setPlayerStorageValue(cid,2078,8)
			talk_state = 0

		elseif msgcontains(msg, 'mission') and post == 8 then
			selfSay('Already Lost? well i will repeat, find Stelios in Femur Hills, talk about delivery, he will give the delivery for you and will say for who you must deliver, good luck!')
			talk_state = 0

		elseif msgcontains(msg, 'mission') and post == 10 then
			selfSay('Already done? cuz i need you to be done for we talk about promotion!')
			talk_state = 0

		elseif msgcontains(msg, 'mission') and post == 11 then
			selfSay('Hmm, no work for now, but be allert!')
			talk_state = 0

		elseif msgcontains(msg, 'job') then
			selfSay('I am the Master Poster!')

		elseif msgcontains(msg, 'offer') then
			selfSay('I am offering the best Postman work in all Lands!')

		elseif msgcontains(msg, 'sell') then
			selfSay('I am notselling nothing , just work!')

		elseif msgcontains(msg, 'buy') then
			selfSay('No no..!')

		elseif msgcontains(msg, 'quest') then
			selfSay('Every delivery is a quest!')

	elseif msgcontains(msg, 'promote') and post == 3 then
			selfSay('promote? lets work first right?')
			talk_state = 0

	elseif msgcontains(msg, 'promote') and post == 7 then
			selfSay('promote? lets work first right?')
			talk_state = 0

	elseif msgcontains(msg, 'promote') and post == 8 then
			selfSay('promote? lets work first right?')
			talk_state = 0


-- missao 1

	elseif msgcontains(msg, 'yes') and talk_state == 1 then
			selfSay('oh, great, but i good something for you, its simple, we have little problems with a mailbox not far from here, its locked and i need the letters inside it, i think that with a Crowbar you can break it, The Mailbox is in the Orcs near Amazon Camp west from here.')
			selfSay('Fix it and bring me my letters, if you do it , we talk about Promote.')
			doPlayerSendTextMessage(cid,19,"Nova quest adicionada 'O carteiro fiel.'.")
  			doSendMagicEffect(getPlayerPosition(cid),12)
			setPlayerStorageValue(cid,2078,1)
			talk_state = 0

	elseif msgcontains(msg, 'promote') and post == 1 then
			selfSay('promote? lets work first huh?')
			talk_state = 0

	elseif msgcontains(msg, 'promote') and post == 2 then
			selfSay('oh, you back? bring me my letters?')
			talk_state = 2

	elseif msgcontains(msg, 'promote') and post == 11 then
			selfSay('By now, no missions of promotion!')
			talk_state = 2

	elseif msgcontains(msg, 'yes') and talk_state == 2 then
		if getPlayerItemCount(cid,2598) >= 4 then
			selfSay('oh, Congratulations, you did a great job in this first test, when you are ready we will talk about your next mission')
			doPlayerTakeItem(cid,2598,4)
  			doSendMagicEffect(getPlayerPosition(cid),12)
			setPlayerStorageValue(cid,2078,3)
			else
			selfSay('I need all the letters!')
			end
			talk_state = 0
		

-- missao 2

	elseif msgcontains(msg, 'uniform') and post == 6 then
			selfSay('So, did you get your uniform?')
			talk_state = 3

	elseif msgcontains(msg, 'yes') and talk_state == 3 then
		if getPlayerItemCount(cid,6114) >= 1 then
			selfSay('Oh thats good! you can rest a bit, when you are ready we can talk about your next mission.')
			doPlayerTakeItem(cid,6114,1)
  			doSendMagicEffect(getPlayerPosition(cid),12)
			setPlayerStorageValue(cid,2078,7)
			talk_state = 0
			else
			selfSay('Hmm, but were is the uniform?')
			end

-- missao 3

		elseif msgcontains(msg, 'promote') and post == 10 then
			selfSay('oh, i knew that you deliver was great, so, welcome my new postman, here is your post officers hat! Now you can access all the PostMans Mailboxes in all the Land, well come, by now its it!')
			doPlayerAddItem(cid, 2665, 1)
		doPlayerSendTextMessage(cid,19,"Quest 'O carteiro fiel.' completada.")
  			doSendMagicEffect(getPlayerPosition(cid),12)
			setPlayerStorageValue(cid,2078,11)
			talk_state = 0
			local focus = 0
local talk_start = 0
local talk_state = 0
local costPerLevel = 300

dofile("./petConfig.lua")



function onThingMove(creature, thing, oldpos, oldstackpos)

end


function onCreatureAppear(creature)

end


function onCreatureDisappear(cid, pos)
if focus == cid then
selfSay('How rude!.')
focus = 0
talk_start = 0
end
end


function onCreatureTurn(creature)

end


function msgcontains(txt, str)
return (string.find(txt, str) and not string.find(txt, '(%w+)' .. str) and not string.find(txt, str .. '(%w+)'))
end


function onCreatureSay(cid, type, msg)
msg = string.lower(msg)
if getDistanceToCreature(cid) < 4 then
if (msgcontains(msg, 'hi') and (focus == 0)) then
selfSay('Hello ' .. creatureGetName(cid) .. '! I can take you to the train!')
focus = cid
talk_start = os.clock()

elseif msgcontains(msg, 'hi') and (focus ~= cid) then
selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')
end

if msgcontains(msg, 'revive') and focus == cid then
if isCreature(getPlayerStorageValue(cid, storages.petUid)) == 0 then
if getPlayerStorageValue(cid, storages.petIsOnline) == 2 then
selfSay('YOUR PET DIED?!, YOU\'R A BAD OWNER, THIS WILL COST YOU ' .. getPlayerLevel(cid)*costPerLevel .. ' GOLD COINS!, AGREE?!')
talk_state = 1
else
selfSay('Your pet is alive.')
end
else
selfSay('Your pet is standing next to you.')
end
talk_start = os.clock()
end
if msgcontains(msg, 'yes') and focus == cid and talk_state == 1 then
if doPlayerRemoveMoney(cid, getPlayerLevel(cid)*costPerLevel) == 1 then
setPlayerStorageValue(cid, storages.petIsOnline, 1)
selfSay('You can now summon again your pet.')
else
selfSay('You don\'t have enought money.')
end
talk_state = 0
talk_start = os.clock()
end 

if msgcontains(msg, 'bye') then
selfSay('Good bye, ' .. creatureGetName(cid) .. '!')
focus = 0
talk_start = 0
talk_state = 0
end
end
end


function onCreatureChangeOutfit(creature)

end


function onThink()

doNpcSetCreatureFocus(focus)
if (os.clock() - talk_start) > 30 then
if focus > 0 then
selfSay('Next Please...')
end
focus = 0
talk_state = 0
end
if focus ~= 0 then
if getDistanceToCreature(focus) > 5 then
talk_state = 0
selfSay('Good bye then.')
talk_state = 0
focus = 0
end
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

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())