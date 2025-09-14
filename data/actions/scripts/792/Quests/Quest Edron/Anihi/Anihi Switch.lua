function onUse(cid, item, frompos, item2, topos)
   	-- annihilator
   	if item.uid == 7000 then
   		if item.itemid == 1945 then
 
   			player1pos = {x=776, y=731, z=13, stackpos=253}
   			player1 = getThingfromPos(player1pos)
 
   			player2pos = {x=775, y=731, z=13, stackpos=253}
   			player2 = getThingfromPos(player2pos)
 
   			player3pos = {x=774, y=731, z=13, stackpos=253}
   			player3 = getThingfromPos(player3pos)
 
   			player4pos = {x=773, y=731, z=13, stackpos=253}
   			player4 = getThingfromPos(player4pos)
 
 
   			if player1.itemid > 0 and player2.itemid > 0 and player3.itemid > 0 and player4.itemid > 0 then
 
   				player1level = getPlayerLevel(player1.uid)
   				player2level = getPlayerLevel(player2.uid)
   				player3level = getPlayerLevel(player3.uid)
   				player4level = getPlayerLevel(player4.uid)
 
   				questlevel = 100
 
   				if player1level >= questlevel and player2level >= questlevel and player3level >= questlevel and player4level >= questlevel then
 
   					queststatus1 = getPlayerStorageValue(player1.uid,7000)
   					queststatus2 = getPlayerStorageValue(player2.uid,7000)
   					queststatus3 = getPlayerStorageValue(player3.uid,7000)
   					queststatus4 = getPlayerStorageValue(player4.uid,7000)
 
   					if queststatus1 == -1 and queststatus2 == -1 and queststatus3 == -1 and queststatus4 == -1 then
 
   						nplayer1pos = {x=777, y=717, z=13}
   						nplayer2pos = {x=776, y=717, z=13}
   						nplayer3pos = {x=775, y=717, z=13}
   						nplayer4pos = {x=774, y=717, z=13}
 
   						doSendMagicEffect(player1pos,2)
   						doSendMagicEffect(player2pos,2)
   						doSendMagicEffect(player3pos,2)
   						doSendMagicEffect(player4pos,2)
 
   						doTeleportThing(player1.uid,nplayer1pos)
   						doTeleportThing(player2.uid,nplayer2pos)
   						doTeleportThing(player3.uid,nplayer3pos)
   						doTeleportThing(player4.uid,nplayer4pos)
 
   						doSendMagicEffect(nplayer1pos,10)
   						doSendMagicEffect(nplayer2pos,10)
   						doSendMagicEffect(nplayer3pos,10)
   						doSendMagicEffect(nplayer4pos,10)
 
   						doTransformItem(item.uid,item.itemid+1)
 
   					else
   						doPlayerSendCancel(cid,"Somebody in your team has already done this quest.")
   					end
   				else
   					doPlayerSendCancel(cid,"All players must have level 100 to enter.")
   				end
   			else
   				doPlayerSendCancel(cid,"You need 4 players in your team, must have level 100.")
   			end
   		elseif item.itemid == 1946 then
   			if getPlayerAccess(cid) > 0 then
   				doTransformItem(item.uid,item.itemid1)
   			else
   				doPlayerSendCancel(cid,"Sorry, not possible.")
   			end
   		end
 
   	end
   return 1
   end