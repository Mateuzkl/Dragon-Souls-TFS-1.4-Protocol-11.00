local focus = 0
local talk_start = 0
local target = 0
local days = 0

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


function msgcontains(txt, str)
  	return (string.find(txt, str) and not string.find(txt, '(%w+)' .. str) and not string.find(txt, str .. '(%w+)'))
end


function onCreatureSay(cid, type, msg)
  	msg = string.lower(msg)
  	if (msgcontains(msg, 'hi') and (focus == 0)) and getDistanceToCreature(cid) < 4 then
 		selfSay('Olá ' .. creatureGetName(cid) .. '! Em que posso lhe ajudar, mortal?')
 		focus = cid
 		talk_start = os.clock()
	elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Desculpe, ' .. creatureGetName(cid) .. '! Falo com você em um minuto.')
  	elseif focus == cid then
		talk_start = os.clock()
		if msgcontains(msg, 'energyze') then
			selfSay('Eu posso energyzar seu elemental necklace por 50k, spirit elemental amulet por 100k ou o seu magic elemental amulet por 150k, você deseja que eu energyze?')
			talk_state = 1
		elseif talk_state == 1 then
			if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then 
			   if getPlayerItemCount(cid, 2125) == 0 and getPlayerItemCount(cid, 2173) == 0 and getPlayerItemCount(cid, 2197) == 0 then
		          selfSay('Você não tem nenhum amulet para ser energyzado.')
		          return TRUE
		       end
		       if getPlayerItemCount(cid, 2197) >= 1 and doPlayerRemoveMoney(cid,50000) == TRUE then
		         doPlayerRemoveItem(cid,2197,1)
		         doPlayerAddItem(cid, 13682, 1)
		         selfSay('Ele é todo seu! Você está protegido.')
		         return TRUE
  		       elseif getPlayerItemCount(cid, 2173) >= 1 and doPlayerRemoveMoney(cid,100000) == TRUE then
		         doPlayerRemoveItem(cid,2173,1)
		         doPlayerAddItem(cid, 13683, 1)
		         selfSay('Ele é todo seu! Você está protegido.')
		         return TRUE
  		       elseif getPlayerItemCount(cid, 2125) >= 1 and doPlayerRemoveMoney(cid,150000) == TRUE then
		         doPlayerRemoveItem(cid,2125,1)
		         doPlayerAddItem(cid, 13684, 1)
		         selfSay('Ele é todo seu! Você está protegido.')
		         return TRUE
               else
                  selfSay('Desculpe, você não tem a quantia necessária.')
               end
           end
           talk_state = 0
		elseif msgcontains(msg, 'elemental necklace') or msgcontains(msg, 'elemental') then
			selfSay('Você deseja trocar o mysterious, dragon breath, scorpion, platinum e o vampire tooth necklace por um Elemental necklace?')
			talk_state = 4
		elseif talk_state == 4 then
			if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
			   if getPlayerItemCount(cid, 2201) == 0 or getPlayerItemCount(cid, 2171) == 0 or getPlayerItemCount(cid, 2170) == 0 or getPlayerItemCount(cid, 2161) == 0 or getPlayerItemCount(cid, 2198) == 0 then
			      selfSay('Desculpe, você não tem todos amulets necessários.')
			      return TRUE
			   end
               if doPlayerRemoveItem(cid, 2201, 1) == TRUE and doPlayerRemoveItem(cid, 2171, 1) == TRUE and doPlayerRemoveItem(cid, 2170, 1) == TRUE and doPlayerRemoveItem(cid, 2161, 1) == TRUE and doPlayerRemoveItem(cid, 2198, 1) == TRUE then
                  doPlayerAddItem(cid, 2197, 1)
                  selfSay('Pronto! O seu elemental necklace está pronto, obrigada.')
                  return TRUE
               else
                  selfSay('Desculpe, você não tem todos amulets necessários.')
                  return TRUE
               end
			end   
			talk_state = 0
		elseif msgcontains(msg, 'spirit elemental amulet') or msgcontains(msg, 'spirit') then
			selfSay('Você deseja trocar o Ialamar, frozzen, sickness, Samantha, Mastafar, priest e o eletric amulet por um Spirit Elemental Amulet?')
			talk_state = 5
		elseif talk_state == 5 then
			if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
			   if getPlayerItemCount(cid, 2199) == 0 or getPlayerItemCount(cid, 2133) == 0 or getPlayerItemCount(cid, 2199) == 0 or getPlayerItemCount(cid, 2135) == 0 or getPlayerItemCount(cid, 2126) == 0 or getPlayerItemCount(cid, 2131) == 0 or getPlayerItemCount(cid, 2130) == 0 or getPlayerItemCount(cid, 2129) == 0 then
                  selfSay('Desculpe, você não tem todos amulets necessários.')
			      return TRUE
			   end
               if doPlayerRemoveItem(cid, 2199, 1) == TRUE and doPlayerRemoveItem(cid, 2133, 1) == TRUE and doPlayerRemoveItem(cid, 2130, 1) == TRUE and doPlayerRemoveItem(cid, 2135, 1) == TRUE and doPlayerRemoveItem(cid, 2126, 1) == TRUE and doPlayerRemoveItem(cid, 2131, 1) == TRUE and doPlayerRemoveItem(cid, 2129, 1) == TRUE then 
                  doPlayerAddItem(cid,2173,1)
			      selfSay('Pronto! O seu spirit elemental necklace está pronto, obrigada.')
			      return TRUE
               else
			      selfSay('Desculpe, você não tem todos amulets necessários.')
               end
			end
			talk_state = 0
		    elseif msgcontains(msg, 'magic elemental amulet') or msgcontains(msg, 'magic') then
			       selfSay('Você deseja trocar o Merlian, relic of the hell, Broonier, Thordain, dark wyzard, angel e o gaya amulet por um Elemental Magic Amulet?')
			       talk_state = 6
            elseif talk_state == 6 then
			       if msgcontains(msg, 'yes') then
			          if getPlayerItemCount(cid, 2139) == 0 or getPlayerItemCount(cid, 2142) == 0 or getPlayerItemCount(cid, 2132) == 0 or getPlayerItemCount(cid, 2136) == 0 or getPlayerItemCount(cid, 2200) == 0 or getPlayerItemCount(cid, 2196) == 0 or getPlayerItemCount(cid, 2138) == 0 then
                         selfSay('Desculpe, você não tem todos amulets necessários.')
			             return TRUE
			          end
                      if doPlayerRemoveItem(cid, 2139, 1) == TRUE and doPlayerRemoveItem(cid, 2142, 1) == TRUE and doPlayerRemoveItem(cid, 2132, 1) == TRUE and doPlayerRemoveItem(cid, 2136, 1) == TRUE and doPlayerRemoveItem(cid, 2200, 1) == TRUE and doPlayerRemoveItem(cid, 2196, 1) == TRUE and doPlayerRemoveItem(cid, 2138, 1) == TRUE then 
                         doPlayerAddItem(cid,2125,1)
			             selfSay('Pronto! O seu magic elemental necklace está pronto, obrigada.')
			             return TRUE
                      else
			             selfSay('Desculpe, você não tem todos amulets necessários.')
                      end
			end
			talk_state = 0
		    elseif msgcontains(msg, 'bless') or msgcontains(msg, 'blessing') then
		           local bless = (getPlayerLevel(cid)*2000)
			       selfSay('Você deseja ser abençoado por ' .. bless .. ' gold coins?')
			       talk_state = 7
		    elseif talk_state == 7 then
			       if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
			          if isPremium(cid) then
			             if doPlayerRemoveMoney(cid, (getPlayerLevel(cid)*2000)) == TRUE then
			                selfSay('/bless ' .. creatureGetName(cid) .. ', 1')
			                selfSay('/bless ' .. creatureGetName(cid) .. ', 2')
			                selfSay('/bless ' .. creatureGetName(cid) .. ', 3')
			                selfSay('/bless ' .. creatureGetName(cid) .. ', 4')
			                selfSay('/bless ' .. creatureGetName(cid) .. ', 5')
			                doPlayerSendTextMessage(cid,22,"Você recebeu a benção de Isolda.")
			                selfSay("Receba essa benção, agora todos os deuses estão olhando por tí.")
			             else
					        selfSay('Desculpe, você não tem a quantia necessária.')
		                 end
			          selfSay('Desculpe, eu só posso abençoar Premiums.') 
				      end
			       end
			       talk_state = 0
		    elseif msgcontains(msg, 'the great dark wyzard') or msgcontains(msg, 'poem ') then
                   selfSay('Você possui o poema de Merlian?')
			       talk_state = 8
		    elseif talk_state == 8 then
                   if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
			          if doPlayerRemoveItem(cid,5952,1) == 1 then
                         buy(cid,2453,getCount(msg),0)
			             doPlayerSendTextMessage(cid,21,"Quest 'The Great Dark Wyzard.' completada.") 
					     selfSay('Eu posso sentir o poder de Merlian, o grande dark wyzard.')
			          else
                         selfSay('Desculpe, você não está com o poema.')
			          end
                   end
			       talk_state = 0
			       
		    elseif msgcontains(msg, 'uihiui') or msgcontains(msg, 'god') then
                   if getPlayerVocation(cid) < 9 then
                      selfSay('Hahaha, você me faz rir caro mortal, apenas valans podem ser tornar Deuses.')
                      return TRUE
                   end
                   if getPlayerLevel(cid) < 500 then
                      if getPlayerVocation(cid) < 13 then
                         selfSay('Hahaha, você não tem level suficiente para isso humilde semi-deus.')
                      else
                         selfSay('Essa é uma escolha de extrema sabedoria, você ainda não está preparado.')
                      end
                      return TRUE
                   end
                   if getPlayerVocation(cid) > 12 then
                      local vlor = (getResets(cid)* 55 + 5)
                      if getResets(cid) == 0 then
                         selfSay('Ual, você realmente conseguiu chegar até aqui! Se auto-resetar é uma decisão de extrema sabedoria, e se mal usada pode-ra trazer altos riscos!...')
                         selfSay('Como é a sua 1° vez, eu não irei lhe cobrar nada, porém você ainda tem a escolha, você realmente deseja ser resetado?')
                      else
                         selfSay('Você anda sempre me surpreendendo, você se tornou um uma pessoa de extrema força e sabedoria, com dons de extrema nobreza!...')
                         selfSay('Porém dessa vez meus serviços serão cobrados, como esse é o seu '..(getResets(cid)+1)..'° reset, o preço é '..vlor..'.000.000 gold coins, deseja proseguir?')
                      end
                      talk_state = 10
                      return TRUE                                                                                                                                              
                   end
                   selfSay('Hmm, fico impressionada que você tenha chegado até aqui! Então realmente você deseja se tornar um Deus? Cuidado mortal, essa decisão é irreversivel.')
			       talk_state = 9
                elseif talk_state == 10 then
                       if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
                          if getPlayerVocation(cid) < 9 then
                             selfSay('Hahaha, você me faz rir caro mortal, apenas valans podem se tornar Deuses.')
                             return TRUE
                          end
                          if getPlayerLevel(cid) < 500 then
                             if getPlayerVocation(cid) < 13 then
                                selfSay('Hahaha, você não tem level suficiente para isso humilde semi-deus.')
                             else
                                selfSay('Essa é uma escolha de extrema sabedoria, você ainda não está preparado.')
                             end
                             return TRUE
                          end
                          if getPlayerVocation(cid) < 13 then
                             selfSay('Você não está preparado para isso humilde semi-deus.')
                             return TRUE
                          end
                          if getResets(cid) == 0 then
                             selfSay('Agora sim, sinta esse extremo poder em suas veias! Seja bem vindo, novo Deus resetado.')
                          else
                             if doPlayerRemoveMoney(cid,(getResets(cid)*55000000+5000000)) == 1 then
                                selfSay('Seu poder agora é ainda maior, parábens '..getCreatureName(cid)..'.')
                             else
                                selfSay('Você não tem '..(getResets(cid)* 55 + 5)..'.000.000 gold coins.')
                                talk_state = 0
                                return TRUE 
                             end
                          end
                          doPlayerAddReset(cid)
                          doPlayerSendTextMessage(cid,22,"Você resetou seu personagem.")
                          selfSay('/save')
                          talk_state = 0
                          return TRUE
                       elseif getPlayerVocation(cid) > 12 then
                          talk_state = 0
                          return TRUE
                       end     
		    elseif talk_state == 9 then
                   if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
                      if getPlayerVocation(cid) < 9 then
                         selfSay('Hahaha, você me faz rir caro mortal, apenas valans podem ser tornar Deuses.')
                         return TRUE
                      end
                      if getPlayerLevel(cid) < 500 then
                         selfSay('Hahaha, você não tem level suficiente para isso humilde semi-deus.')
                         return TRUE
                      end
                      if getPlayerVocation(cid) > 12 then
                         selfSay('Você já é um deus, guerreiro.')
                         return TRUE
                      end
                      if getPlayerVocation(cid) > 8 and getPlayerVocation(cid) < 13 then
                         doPlayerAddGod(cid)
                         doPlayerSendTextMessage(cid,22,"Você evoluiu seu espírito a Deus.")
                         selfSay('Oh, um novo Deus! Boa sorte em sua jornada meu caro.')
                      else 
                         selfSay('Você já é um deus, guerreiro.')
                      end  
                   end
			      
		    
		    elseif msgcontains(msg, 'offer') then
                   selfSay('I can do an element item or energyze your element item, i only need all "necklace", "amulet" or "magic" amulet, also can bless a little mortal and reset a god!')
		    elseif msgcontains(msg, 'necklace') then
                   selfSay('I only need a mysterious, dragon breath, scorpion, platinum and vampire tooth, accept change all for a Elemental necklace?')
		    elseif msgcontains(msg, 'amulet') then
                   selfSay('I only need a Ialamar, frozzen, sickness, Samantha, Mastafar, priest and eletric, accept change all for a Spirit Elemental amulet?')
		    elseif msgcontains(msg, 'magic') then
                   selfSay('I only need a Merlian, relic of the hell, Broonier, Thordain, dark wyzard, angel and gaya, accept change all for a Elemental magic amulet?')
		    elseif msgcontains(msg, 'bye') and getDistanceToCreature(cid) < 4 then
  			       selfSay('Até logo, ' .. creatureGetName(cid) .. '!')
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
  			selfSay('Proxímo porfavor...')
  		end
  			focus = 0
  	end
 	if focus ~= 0 then
 		if getDistanceToCreature(focus) > 5 then
 			selfSay('Então tá, tchau.')
 			focus = 0
 		end
 	end
end