local focus = 0
local talk_start = 0
local target = 0

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

  	if (msgcontains(msg, 'hi') and (focus == 0)) and getDistanceToCreature(cid) < 2 then
 		selfSay('Ialas ' .. creatureGetName(cid) .. '! Are you sure, want train to be a Pure Druid? So say "test".')
 		focus = cid
 		talk_start = os.clock()

	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 2 then
  		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')

  	elseif focus == cid then
		talk_start = os.clock()

	if msgcontains(msg, 'test') then
		selfSay('Nice choise pure soul. Where Are you from, Brazil or foreigner?')
		talk_state = 1

-- pais

	elseif talk_state == 1 then
		if msgcontains(msg, 'brazil') or msgcontains(msg, 'brasil') then
		selfSay('Que otimo! Vamos ao treinamento.')
		selfSay('Druids(Druidas), sua força provem da elevação do espirito e o contato com os elementos, suas magias sao focadas em cura e dominio de elementos, mas seu corpo e sua constituição são fracos.')
		selfSay('E então... Vamos ao teste?')
		talk_state = 2
else
		selfSay('Hmm, i never travel to there, but... Lets start the training!')
		selfSay('Druids, their strengh is gain by the spirit elevation ans contact with elements, their magic are focused in healing and elements domain, but their body and constituicion are weak.')
		selfSay('So, lets go to test... Ready?')
		talk_state = 4
		end

-- yes 1

	elseif talk_state == 2 then
		if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
		selfSay('Seu teste conciste com o convivio na natureza e a paciencia que isso nos traz.')
		selfSay('Meu jardin provem de frutos que a natureza pode nos oferecer, quero que traga para mim, 100 Blueberry colhidos na hora, e pacientemente.')
		selfSay('Vamos?')
		talk_state = 3
		end

	elseif talk_state == 4 then
		if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
		selfSay('What all you will need do is!')
		selfSay('My garden have fruits that the nature can provide, i want you to bring me 100 fresh Blueberry, be patient!')
		selfSay('Ready?')
		talk_state = 5
		end

-- yes 2 (teleport)

	elseif talk_state == 3 then
		if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
		selfSay('Lhe aguardo no final, e lembre-se, paciencia e uma virtude.')
		travel(cid, 264, 179, 8)
 		end
  		focus = 0
		talk_state = 0

	elseif talk_state == 5 then
		if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
		selfSay('I will be waiting you in the end, and remenber, patient is an virtude.')
		travel(cid, 264, 179, 8)
 		end
  		focus = 0
		talk_state = 0


  	elseif msgcontains(msg, 'bye')  and getDistanceToCreature(cid) < 5 then
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
  	if (os.clock() - talk_start) > 120 then
  		if focus > 0 then
  			selfSay('Next Please...')
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
