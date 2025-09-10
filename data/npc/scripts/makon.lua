
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

		

-- historia de Kar'ce
	
		if msgcontains(msg, 'kar') then
			selfSay('Oh, the Flame of Kar\'ce? Many people think this is a legend, but it\'s not...')
			selfSay('Many years ago, this sword was forged on the hottest montain on the world...(say continue)')
			talk_state = 1

	elseif msgcontains(msg, 'continue') and talk_state == 1 then
			selfSay('Forged by a Legion of Devil minions, it have extremely strong bad vibrations!')
			selfSay('If any mortal find this sword, he will have to destroy it faster than the wind!')
			selfSay('...or the sword will destroy hes life!')
			talk_state = 0

		elseif msgcontains(msg, 'thordain') then
			selfSay('Haha! This Blacksmith dwarf is really wise... He lives in a deep mine south of here.')
			selfSay('Only a few humans have meet him cuz\' the way of hes place is inhabited by many mangy dwarves!')

		elseif msgcontains(msg, 'leon') then
			selfSay('Hmm... This name is not strange... Oh! I remenber of this young man!')
			selfSay('He was a treasure hunter! Really young by the way... One day he found a Map, he showed me...')
			selfSay('I never saw a map like that before, I warned him that it was dungerous to follow an unknown map...(say continue)')
			talk_state = 4

	elseif msgcontains(msg, 'continue') and talk_state == 4 then
			selfSay('But he was stubborn! He was obsessed by that map...')
			selfSay('Now i can\'t tell you were he is cuz\' he left the town and never came back!')
			selfSay('Poor young adventurer...')
			talk_state = 0

-- Raccoone derivados

		elseif msgcontains(msg, 'raccoon') then
			selfSay('Oh my loved town... Now turned into ruins! Did you know Raccoon History?')
			talk_state = 2

	elseif msgcontains(msg, 'yes') and talk_state == 2 then
			selfSay('Ok then.')

	elseif msgcontains(msg, 'no') and talk_state == 2 then
			selfSay('I expected...')
			selfSay('Raccoon is one of the first town built in this part of the world, it have been constructed by one great tribe...')
			selfSay('By all the years until now, it have faced many many wars and monsters raids... But this time there was no way of winning...(say continue)')
			talk_state = 3

	elseif msgcontains(msg, 'continue') and talk_state == 3 then
			selfSay('A curse is casted above our city, the Devils that live under our feets built an army vast beyond the imagination! Their servants are tormented souls of fallen warriors!')
			selfSay('By far this is the most powerfull army that we ever faced! I can\'t see a way to return our beloved city back...')
			selfSay('May the Gods bless and give us strength to face this horrible times.')
			talk_state = 0


		elseif msgcontains(msg, 'genesis') then
			selfSay('The genesis prophecie...')
			selfSay('The legend says that the world will be taken by the Devil-God Har\'dur, a beast created by Belkor...')
			selfSay('I guess it\'s not only a legend cuz\' Raccoon is suffering the 5° plage, the epidemy...(say continue)')
			talk_state = 5

	elseif msgcontains(msg, 'continue') and talk_state == 5 then
			selfSay('The epidemy fallen uppon us because someone found the Blade that Shimers in Light Blue!')
			talk_state = 0



-- har'dur e derivados

		elseif msgcontains(msg, 'har') then
			selfSay('Har\'dur is a Devil-God created by Belkor, one of the Supremes.')
			selfSay('In contradition of Amel and the other Supremes, Belkor created Har\'dur to be the God of Ambition.')
			selfSay('Because of this creation and other bad things Belkor made, he was arrested in the Supreme Spirits Crystal...(say continue)')
			talk_state = 6

	elseif msgcontains(msg, 'continue') and talk_state == 6 then
			selfSay('... After being arrested there, the Supremes canot touch the Crystal again to free him...')
			selfSay('An human can easily be killed by touching the Crystal, only a Semi-God can free him from hes punishment.')
			talk_state = 0


		elseif msgcontains(msg, 'spirits crystal') then
			selfSay('No one have ever found this crystal, prayse be the Gods by that... The catastrophe that would happen if someone free Belkor is unimaginable!')

		elseif msgcontains(msg, 'semi') then
			selfSay('The God Anoriel, son of Amel itself, have the power of transform a mere mortal into a Semi-God, the Valans!')

		elseif msgcontains(msg, 'valans') then
			selfSay('I never heard about any Valan yet... I think no human is good enough to be allowed to became a Semi-God, its just a prophecy... I guess!')

		elseif msgcontains(msg, 'prophecy') or msgcontains(msg, 'profecia') then
			selfSay('Ohh, the older prophecy... Well, a long history, when you enter on temple of Anoriel, you must have all rare tomes, the prophecy say when you put an right order on this tomes on altar, the stone of knowledge will disappear... But its only a mith, i guess!')

		elseif msgcontains(msg, 'tomes') then
			selfSay('Ohh, the rare tomes, its five tomes, i see two on my life, purple tome and red tome!')




-- misc

		elseif msgcontains(msg, 'job') then
			selfSay('I am an ancient monk of the Raccoon city!')

		elseif msgcontains(msg, 'offer') then
			selfSay('Sorry young one, i can offer you nothing but history.. and i have alot of them haha!')

		elseif msgcontains(msg, 'sell') then
			selfSay('Hehe! I\'m  ain\'t seling stuff.')

		elseif msgcontains(msg, 'buy') then
			selfSay('Hehe! I\'m  ain\'t buing stuff.')

		elseif msgcontains(msg, 'quest') then
			selfSay('Ha! This old man have no need for quests anymore.')

		elseif msgcontains(msg, 'mission') then
			selfSay('Ha! This old man have no need for missions anymore.')

		elseif msgcontains(msg, 'apocalypse') then
			selfSay('Sshh! Don\'t say this name near me!')

end

	-- Place all your code in here. Remember that hi, bye and all that stuff is already handled by the npcsystem, so you do not have to take care of that yourself.
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())