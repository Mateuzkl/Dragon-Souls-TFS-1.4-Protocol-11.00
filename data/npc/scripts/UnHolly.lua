-- the id of the creature we are attacking, following, etc.
 
  focus = 0
  talk_start = 0
  target = 0
  following = false
  attacking = false
  bless = 0
  blessa = 0
  blessb = 0
  blessc = 0
  blessd = 0
  blesse = 1
 cost = 160000
 
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
  	msg = string.lower(msg)
 
  	if ((string.find(msg, '(%a*)hi(%a*)')) and (focus == 0)) and getDistanceToCreature(cid) < 4 then
  		selfSay('Hello, ' .. creatureGetName(cid) .. '!')
  		focus = cid
 		selfLook(cid)
  		talk_start = os.clock()
		else
  		if getPlayerVocation(cid) >= 5 then
  		selfSay('I can only talk to regular vocations.')
  	end
	end
  	if ((string.find(msg, '(%a*)oi(%a*)')) and (focus == 0)) and getDistanceToCreature(cid) < 4 then
  		selfSay('Ola, ' .. creatureGetName(cid) .. '!')
  		focus = cid
 		selfLook(cid)
  		talk_start = os.clock()
		else
  		if getPlayerVocation(cid) >= 5 then
  		selfSay('So posso atender vocacoes regulares.')
  	end
	end

	if string.find(msg, '(%a*)hi(%a*)') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Leave us alone, ' .. creatureGetName(cid) .. '!')
  	end
	if string.find(msg, '(%a*)oi(%a*)') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Nos deixe ' .. creatureGetName(cid) .. '!')
  	end
  	if ((string.find(msg, '(%a*)bless(%a*)')) and (focus == cid)) and getDistanceToCreature(cid) < 4 then
  		selfSay('Hmm... So you want be blessed by .... Hmm you know the name... Are you shure about That?')
 		talk_start = 1
 	end
 
  	if ((string.find(msg, '(%a*)yes(%a*)')) and (focus == cid)) and getDistanceToCreature(cid) < 4 and talk_start == 1 and creatureGetBlessStatuse(cid) == 0 then
 		bless = creatureGetBless(cid) + 1
 		blessa = creatureGetBlessStatusa(cid)
 		blessb = creatureGetBlessStatusb(cid)
 		blessc = creatureGetBlessStatusc(cid)
 		blessd = creatureGetBlessStatusd(cid)
 		if pay(cid,cost) then
    		setNewBless(focus, cost,blesse, blessd, blessc, blessb, blessa, bless)
  		selfSay('Skraviosk blessed you...')
 	else
 			selfSay('Sorry, you do not have enough money.')
 		end
 		talk_start = 0
 	end

  	if ((string.find(msg, '(%a*)sim(%a*)')) and (focus == cid)) and getDistanceToCreature(cid) < 4 and talk_start == 1 and creatureGetBlessStatuse(cid) == 0 then
 		bless = creatureGetBless(cid) + 1
 		blessa = creatureGetBlessStatusa(cid)
 		blessb = creatureGetBlessStatusb(cid)
 		blessc = creatureGetBlessStatusc(cid)
 		blessd = creatureGetBlessStatusd(cid)
 		if pay(cid,cost) then
    		setNewBless(focus, cost,blesse, blessd, blessc, blessb, blessa, bless)
  		selfSay('Skraviosk concedeu sua Bless...')
 	else
 			selfSay('Voce nao tem o dinheiro suficiente.')
 		end
 		talk_start = 0
 	end

 
  	if ((string.find(msg, '(%a*)yes(%a*)')) and (focus == cid)) and getDistanceToCreature(cid) < 4 and talk_start == 1 and creatureGetBlessStatuse(cid) >= 1 then
  		selfSay('You already got Your bless...')
 		talk_start = 0
 	end
  	if ((string.find(msg, '(%a*)sim(%a*)')) and (focus == cid)) and getDistanceToCreature(cid) < 4 and talk_start == 1 and creatureGetBlessStatuse(cid) >= 1 then
  		selfSay('Voce ja tem sua bless...')
 		talk_start = 0
 	end
 
  	if ((string.find(msg, '(%a*)no(%a*)')) and (focus == cid)) and getDistanceToCreature(cid) < 4 and talk_start == 1 and creatureGetBlessStatuse(cid) >= 0 then
  		selfSay('Ok. Do you want something more?')
 		talk_start = 0
 	end
  	if ((string.find(msg, '(%a*)nao(%a*)')) and (focus == cid)) and getDistanceToCreature(cid) < 4 and talk_start == 1 and creatureGetBlessStatuse(cid) >= 0 then
  		selfSay('Algo mais?')
 		talk_start = 0
 	end
 
 		if msgcontains(msg, 'aol') then
 			buy(cid,2173,1,10000)
