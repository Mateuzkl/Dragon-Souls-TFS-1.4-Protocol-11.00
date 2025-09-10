

local focus = 0
local talk_start = 0
local target = 0
local days = 0

function onThingMove(creature, thing, oldpos, oldstackpos)

end


function onCreatureAppear(creature)
end


function onCreatureDisappear(cid, pos)
  	selfSay('/raid zeus')
  	end


function onCreatureTurn(creature)
end


function msgcontains(txt, str)
  	return (string.find(txt, str) and not string.find(txt, '(%w+)' .. str) and not string.find(txt, str .. '(%w+)'))
end

function onCreatureSay(cid, type, msg)
  	msg = string.lower(msg)

  	if (msgcontains(msg, 'hi') and (focus == 0)) and getDistanceToCreature(cid) < 4 then
 		selfSay('Ha! Ola mortal ' .. creatureGetName(cid) .. ', fico impresionado que tenha chegado ate aqui, força já vi que você tem, agora vamos ver cérebro, esta pronto?')
 		focus = cid
 		talk_start = os.clock()

	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Uma criança de cada vez.')

  	elseif focus == cid then
		talk_start = os.clock()

	if msgcontains(msg, 'sim') or msgcontains(msg, 'yes') then
			selfSay('Você tem 2 minutos para me responder, vamos começar com uma bem simples, quero saber o nome de meu criador.')
			talk_state = 2

	elseif talk_state == 2 then
		if msgcontains(msg, 'amel') then
			selfSay('Correto! Então vamos começar a dificultar um pouco. Quantos deuses supremos foram predestinados a dar inicio a este mundo?')
			talk_state = 3
	end

	elseif talk_state == 3 then
		if msgcontains(msg, 'quatro') or msgcontains(msg, '4') then
			selfSay('Correto! Hmm... Muito facil ainda né? Ah tenho outra para você. Criado entre os animais, onde fui o unico ser a conseguir se comunicar com Smarugs, o senhor dos Dragões, fui conhecido desda minha existencia por "O aprendiz das feras", quem sou eu?')
			talk_state = 4
	end

	elseif talk_state == 4 then
		if msgcontains(msg, 'feorn') then
			selfSay('Correto! Impressionante, bom como prometido, pode seguir em frente!')
			selfSay('/send ' .. creatureGetName(cid) .. ', 481 260 15')
			selfSay('/B Parabéns ' .. creatureGetName(cid) .. ', está a caminho da ultima sala do templo dos Deuses, e a um passo da imortalidade. Boa sorte!')
  			focus = 0
  			talk_start = 0
	end

  		elseif msgcontains(msg, 'byyfce') and getDistanceToCreature(cid) < 4 then
  			selfSay('Good bye, ')
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
  			selfSay('Tempo esgotado!')
			selfSay('/raid zeus')
  		end
  			focus = 0
  	end	if focus ~= 0 then
 		if getDistanceToCreature(focus) > 25 then
 			selfSay('Não me deixe falando sozinho!')
 			focus = 0
 		end
 	end
end

