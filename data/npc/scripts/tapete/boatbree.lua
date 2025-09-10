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


  	if (msgcontains(msg, 'hi') and (focus == 0)) and getDistanceToCreature(cid) < 4 then
		if isPremium(cid) then
			selfSay('Olá ' .. creatureGetName(cid) .. '. Bem vindo ao meu belo barco!')
			focus = cid
			talk_start = os.clock()
		else
			selfSay('Desculpe, Só premiuns podem viajar no meu barco.')
			focus = 0
			talk_start = 0
		end

  	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Desculpe, ' .. creatureGetName(cid) .. '! Converso com você em um estante.')

  	elseif focus == cid then
		talk_start = os.clock()

		if msgcontains(msg, 'edron') then
			selfSay('Você deseja viajar para Edron por 400 moedas de ouro?')
			talk_state = 1

		elseif talk_state == 1 then
			if msgcontains(msg, 'yes') then
				if pay(cid,400) then
					travel(cid, 736, 795, 6)
					selfSay('Que rude!')
				else
				selfSay('Desculpe, você não tem dinheiro suficiente.')
				end
 			end
                   talk_state = 2




		elseif msgcontains(msg, 'carlin') then
			selfSay('Desesja viajar para Carlin por 200 Moedas de ouro?')
			talk_state = 2

		elseif talk_state == 2 then
			if msgcontains(msg, 'yes') then
				if pay(cid,200) then
					travel(cid, 151, 357, 6)
					selfSay('Que rude!')
				else
				selfSay('Desculpe, mas você não tem dinheiro suficiente.')
				end
 			end
			talk_state = 3

		

		elseif msgcontains(msg, 'minas tirith') or msgcontains(msg, 'tirith') then
			selfSay('Você deseja viajar para minas de tirith por 400 moedas de ouro?')
			talk_state = 3

		elseif talk_state == 3 then
			if msgcontains(msg, 'yes') then
				if pay(cid,400) then
					travel(cid, 476, 294, 6)
					selfSay('Que rude!')
				else
				selfSay('Desculpe, você não tem dinheiro suficiente.')
				end
 			end
			talk_state = 4

		elseif msgcontains(msg, 'raccoon') or msgcontains(msg, 'raccoon city') then
			selfSay('Você deseja viajar para Raccoon por 300 moedas de ouro?')
			talk_state = 4

		elseif talk_state == 4 then
			if msgcontains(msg, 'yes') then
				if pay(cid,300) then
					travel(cid, 210, 74, 6)
					selfSay('Que rude!')
				else
				selfSay('Desculpe, você não tem dinheiro suficiente.')
				end
 			end
			talk_state = 5

		elseif msgcontains(msg, 'castle of carlin') then
			selfSay('Você deseja viajar para o Castelo de Carlin for 100 moedas de ouro?')
			talk_state = 5

		elseif talk_state == 5 then
			if msgcontains(msg, 'yes') then
				if pay(cid,100) then
					travel(cid, 543, 529, 6)
					selfSay('Que rude!')
				else
				selfSay('Desculpe, você não tem dinheiro suficiente.')
				end
 			end
			talk_state = 6

		elseif msgcontains(msg, 'draynor') or msgcontains(msg, 'draynor island') then
			selfSay('Bom... Eu prometi a mim mesmo que nunca levarei ninguém à este local outra vez, mas se você me pagar..hmm.. 800 moedas de ouro fazemos um acordo! Quer ir?')
			talk_state = 6

		elseif talk_state == 6 then
			if msgcontains(msg, 'yes') then
				if pay(cid,100) then
					travel(cid, 250, 441, 6)
					selfSay('How rude!')
				else
				selfSay('Sorry, you don\'t have enough money.')
				end
 			end
			talk_state = 0

		elseif msgcontains(msg, 'offer') then
			selfSay('EU posso te levar para Edron,Minas Tirith, Bree, Para o Castelo de Carlin, Tudo isso por um pequeno preço... E eu Descobri o caminho para Ilha de Draynor')

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
  			selfSay('Próximo porfavor...')
  		end
  			focus = 0
  	end
	if focus ~= 0 then
 		if getDistanceToCreature(focus) > 5 then
 			selfSay('Então tchau.')
 			focus = 0
 		end
 	end
end



