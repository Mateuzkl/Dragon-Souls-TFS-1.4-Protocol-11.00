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
 		selfSay('Melmë ' .. creatureGetName(cid) .. '! Are you sure, want train to be a Precise Archer? So say "test".')
 		focus = cid
 		talk_start = os.clock()

	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 2 then
  		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')

  	elseif focus == cid then
		talk_start = os.clock()

	if msgcontains(msg, 'test') then
		selfSay('Its nice hear that. Are you from Brazil or foreigner?')
		talk_state = 1

-- pais

	elseif talk_state == 1 then
		if msgcontains(msg, 'brazil') or msgcontains(msg, 'brasil') then
		selfSay('Hmm, conheço bastante a sua lingua... Então vamos ao treinamento!')
		selfSay('Archers(Arqueiros) são ageis em "melee" mas não provem de grande força, seu principal ataque e o combate a distancia, mantem sua força fisica e mental equilibradas.')
		selfSay('Então vamos ao teste... Esta Pronto Melmë?')
		talk_state = 2
else
		selfSay('Hmm, i never travel to there, but... Lets start the training!')
		selfSay('Archers are quickly with "melee" but dont provide greath strength, their main fighting style is the distance combat, they have their fisic and mental strenght balanced.')
		selfSay('So, lets go to test... Ready?')
		talk_state = 4
		end

-- yes 1

	elseif talk_state == 2 then
		if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
		selfSay('Seu teste fara voce usar a cabeça e sua agilidade!')
		selfSay('Apenas treine um pouco sua mira, no bau a interminaveis spears para o seu treino, mais cuidado, voce sabera presenciar o perigo!')
		selfSay('Pronto Melmë?')
		talk_state = 3
		end

	elseif talk_state == 4 then
		if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
		selfSay('Use your hand and agility!')
		selfSay('Just train your aim, in the box are endless spears for your training, but becarefull, you will be in danger!')
		selfSay('Ready?')
		talk_state = 5
		end

-- yes 2 (teleport)

	elseif talk_state == 3 then
		if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
		selfSay('Estou lhe esperando do outro lado da sala quando voce estiver pronto.')
		travel(cid, 274, 186, 8)
 		end
  		focus = 0
		talk_state = 0

	elseif talk_state == 5 then
		if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
		selfSay('Good luck soldier, i will be waiting you on the finish of this test!')
		travel(cid, 274, 186, 8)
 		end
  		focus = 0
		talk_state = 0


  	elseif msgcontains(msg, 'bye')  and getDistanceToCreature(cid) < 5 then
  		selfSay('Good bye Melmë, ' .. creatureGetName(cid) .. '!')
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
