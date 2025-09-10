focus = 0
 talk_start = 0
 target = 0
 following = false
 attacking = false
 talkstate = 0
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
 
 endfunction msgcontains(txt, str)
   	return (string.find(txt, str) and not string.find(txt, '(%w+)' .. str) and not string.find(txt, str .. '(%w+)'))
 end
 
 
 function onCreatureSay(cid, type, msg)
	cook = getPlayerStorageValue(cid,30006)
	pao = getPlayerStorageValue(cid,2689)
   	msg = string.lower(msg)
	dist = getDistanceToCreature(cid)

   	if (msgcontains(msg, 'hi') and (focus == 0)) and dist < 4 and pao == -1 then
  		selfSay('Hello ' .. creatureGetName(cid) .. '! I am the master cooker of the town, wana learn to cook?')
  		focus = cid
  		talk_start = os.clock()
		talk_state = 1


   	elseif (msgcontains(msg, 'oi') and (focus == 0)) and dist < 4 and pao == -1 then
  		selfSay('Ola ' .. creatureGetName(cid) .. '! Sou a cozinheira chefe da cidade , gostaria de aprender a cozinhar?')
  		focus = cid
  		talk_start = os.clock()
		talk_state = 2 

	elseif (msgcontains(msg, 'hi') and (focus == 0)) and dist < 4 and cook == 2 then
  		selfSay('Hello again ' .. creatureGetName(cid) .. '! !')
  		focus = 0
  		talk_start = 0
 
	elseif (msgcontains(msg, 'oi') and (focus == 0)) and dist < 4 and cook == 2 then
  		selfSay('Ola dinovo ' .. creatureGetName(cid) .. '! No momento ando muito ocupada, desculpe mas nossa aula ficara para outro dia, ok?')
  		focus = cid
  		talk_start = 1

-- pao his

	elseif (msgcontains(msg, 'hi') and (focus == 0)) and dist < 4 and pao == 1 then
  		selfSay('Ola ' .. creatureGetName(cid) .. '! Conseguiu oque lhe pedi?')
  		focus = cid
  		talk_start = os.clock()
		talk_state = 3
 
	elseif (msgcontains(msg, 'oi') and (focus == 0)) and dist < 4 and pao == 1 then
  		selfSay('Ola ' .. creatureGetName(cid) .. '! Conseguiu oque lhe pedi?')
  		focus = cid
  		talk_start = os.clock()
		talk_state = 4
 
	elseif (msgcontains(msg, 'hi') and (focus == 0)) and dist < 4 and pao == 2 then
  		selfSay('Ola ' .. creatureGetName(cid) .. '! Conseguiu o flour?')
  		focus = cid
  		talk_start = os.clock()
		talk_state = 5
  
	elseif (msgcontains(msg, 'oi') and (focus == 0)) and dist < 4 and pao == 2 then
  		selfSay('Ola ' .. creatureGetName(cid) .. '! Conseguiu o flour?')
  		focus = cid
  		talk_start = os.clock()
		talk_state = 6
 
	elseif (msgcontains(msg, 'oi') and (focus == 0)) and dist < 4 and pao == 3 then
  		selfSay('Ainda não conseguiu fazer o pão ' .. creatureGetName(cid) .. '?')
  		focus = 0
  		talk_start = 0
 
	elseif (msgcontains(msg, 'done') and (focus == 0)) and dist < 4 and pao == 3 then
  		selfSay('Parabens ' .. creatureGetName(cid) .. '! Voce concluiu a primeira parte de seu treinamento! Volte aqui quando estiver disposto para sua segunda aula!')
  			doSendMagicEffect(getPlayerPosition(cid),12)
		setPlayerStorageValue(cid,30006,2)
		setPlayerStorageValue(cid,2689,4)
  		focus = 0
  		talk_start = 1
 
	elseif msgcontains(msg, 'done') and (focus ~= cid) and dist < 4 and pao == 3 then
  		selfSay('Parabens ' .. creatureGetName(cid) .. '! Voce concluiu a primeira parte de seu treinamento! Volte aqui quando estiver disposto para sua segunda aula!')
  			doSendMagicEffect(getPlayerPosition(cid),12)
		setPlayerStorageValue(cid,30006,2)
		setPlayerStorageValue(cid,2689,4)
  		focus = 0
  		talk_start = 1
 

 
  	elseif msgcontains(msg, 'hi') and (focus ~= cid) and dist < 4 then
  		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')


  	elseif msgcontains(msg, 'oi') and (focus ~= cid) and dist < 4 then
  		selfSay('Desculpe, ' .. creatureGetName(cid) .. '! Falo com voce em um minuto.')


  	elseif focus == cid then
		talk_start = os.clock()

