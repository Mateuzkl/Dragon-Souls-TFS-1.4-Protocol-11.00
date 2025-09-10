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
 		selfSay('Hail ' .. creatureGetName(cid) .. '! Are you sure, want train to be a Heroic Knight? So say "test".')
 		focus = cid
 		talk_start = os.clock()

	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 2 then
  		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')

  	elseif focus == cid then
		talk_start = os.clock()

	if msgcontains(msg, 'test') then
		selfSay('Ha! Nice choise soldier, where did you from? Brazil or foreigner?')
		talk_state = 1

-- pais

	elseif talk_state == 1 then
		if msgcontains(msg, 'brazil') or msgcontains(msg, 'brasil') then
		selfSay('Muito bem então... Vamos começar o treinamento!')
		selfSay('Knights(Cavaleiros) e a vocação que provem mais força, eles são fortes, resistentes, e sabem usar muito bem qualquer arma de "melee" com maxima eficiencia!')
		selfSay('Pois vamos ao teste... Esta pronto?')
		talk_state = 2
else
		selfSay('Hmm, i never travel to there, but... Lets start the training!')
		selfSay('Knights are the toughest warriors. They are strong, resilient, and they know how to wield any melee weapon with fearsome efficiency.')
		selfSay('So, lets go to test... Ready?')
		talk_state = 4
		end

-- yes 1

	elseif talk_state == 2 then
		if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
		selfSay('Eis oque ira fazer para passar no teste soldado!')
		selfSay('Nossa sala de armamentos esta infestada de ratos, quero que voce desenfete essas pragas!')
		selfSay('Pronto?')
		talk_state = 3
		end

	elseif talk_state == 4 then
		if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
		selfSay('What all you will need do is!')
		selfSay('Our weapon room is infested with rats, i want you to defeat this plage!')
		selfSay('Ready?')
		talk_state = 5
		end

-- yes 2 (teleport)

	elseif talk_state == 3 then
		if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
		selfSay('Boa sorte soldado, aguardo voce no final do teste!')
		travel(cid, 291, 177, 8)
 		end
  		focus = 0
		talk_state = 0

	elseif talk_state == 5 then
		if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
		selfSay('Good luck soldier, i was waiting you on the finish of this test!')
		travel(cid, 291, 177, 8)
 		end
  		focus = 0
		talk_state = 0


  	elseif msgcontains(msg, 'bye')  and getDistanceToCreature(cid) < 5 then
  		selfSay('Good bye, soldier ' .. creatureGetName(cid) .. '!')
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
