focus = 0
talk_start = 0
target = 0
talk_state = 0
following = false
attacking = false

function onThingMove(creature, thing, oldpos, oldstackpos)

end


function onCreatureAppear(creature)

end


function onCreatureDisappear(cid, pos)
  	if focus == cid then
          selfSay('Ate nunca mas!')
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

  	if (msgcontains(msg, 'oi') and (focus == 0)) and getDistanceToCreature(cid) < 4 then
 		selfSay('Ha! Ola mortal ' .. creatureGetName(cid) .. ', fico impresionado que tenha chegado ate aqui, força já vi que você tem, agora vamos ver cérebro, esta pronto?')
 		selfLook(cid)
		focus = cid
 		talk_start = os.clock()
		talk_state = 1

	elseif msgcontains(msg, 'oi') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Uma criança de cada vez.')  	elseif focus == cid then
		talk_start = os.clock()

	if talk_state == 1 then
	if msgcontains(msg, 'sim') then
			selfSay('Você tem 2 minutos para me responder, quantos casais de espécies diferentes Maomé colocou em sua arca?')
			talk_state = 2


end
		elseif talk_state == 2 then
			if msgcontains(msg, 'maomé não tinha arca') or msgcontains(msg, 'maome nao tinha arca') then
					selfSay('Certo! Haha, tenho mais uma para você! Por que a água foi presa?')
					talk_state = 3
		else
					randsay = math.random(1,15)
					if randsay == 1 then
					selfSay('Falta-lhe um cérebro, de a vez a outro mortal.')
					selfSay('/send ' .. creatureGetName(cid) .. ', 484 256 15')
				talk_state = 0 
					end
					if randsay >= 2 then
					selfSay('Resposta errada! Adicionei um presentinho para você em seu caminho.')
					selfSay('/raid zeus')
				talk_state = 2
				end
 			end

		elseif talk_state == 3 then
			if msgcontains(msg, 'matou a sede') then
					selfSay('Hahaha adoro essa! Esta de parabéns, você merece ir para a próxima sala!')
					selfSay('/send ' .. creatureGetName(cid) .. ', 482 261 15')
					selfSay('/B Parabéns ' .. creatureGetName(cid) .. ', está a caminho da ultima sala do templo dos Deuses, e a um passo da imortalidade. Boa sorte!')
				talk_state = 0
		else
					randsay = math.random(1,15)
					if randsay == 1 then
					selfSay('Falta-lhe um cérebro, de a vez a outro mortal.')
					selfSay('/send ' .. creatureGetName(cid) .. ', 484 256 15')
				talk_state = 0 
					end
					if randsay >= 2 then
					selfSay('Resposta errada! Adicionei um presentinho para você em seu caminho.')
					selfSay('/raid zeus')
				talk_state = 3
				end
 			end

  		elseif msgcontains(msg, 'basdfasdfye')  and getDistanceToCreature(cid) < 4 then
  			selfSay('Good bye, ')
  			focus = 0
  			talk_start = 0
  		end
  	end
end

function onCreatureChangeOutfit(creature)

end


function onThink()
  	if (os.clock() - talk_start) > 99999999 then
  		if focus > 0 then
  			selfSay('Tempo esgotado!')
  		end
  			focus = 0
  	end
	if focus ~= 0 then
 		if getDistanceToCreature(focus) > 15 then
 			selfSay('Não me deixe falando sozinho!')
 			focus = 0
 		end
 	end
end