-- pao states

		if msgcontains(msg, 'yes') and talk_state == 1 then
			selfSay('Set the Sails!')
			talk_state = 0

		elseif msgcontains(msg, 'yes') and talk_state == 2 
		or msgcontains(msg, 'sim') and talk_state == 2 then
			doPlayerSendTextMessage(cid,19,"Nova quest adicionada 'Aprendendo a cozinhar!'.")
			selfSay('Bom então vamo la! Nossa primeira aula é simples, vou precisar que voce me traga "wheat", pode ser conseguido, usando uma "scythe" em um "wheat filed", pois então, mãos a obra!')
  			doSendMagicEffect(getPlayerPosition(cid),12)
			setPlayerStorageValue(cid,2689,1)
			setPlayerStorageValue(cid,30006,1)
  			focus = 0
  			talk_start = 0

		elseif msgcontains(msg, 'yes') and talk_state == 3 
		or msgcontains(msg, 'sim') and talk_state == 3 then
			selfSay('Bom então vamo la! Nossa primeira aula é simples, vamos precisa que voce me traga "wheat", pode ser conseguido, usando uma "scythe" em um "wheat filed", pois então, mãos a obra!')
  			focus = 0
  			talk_start = 0

		elseif msgcontains(msg, 'yes') and talk_state == 4
		or msgcontains(msg, 'sim') and talk_state == 4 then
			if getPlayerItemCount(cid,2694) >= 1 then
			selfSay('Mas que otimo! Agora é simples, voce precisa transformar o "wheat" em "flour", usando uma "mill", mãos a obra!')
			setPlayerStorageValue(cid,2689,2)
  			doSendMagicEffect(getPlayerPosition(cid),12)
  			focus = 0
  			talk_start = 0
			else
			selfSay('Mas aonde esta o "wheat"?!')
  			focus = 0
  			talk_start = 0
			end

		elseif msgcontains(msg, 'yes') and talk_state == 5 
		or msgcontains(msg, 'sim') and talk_state == 3 then
			selfSay('Bom então vamo la! Nossa primeira aula é simples, vamos precisa que voce me traga "wheat", pode ser conseguido, usando uma "scythe" em um "wheat filed", pois então, mãos a obra!')
  			focus = 0
  			talk_start = 0

		elseif msgcontains(msg, 'yes') and talk_state == 6
		or msgcontains(msg, 'sim') and talk_state == 6 then
			if getPlayerItemCount(cid,2692) >= 1 then
			selfSay('Excelente! Nosso ultimo passo! Adicione agua ao "flour", para fazer a "dough", depois coloque nesse forno aqui e voila!')
  			doSendMagicEffect(getPlayerPosition(cid),12)
			setPlayerStorageValue(cid,2689,3)
  			focus = 0
  			talk_start = 0
			else
			selfSay('Mas aonde esta o "flour"?!')
  			focus = 0
  			talk_start = 0
			end


		elseif msgcontains(msg, 'no') and (talk_state >= 1 and talk_state <= 34) then
			selfSay('Ok than.')
  			focus = 0
  			talk_start = 0

		elseif msgcontains(msg, 'hi') then
			selfSay('Hmm, im really talking whit you!')

		elseif msgcontains(msg, 'oi') then
			selfSay('Hmm, ja estou falando com voce!')

  		elseif msgcontains(msg, 'bye')  and getDistanceToCreature(cid) < 4 then
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
  			selfSay('Good bye.')
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
