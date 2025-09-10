ox = 218
  oy = 109
  oz = 8
  max = 7
  focus = 0
  talk_start = 0
  target = 0
  following = false
  attacking = false
 
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

   	if ((string.find(msg, '(%a*)hi(%a*)')) and (focus == 0)) and getDistanceToCreature(cid) < 4 then
  		selfSay('Hello ' .. creatureGetName(cid) .. '! ! Welcome to the famous Rulys Furniture Shop. I sell chairs, tables, plants, water pipe, containers, pillows and more.')
  		focus = cid
 		selfLook(cid)
  		talk_start = os.clock()
  	end
 
   	if ((string.find(msg, '(%a*)oi(%a*)')) and (focus == 0)) and getDistanceToCreature(cid) < 4 then
		selfSay('Ola ' .. creatureGetName(cid) .. '! Bemvindo a famosa loja de moveis. Vendemos chairs, tables, plants, water pipe, containers, pillows e mais.')
  		focus = cid
 		selfLook(cid)
  		talk_start = os.clock()
  	end


  	if string.find(msg, '(%a*)hi(%a*)') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')
  	end

  	if string.find(msg, '(%a*)oi(%a*)') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
  		selfSay('Desculpe, ' .. creatureGetName(cid) .. '! Falo com voce em um minuto.')
  	end

 
 		if msgcontains(msg, 'wooden chair') and focus == cid then
  			buy(cid,3901,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'sofa chair') and focus == cid then
  			buy(cid,3902,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'red cushioned chair') and focus == cid then
  			buy(cid,3903,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'green cushioned chair') and focus == cid then
  			buy(cid,3904,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'tusk chair') and focus == cid then
  			buy(cid,3905,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'ivory chair') and focus == cid then
  			buy(cid,3906,1,500)
  			talk_start = os.clock()
  		end
  		if msgcontains(msg, 'chairs') and focus == cid then
  			selfSay('I sell wooden, sofa, red cushioned, green cushioned, tusk and ivory chairs.')
  			talk_start = os.clock()
  		end
  		if msgcontains(msg, 'cadeiras') and focus == cid then
  			selfSay('Vendo wooden, sofa, red cushioned, green cushioned, tusk and ivory chairs.')
  			talk_start = os.clock()
  		end
 
 		if msgcontains(msg, 'big table') and focus == cid then
  			buy(cid,3909,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'square table') and focus == cid then
  			buy(cid,3910,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'round table') and focus == cid then
  			buy(cid,3911,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'small table') and focus == cid then
  			buy(cid,3912,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'stone table') and focus == cid then
  			buy(cid,3913,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'tusk table') and focus == cid then
  			buy(cid,3914,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'bamboo table') and focus == cid then
  			buy(cid,3919,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'tables') and focus == cid then
  			selfSay('I sell big, square, round, small, stone, tusk, bamboo tables.')
  			talk_start = os.clock()
  		end
		if msgcontains(msg, 'mesas') and focus == cid then
  			selfSay('Vendemos big, square, round, small, stone, tusk, bamboo tables.')
  			talk_start = os.clock()
  		end
 
 		if msgcontains(msg, 'pink flower') and focus == cid then
  			buy(cid,3928,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'green flower') and focus == cid then
  			buy(cid,3929,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'christmas tree') and focus == cid then
  			buy(cid,3931,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'plants') and focus == cid then
  			selfSay('I sell pink and green flowers, also christmas trees.')
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'plantas') and focus == cid then
  			selfSay('Tenho pink and green flowers, also christmas trees.')
  			talk_start = os.clock()
  		end
 
 
 		if msgcontains(msg, 'large trunk') and focus == cid then
  			buy(cid,3938,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'drawer') and focus == cid then
  			buy(cid,3921,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'dresser') and focus == cid then
  			buy(cid,3932,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'locker') and focus == cid then
  			buy(cid,3934,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'trough') and focus == cid then
  			buy(cid,3935,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'box') and focus == cid then
  			buy(cid,1738,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'containers') and focus == cid then
  			selfSay('I sell large trunks, boxes, drawers, dressers, lockers and troughs.')
  			talk_start = os.clock()
  		end
 
 		if msgcontains(msg, 'coal basin') and focus == cid then
  			buy(cid,3908,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'birdcage') and focus == cid then
  			buy(cid,3918,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'harp') and focus == cid then
  			buy(cid,3917,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'piano') and focus == cid then
  			buy(cid,3926,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'globe') and focus == cid then
  			buy(cid,3927,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'clock') and focus == cid then
  			buy(cid,3933,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'lamp') and focus == cid then
  			buy(cid,3937,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'more') and focus == cid then
  			selfSay('I sell coal basins, birdcages, harps, pianos, globes, clocks and lamps.')
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'mais') and focus == cid then
  			selfSay('Temos coal basins, birdcages, harps, pianos, globes, clocks and lamps.')
  			talk_start = os.clock()
  		end
 
 		if msgcontains(msg, 'small purple pillow') and focus == cid then
  			buy(cid,1678,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'small green pillow') and focus == cid then
  			buy(cid,1679,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'small red pillow') and focus == cid then
  			buy(cid,1680,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'small blue pillow') and focus == cid then
  			buy(cid,1681,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'small orange pillow') and focus == cid then
  			buy(cid,1682,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'small turquiose pillow') and focus == cid then
  			buy(cid,1683,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'small white pillow') and focus == cid then
  			buy(cid,1684,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'heart pillow') and focus == cid then
  			buy(cid,1685,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'blue pillow') and focus == cid then
  			buy(cid,1686,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'red pillow') and focus == cid then
  			buy(cid,1687,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'green pillow') and focus == cid then
  			buy(cid,1688,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'yellow pillow') and focus == cid then
  			buy(cid,1689,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'round blue pillow') and focus == cid then
  			buy(cid,1690,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'round red pillow') and focus == cid then
  			buy(cid,1691,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'round purple pillow') and focus == cid then
  			buy(cid,1692,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'round turquiose pillow') and focus == cid then
  			buy(cid,1693,1,500)
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'small') and focus == cid then
  			selfSay('I sell small purple, small green, small red, small blue, small orange, small turquiose and small white pillows.')
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'round') and focus == cid then
  			selfSay('I sell round blue, round red, round purple and round turquiose pillows.')
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'square') and focus == cid then
  			selfSay('I sell blue, red, green and yellow pillows.')
  			talk_start = os.clock()
  		end
 		if msgcontains(msg, 'pillows') and focus == cid then
  			selfSay('I sell heart, small, sqare and round pillows.')
  			talk_start = os.clock()
  		end
 
 		if msgcontains(msg, 'water pipe') and focus == cid then
  			buy(cid,2093,1,200)
  			talk_start = os.clock()
  		end
 
  	if string.find(msg, '(%a*)bye(%a*)') and focus == cid and getDistanceToCreature(cid) < 4 then
  		selfSay('Goodbye, ' .. creatureGetName(cid) .. '!')
  		focus = 0
  		talk_start = 0
  	end
  	if string.find(msg, '(%a*)tchau(%a*)') and focus == cid and getDistanceToCreature(cid) < 4 then
  		selfSay('Tchau, ' .. creatureGetName(cid) .. '!')
  		focus = 0
  		talk_start = 0
  	end
  end
 
 
  function onCreatureChangeOutfit(creature)
 
  end
 
 
 function onThink()  
 if (os.clock() - talk_start) > 30 then 
 if focus > 0 then 
 selfSay('Next please!') 
 talkcount = 0
 end 
 focus = 0 
 itemid = 0
 talk_start = 0 
 end 
  	if focus ~= 0 then
  		if getDistanceToCreature(focus) > 5 then
  			selfSay('Adeus.')
  			focus = 0
  		end
	end
end
 