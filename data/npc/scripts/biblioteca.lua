

local focus = 0
local talk_start = 0
local target = 0
local days = 0

function onThingMove(creature, thing, oldpos, oldstackpos)

end


function onCreatureAppear(creature)
end


function onCreatureDisappear(cid, pos)
  	if focus == cid then
          selfSay('Good bye then.')
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
	quest1 = getPlayerStorageValue(cid,6006)
	dist = getDistanceToCreature(cid)


  	if (msgcontains(msg, 'hi') and (focus == 0)) and dist < 3 then
		selfSay('Hello my young ' .. creatureGetName(cid) .. '! Welcome to my library, at this moment we dont have books, but new books are comming!')
  		focus = cid
		talk_start = os.clock()

	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 3 then
  		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')

  	elseif focus == cid then
		talk_start = os.clock()
	

	if msgcontains(msg, 'quest') then
		if quest1 == -1 then
		selfSay('Hmm... Let\'s me see...')
		selfSay('Many ages ago, on the second middle earth, Carlin sufered, with sure the most bloody war ever saw in this region, the undeads made an aliance with the poison masters, they attacked us with no mercy, we were exelent fighters, but two of us struggled with glory...')
		selfSay('Shima and Natalier, feared even by the most powerfull undeads, but i dont have time to tell you the whole tale, finally, we won this war, but we have losses, Shima and Natalier fallen.')
		selfSay('buried with them, their legendary weapons, made by Thordain. Your task is simple, find the graves, they are located in carlin.')
		doPlayerSendTextMessage(cid,19,"Nova quest adicionada 'Shima e Natalier, descansem em paz.'.")
  		doSendMagicEffect(getPlayerPosition(cid),12)
		setPlayerStorageValue(cid,6006,1)
  			focus = 0
  			talk_start = 0
		else
		selfSay('Hmm... I know so many quests, but now, i dont have time to tell you, another day, ok?')
		end
		
	elseif msgcontains(msg, 'offer') then
		selfSay('Hmm... I have nothing to offer now.')

	elseif msgcontains(msg, 'mission') then
		selfSay('I dont have nothing for you, maybe another day, ok?')



  	elseif msgcontains(msg, 'bye')  and getDistanceToCreature(cid) < 3 then
  		selfSay('Good bye, ' .. creatureGetName(cid) .. '!')
  			focus = 0
  			talk_start = 0

end
end
end


function onCreatureChangeOutfit(creature)

end


function onThink()
	doNpcSetCreatureFocus(focus)
  	if (os.clock() - talk_start) > 30 then
  		if focus > 0 then
  			selfSay('See you later.')
  		end
  			focus = 0
  	end
 	if focus ~= 0 then
 		if getDistanceToCreature(focus) > 5 then
 			selfSay('Good bye then.')
 			focus = 0
 		end
 	end
end
