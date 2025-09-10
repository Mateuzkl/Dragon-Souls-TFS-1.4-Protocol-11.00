local focus = 0
local talk_start = 0
local target = 0
local following = false
local attacking = false

function onThingMove(creature, thing, oldpos, oldstackpos)

end


function onCreatureAppear(creature)

end


function onCreatureDisappear(cid, pos)
  	if focus == cid then
          selfSay('Tchau então.')
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

  	if (msgcontains(msg, 'hi') and (focus == 0)) and getDistanceToCreature(cid) < 5 then
		if isPremium(cid) then
			selfSay('Olá ' .. creatureGetName(cid) .. '! Deseja fazer alguma viagem hoje?')
			focus = cid
			talk_start = os.clock()
		else
			selfSay('Desculpe, somente premiuns podem viajar nesse barco.')
			focus = 0
			talk_start = 0
		end
  	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 5 then
  		selfSay('Desculpe, ' .. creatureGetName(cid) .. '! Converso com você em um estante.')

  	elseif focus == cid then
		talk_start = os.clock()

		if msgcontains(msg, 'bramum') then
			if getPlayerLevel(cid) > 99 or getPlayerLevel(cid) < 8 then
				selfSay('Requerimento para essa viagem : Minimo Level 8 e o máximo 99...')
				talk_state = 0
			else
				selfSay('Deseja viajar para Bramum por 500 moedas de ouro?')
				talk_state = 1
			end

		elseif msgcontains(msg, 'canudis') then
			if getPlayerLevel(cid) > 199 or getPlayerLevel(cid) < 100 then
				selfSay('Requerimento para essa viagem : Minimo Level 100 e o máximo 199...')
				talk_state = 0
			else
				selfSay('Deseja viajar para Canudis por 1000 moedas de ouro?')
				talk_state = 2
			end

		elseif msgcontains(msg, 'morgun') then
			if getPlayerLevel(cid) > 299 or getPlayerLevel(cid) < 200 then
				selfSay('Requerimento para essa viagem : Minimo Level 200 e o máximo 299...')
				talk_state = 0
			else
				selfSay('Deseja viajar para Morgun por 2500 moedas de ouro?')
				talk_state = 3
			end

		elseif msgcontains(msg, 'mordor') then
			if getPlayerVocation(cid) < 9 or getPlayerVocation(cid) > 17 then
				selfSay('Desculpe, Somente Valan\'s podem ter acesso à Mordor!')
				talk_state = 0
			else
				selfSay('Você deseja viajar para Mordor por 5000 moedas de ouro?')
				talk_state = 4
			end

		elseif msgcontains(msg, 'tanoris') then
			if getPlayerVocation(cid) < 13 or getPlayerVocation(cid) > 16 then
				selfSay('Desculpe, Somente God\'s Podem viajar ter acesso à Tanoris!')
				talk_state = 0
			else
				selfSay('Você deseja viajar para Tanoris por 100 Dsp\'s?')
				talk_state = 5
			end	
		
		elseif talk_state == 1 then
			if msgcontains(msg, 'yes') then
				if pay(cid,500) then
				travel(cid, 793, 2058, 6)
				selfSay('Que rude!')
				else
					selfSay('Desculpe, você não tem dinheiro suficiente.')
				end
 			end
			talk_state = 0

		elseif talk_state == 2 then
			if msgcontains(msg, 'yes') then
				if pay(cid,1000) then
				travel(cid, 752, 1932, 6)
				selfSay('Que rude!')
				else
					selfSay('Desculpe, você não tem dinheiro suficiente.')
				end
 			end
			talk_state = 0

		elseif talk_state == 3 then
			if msgcontains(msg, 'yes') then
				if pay(cid,2500) then
				travel(cid, 881, 1879, 6)
				selfSay('Que rude!')
				else
					selfSay('Desculpe, você não tem dinheiro suficiente.')
				end
 			end
			talk_state = 0

		elseif talk_state == 4 then
			if msgcontains(msg, 'yes') then
				if pay(cid,5000) then
				travel(cid, 1024, 1858, 6)
				selfSay('Que rude!')
				else
					selfSay('Desculpe, você não tem dinheiro suficiente.')
				end
 			end
			talk_state = 0

		elseif talk_state == 5 then
			if msgcontains(msg, 'yes') then
				if doPlayerRemoveItem(cid,6527,100) == 1 then
				travel(cid, 1103, 1888, 6)
				selfSay('Que rude!')
				else
					selfSay('Desculpe, você não tem Dragon Souls Point suficiente.')
				end
 			end
			talk_state = 0

			elseif msgcontains(msg, 'hi') then
			selfSay('Olá ' .. creatureGetName(cid) .. ' ?')

			elseif msgcontains(msg, 'offer') then
			selfSay('Do Level 8 ao 99 para bramum, level 100 ao 199 para Canudis, level 200 ao 299 para Morgun,level 8 ao 510 para Mordor e somente Valans..e Do Level 8 ao 510 para tanoris somente gods.')	
			
		elseif msgcontains(msg, 'bye') and getDistanceToCreature(cid) < 4 then
			selfSay('Tchau, ' .. creatureGetName(cid) .. '!')
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
  			selfSay('Próximo Porfavor...!')
  		end
  			focus = 0
  	end
 	if focus ~= 0 then
 		if getDistanceToCreature(focus) > 5 then
 			selfSay('Tchau então.')
 			focus = 0
 		end
 	end
end