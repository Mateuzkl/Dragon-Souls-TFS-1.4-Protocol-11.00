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
 		selfSay('Was late, i was waiting you ' .. creatureGetName(cid) .. '! Are you sure, want train to be a Feared Sorcerer? So say "test" mortal.')
 		focus = cid
 		talk_start = os.clock()

	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 2 then
  		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')

  	elseif focus == cid then
		talk_start = os.clock()

	if msgcontains(msg, 'test') then
		selfSay('Yea, i know you will say that mortal. Are you from Brazil or foreigner?')
		talk_state = 1

-- pais

	elseif talk_state == 1 then
		if msgcontains(msg, 'brazil') or msgcontains(msg, 'brasil') then
		selfSay('Não tenho tempo a perder mortal... Vamos ao treinamento.')
		selfSay('Sorcerers(Magos) focam suas magias em destruição, como principal aprendizagem a magia negra, sua fonte de poder provem de sua mente, com isso, sua constituição e seu corpo sao fracos.')
		selfSay('Ao teste... Pronto mortal?')
		talk_state = 2
else
		selfSay('I dont have time to waste... Lets train!')
		selfSay('Sorcerers focus their magic in destruction, as main style, the black magic, their font of power is their mind, with that, their agility and body are weak.')
		selfSay('So, lets go to test... Ready?')
		talk_state = 4
		end

-- yes 1

	elseif talk_state == 2 then
		if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
		selfSay('Seu teste e muito simples, ate mesmo para um simples mortal!')
		selfSay('Meu centro de consulta foi tomado por uma maldição mistica, preciso do livro contido em uma das bibliotecas, mas não sera tão facil, pois corpos amaldiçoados estão sedentos por carne fresca!')
		selfSay('Pronto mortal?')
		talk_state = 3
		end

	elseif talk_state == 4 then
		if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
		selfSay('You test is realy simple, even an mortal can do it!')
		selfSay('My reserch center is cursed, i need one book that is in one of the bookcases, but remember, dead cursed bodys are waiting to taste your blood with no mercy!')
		selfSay('Ready mortal?')
		talk_state = 5
		end

-- yes 2 (teleport)

	elseif talk_state == 3 then
		if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
		selfSay('Aguardo o livro em minhas mãos no final do test.')
		travel(cid, 260, 197, 8)
 		end
  		focus = 0
		talk_state = 0

	elseif talk_state == 5 then
		if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
		selfSay('I am waiting for the book in the end of the room!')
		travel(cid, 260, 197, 8)
 		end
  		focus = 0
		talk_state = 0


  	elseif msgcontains(msg, 'bye')  and getDistanceToCreature(cid) < 5 then
  		selfSay('Good bye mortal, ' .. creatureGetName(cid) .. '!')
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