end
  	if ((string.find(msg, '(%a*)status(%a*)')) and (focus == cid)) and getDistanceToCreature(cid) < 4 then
  		selfSay('Hmm... Let me see...')
 		if creatureGetBlessStatusa(cid) == 0 then
 			selfSay('You didnt get the Hersthiop bless yet.')
 		end
 		if creatureGetBlessStatusa(cid) == 1 then
 			selfSay('You already got the Hersthiop bless.')
 		end
 
 		if creatureGetBlessStatusb(cid) == 0 then
 			selfSay('You didnt get the Arquinothep bless yet.')
 		end
 		if creatureGetBlessStatusb(cid) == 1 then
 			selfSay('You already got the Arquinothep bless.')
 		end
 
 		if creatureGetBlessStatusc(cid) == 0 then
 			selfSay('You didnt get the Skraviosk bless yet.')
 		end
 		if creatureGetBlessStatusc(cid) == 1 then
 			selfSay('You already got the Skraviosk bless.')
 		end
 
 		if creatureGetBlessStatusd(cid) == 0 then
 			selfSay('You didnt get the UnHolly bless yet.')
 		end
 		if creatureGetBlessStatusd(cid) == 1 then
 			selfSay('You already got the UnHolly bless.')
 		end
 
 		if creatureGetBlessStatuse(cid) == 0 then
 			selfSay('You didnt get the bless came from God.')
 		end
 		if creatureGetBlessStatuse(cid) == 1 then
 			selfSay('You already got bless came from God.')
 		end
 		talk_start = 0
 	end
 
  	if string.find(msg, '(%a*)bye(%a*)') and focus == cid and getDistanceToCreature(cid) < 4 and creatureGetBlessStatuse(cid) >= 1 then
  		selfSay('God will save your Soul,  ' .. creatureGetName(cid) .. '!')
  		focus = 0
  		talk_start = 0
  		bless = 0
  		blessa = 0
  		blessb = 0
  		blessc = 0
  		blessd = 0
  		blesse = 1
  	end

  	if string.find(msg, '(%a*)tchau(%a*)') and focus == cid and getDistanceToCreature(cid) < 4 and creatureGetBlessStatuse(cid) >= 1 then
  		selfSay('Deus salva sua alma,  ' .. creatureGetName(cid) .. '!')
  		focus = 0
  		talk_start = 0
  		bless = 0
  		blessa = 0
  		blessb = 0
  		blessc = 0
  		blessd = 0
  		blesse = 1
  	end
 
  	if string.find(msg, '(%a*)bye(%a*)') and focus == cid and getDistanceToCreature(cid) < 4 and creatureGetBlessStatuse(cid) == 0 then
  		selfSay('Beware ' .. creatureGetName(cid) .. '...')
  		focus = 0
  		talk_start = 0
  		bless = 0
  		blessa = 0
  		blessb = 0
  		blessc = 0
  		blessd = 0
  		blesse = 1
  	end
  	if string.find(msg, '(%a*)tchau(%a*)') and focus == cid and getDistanceToCreature(cid) < 4 and creatureGetBlessStatuse(cid) == 0 then
  		selfSay('Cuidado em sua jornada ' .. creatureGetName(cid) .. '...')
  		focus = 0
  		talk_start = 0
  		bless = 0
  		blessa = 0
  		blessb = 0
  		blessc = 0
  		blessd = 0
  		blesse = 1
  	end
  end
 
 
  function onCreatureChangeOutfit(creature)
 
  end
 
 
  function onThink()
 	if focus ~= 0 then
 		if getDistanceToCreature(focus) > 5 then
 			selfSay('Good bye then.')
 			focus = 0
 		end
 	end
  end
 
