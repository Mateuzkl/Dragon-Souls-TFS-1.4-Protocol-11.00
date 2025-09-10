local focus = 0
local talk_start = 0
local target = 0
local following = false
local attacking = false
local talk_state = 0
local gstat = 0		-- guild status
local grank = ''		-- guild rank
local gname = ''		-- guild name
local cname = ''		-- name of player who talks to us
local pname = ''		-- name of some other player
local maxnamelen = 30
local maxranklen = 20
local maxnicklen = 20
local leaderlevel = 50
local NONE = 0
local INVITED = 1
local MEMBER = 2
local VICE = 3
local LEADER = 4
local allow_pattern = '^[a-zA-Z0-9 -]+$'

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
  	cname = creatureGetName(cid)


  	if (msgcontains(msg, 'hi') and (focus == 0)) and getDistanceToCreature(cid) < 4 then
  		selfSay('Ola ' .. cname .. '! Sou responsavel pelas inscrições das guildas participantes de eventos e inscrições de representantes das guildas, preço de inscrição por guilda 10k, diga "ajuda" se houver alguma duvida!')
  		talk_state = 0
  		focus = cid
  		talk_start = os.clock()

	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Sorry, ' .. cname .. '! I talk to you in a minute.')

  	elseif msgcontains(msg, 'bye') and (focus == cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Adeus, ' .. cname .. '!')
  		talk_state = 0
  		focus = 0
  		talk_start = 0

  	elseif msgcontains(msg, 'ajuda') and (focus == cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Para inscrever sua guilda diga "inscrever", para invitar um representante diga "representante", para representar uma guilda diga "representar", para excluir algum representante diga "excluir"...')
  		selfSay('Para passar a liderança diga "passar", para escolher um vice-representante diga "vice", para rebaixar algum vice diga "rebaixar" e para parar de representar a guilda diga "sair".')
  		talk_state = 0


  	elseif focus == cid then
  		if talk_state == 0 then
  			msg = string.lower(msg)

	if msgcontains(msg, 'inscrever') then
  		level = getPlayerLevel(cid)
  		if level >= 50 then
		if isPremium(cid) then
  		gstat = getPlayerGuildStatus(cname)
  		if gstat == NONE or gstat == INVITED then
  			selfSay('Qual o nome de sua guilda que deseja inscrever?')
  			talk_state = 1

  		elseif gstat == MEMBER or gstat == VICE or gstat == LEADER then
  			selfSay('Desculpe, mas sua guild ja esta inscrita. Diga "sair" para desinscrever a sua guilda atual.')
  			talk_state = 0
  			end
  			else
  			selfSay('Desculpe, mas somente lideres de guildas podem inscrever a guilda.')
  			end
  			else
  			selfSay('Desculpe, mas somente lideres de guildas podem inscrever a guilda.')
  			end
			talk_start = os.clock()

  	elseif msgcontains(msg, 'representar') then	-- join a guild when invited
  		gstat = getPlayerGuildStatus(cname)
		if gstat == NONE then
  		selfSay('Desculpe, mas não estou sabendo que voce vai representar alguma guilda. Peça para seu lider coloca-lo como representante.')
  		talk_state = 0

  		elseif gstat == INVITED then
  			gname = getPlayerGuildName(cname)
  			selfSay('Voce aceita representar a guilda ' .. gname .. ' nos eventos?')
  			talk_state = 3

  		elseif gstat == MEMBER or gstat == VICE or gstat == LEADER then
  			selfSay('Desculpe, voce já é um representante da Guilda.')
  			talk_state = 0
  			end

  			talk_start = os.clock()

  	elseif msgcontains(msg, 'excluir') or msgcontains(msg, 'chutar') then
  			gstat = getPlayerGuildStatus(cname)

  		if gstat == VICE or gstat == LEADER then
  			selfSay('Qual representante da guilda voce deseja excluir?')
  			talk_state = 4
  			else
  			selfSay('Desculpe, somente o lider ou vice-lider, pode excluir um representante.')
  			talk_state = 0
  			end

  			talk_start = os.clock()

  	elseif msgcontains(msg, 'representante') then
  			gstat = getPlayerGuildStatus(cname)

  		if gstat == VICE or gstat == LEADER then
  			selfSay('Quem voce deseja colocar como representante da guilda?')
  			talk_state = 5
  			else
  			selfSay('Desculpe, somente o lider ou vice-lider, pode invitar um representante.')
  			talk_state = 0
  			end

  			talk_start = os.clock()

  	elseif msgcontains(msg, 'sair') then		-- leave a guild
  			gstat = getPlayerGuildStatus(cname)

  		if gstat == NONE or gstat == INVITED then
  			selfSay('Voce não esta representando nenhuma guilda.')
  			talk_state = 0
  		elseif gstat == MEMBER or gstat == VICE then
  			gname = getPlayerGuildName(cname)
  			selfSay('Voce deseja parar de representar a guilda ' .. gname .. ' nos eventos?')
  			talk_state = 7
  			elseif gstat == LEADER then
  			selfSay('Voce é o lider da guilda, se voce sair, ninguem mais podera representar sua guilda, utilizando o "passar" voce pode passar sua guilda para outra pessoa, tem certeza que deseja sair?')
  			talk_state = 7
  			end

  	elseif msgcontains(msg, 'passar') then		-- pass leadership
			gstat = getPlayerGuildStatus(cname)

  		if gstat == LEADER then
  			selfSay('Quem voce quer que seja o principal representante da guilda?')
  			talk_state = 8
  			else
  			selfSay('Desculpe, mas somente liders podem passar a liderança.')
  			talk_state = 0
  			end

  	elseif msgcontains(msg, 'vice') then		-- set vice leader
			gstat = getPlayerGuildStatus(cname)

		if gstat == LEADER then
			selfSay('Qual representante voce gostaria de passar para vice-representante?')
  			talk_state = 9
  			else
  			selfSay('Sorry, only leader can promote member to vice-leader.')
  			talk_state = 0
  			end

  	elseif msgcontains(msg, 'rebaixar') then		-- remove vice-leader
			gstat = getPlayerGuildStatus(cname)

  		if gstat == LEADER then
  			selfSay('Qual vice-representante voce gostaria de rebaixar a representante?')
  			talk_state = 10
  			else
  			selfSay('Desculpe, apenas liders podem rebaixar um vice-representante.')
  			talk_state = 0
  			end

  	elseif msgcontains(msg, 'Tirarnick') or msgcontains(msg, 'Tirartitle') then

  		if gstat == LEADER then
  			selfSay('Whom player do you want to change nick?')
  			talk_state = 11
  			else
  			selfSay('Sorry, only leader can change nicks.')
  			talk_state = 0
  			end
  			end

  		else	-- talk_state != 0
  			talk_start = os.clock()

  		if talk_state == 1 then		-- get name of new guild
  		gname = msg

  		if string.len(gname) <= maxnamelen then
 		if string.find(gname, allow_pattern) then
		if pay(cid,10000) then
 		if foundNewGuild(gname) >= 1 then
 			selfSay('Parabens, sua guilda foi inscrita com sucesso.')
 			setPlayerGuild(cname,LEADER,cname,gname)
  			talk_state = 0
 			else
			selfSay('Desculpe, mas essa guilda ja esta inscrita, se voce e o dono dela e não foi voce que inscreveu, Contate o GM.')
 			talk_state = 0
			end
  			else
  			selfSay('Desculpe, mas voce não tem o dinheiro da inscrição.')
  			talk_state = 0
  			end
 			else
 			selfSay('Desculpe, mas esta guilda não é sua.')
 			talk_state = 0
 			end
  			else
  			selfSay('Desculpe, mas esta guilda não é sua.')
  			talk_state = 0
  			end

  		elseif talk_state == 2 then		-- get rank of leader
  			grank = msg

  		if string.len(grank) <= maxranklen then
 		if string.find(grank, allow_pattern) then
 			setPlayerGuild(cname,LEADER,grank,gname)
 			selfSay('You are now leader of your new guild.')
 			talk_state = 0
 			else
			selfSay('Sorry, rank name contains illegal characters.')
 			talk_state = 0
 			end
  			else
  			selfSay('Sorry, rank name cannot be longer than ' .. maxranklen .. ' characters.')
  			talk_state = 0
  			end

  		elseif talk_state == 3 then		-- join a guild
  			if msg == 'yes' then
  				setPlayerGuildStatus(cname, MEMBER)
  				selfSay('Parabens, voce é agora um representante da guilda.')
  				talk_state = 0
  				else
  				selfSay('O que posso fazer por voce?')
  				talk_state = 0
  				end

  		elseif talk_state == 4 then		-- kick player
  				pname = msg
  				gname = getPlayerGuildName(cname)
  				gname2 = getPlayerGuildName(pname)

  			if cname == pname then
  				selfSay('Para excluir voce mesmo, diga "sair".')
  				talk_state = 0
  				elseif gname == gname2 then
  				gstat2 = getPlayerGuildStatus(pname)

  			if gstat > gstat2 then
  				clearPlayerGuild(pname)
  				selfSay('Voce excluiu o representante ' .. pname .. ' de sua guilda.')
  				talk_state = 0
  				else
  				selfSay('Apenas liders e vices podem excluir um representante.')
  				talk_state = 0
  				end
  				else
  				selfSay('Desculpe, ' .. pname .. ' não é um representante da guilda.')
  				talk_state = 0
  				end

  		elseif talk_state == 5 then		-- get invited name
  				pname = msg
  				gstat = getPlayerGuildStatus(pname)

  			if gstat == MEMBER or gstat == VICE or gstat == LEADER then
  				selfSay('Desculpe, ' .. pname .. ' é representante de outra guilda.')
  				talk_state = 0
  				else
 				selfSay('Deseja invitar ' .. pname .. ' como representante da guilda?')
 				talk_state = 6
  				end

  		elseif talk_state == 6 then		-- get invited rank
  				grank = msg

  			if string.len(grank) <= maxranklen then
 			if string.find(grank, allow_pattern) then
 				gname = getPlayerGuildName(cname)
 				setPlayerGuild(pname, INVITED, grank, gname)
 				selfSay('Voce invitou ' .. pname .. ' como representante da guilda.')
 				talk_state = 0
 				else
 				selfSay('Sorry, rank name contains illegal characters.')
 				talk_state = 0 					
				end
  				else
				selfSay('Sorry, rank name cannot be longer than ' .. maxranklen .. ' characters.')
  				talk_state = 0
  				end

  		elseif talk_state == 7 then		-- leave a guild
  			if msg == 'yes' then
  				clearPlayerGuild(cname)
  				selfSay('Voce não é mais representante da guilda.')
  				talk_state = 0
  				else
				selfSay('Oque posso fazer por voce?')
  				talk_state = 0
  				end

  		elseif talk_state == 8 then		-- pass leadership
  				pname = msg
  				level = getPlayerLevel(pname)

  			if level >= leaderlevel then
  				gname = getPlayerGuildName(cname)
  				gname2 = getPlayerGuildName(pname)

  			if gname == gname2 then
  				setPlayerGuildStatus(cname,MEMBER)
  				setPlayerGuildStatus(pname,LEADER)
  				gname = getPlayerGuildName(cname)
  				selfSay(pname .. ' é o novo Lider-Representante de ' .. gname .. '.')
  				talk_state = 0
  				else
  				selfSay('Desculpe, ' .. pname .. ' não é um representante.')
  				talk_state = 0;
  				end
  				else
  				selfSay('Desculpe, ' .. pname .. ' não esta online.')
  				talk_state = 0
  				end

  		elseif talk_state == 9 then		-- set vice-leader
  				pname = msg
  				gname = getPlayerGuildName(cname)
  				gname2 = getPlayerGuildName(pname)

  			if cname == pname then
  				selfSay('Para passar o lider representante diga "passar".')
  				talk_state = 0

  			elseif gname == gname2 then
  				gstat = getPlayerGuildStatus(pname)

  			if gstat == INVITED then
				selfSay('Desculpe, ' .. pname .. ' não aceitou ser representante ainda.');
				talk_state = 0
  				elseif gstat == VICE then
  				selfSay(pname .. ' já é um vice-representante.')
				talk_state = 0
  			elseif gstat == MEMBER then
  				setPlayerGuildStatus(pname, VICE)
  				selfSay(pname .. ' é agora um vice-representante da guilda.')
				talk_state = 0
  				end
  				else
  				selfSay('Desculpe, ' .. pname .. ' não é um representante.')
  				talk_state = 0
  				end

  		elseif talk_state == 10 then	-- set member
  				pname = msg
  				gname = getPlayerGuildName(cname)
  				gname2 = getPlayerGuildName(pname)

  			if cname == pname then
  				selfSay('Para passar o lider representante diga "passar".')
  				talk_state = 0
  			elseif gname == gname2 then
  				gstat = getPlayerGuildStatus(pname)

  			if gstat == INVITED then
  				selfSay('Desculpe, ' .. pname .. ' não aceitou ser representante ainda.');
  				talk_state = 0
  			elseif gstat == VICE then
  				setPlayerGuildStatus(pname, MEMBER)
  				selfSay(pname .. ' é agora apenas um representante da guilda.')
  				talk_state = 0
  			elseif gstat == MEMBER then
  				selfSay(pname .. ' já é apenas um representante.')
  				talk_state = 0
  				end
  				else
  				selfSay('Desculpe, ' .. pname .. ' não é um vice-representante.')
  				talk_state = 0
  				end

  		elseif talk_state == 11 then	-- get name of player to change nick
  				pname = msg
				gname = getPlayerGuildName(cname)
  				gname2 = getPlayerGuildName(pname)

  			if gname == gname2 then
  				selfSay('And what nick do you want him to have (say none to clear)?')
  				talk_state = 12
  				else
  				selfSay('Sorry, ' .. pname .. ' is not in your guild.')
  				talk_state = 0
  				end

  		elseif talk_state == 12 then	-- get nick
  			if msg == 'none' then
  				setPlayerGuildNick(pname, '')
  				selfSay(pname .. ' now has no nick.')
  				talk_state = 0
  				else
  			if string.len(msg) <= maxnicklen then
 			if string.find(msg, allow_pattern) then
 				setPlayerGuildNick(pname, msg)
 				selfSay('You have changed ' .. pname .. '\'s nick.')
 				talk_state = 0
 				else
				selfSay('Sorry, nick contains illegal characters.')
 				talk_state = 0
 				end
  				else
  				selfSay('Sorry, nick cannot be longer than ' .. maxnicklen .. ' characters.')
  				talk_state = 0
  				end
  				end
  			end
  		end
  	end
end


function onCreatureChangeOutfit(creature)

end


function onThink()
	doNpcSetCreatureFocus(focus)
  	if (os.clock() - talk_start) > 120 then
  		if focus > 0 then
  			selfSay('Próximo por favor...')
  		end
  			focus = 0
  	end
 	if focus ~= 0 then
 		if getDistanceToCreature(focus) > 5 then
 			selfSay('Adeus então.')
 			focus = 0
 		end
 	end
end