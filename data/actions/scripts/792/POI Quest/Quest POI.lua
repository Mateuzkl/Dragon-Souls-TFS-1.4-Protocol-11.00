function onUse(cid, item, frompos, item2, topos)

   	if item.uid == 5903 then
   		queststatus = getPlayerStorageValue(cid,5903)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found Ferumbras Hat.")
   			doPlayerAddItem(cid,5903,1)
   			setPlayerStorageValue(cid,5903,1)
   		else
   			doPlayerSendTextMessage(cid,22,"Sorry, not possible.")
   		end
   	elseif item.uid == 5803 then
   		queststatus = getPlayerStorageValue(cid,5903)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found Arbalest.")
   			doPlayerAddItem(cid,5803,1)
   			setPlayerStorageValue(cid,5903,1)
   		else
   			doPlayerSendTextMessage(cid,22,"Sorry, not possible.")
   		end
   	elseif item.uid == 6528 then
   		queststatus = getPlayerStorageValue(cid,5903)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found a The Avenger.")
   			doPlayerAddItem(cid,6528,1)
   			setPlayerStorageValue(cid,5903,1)
   		else
   			doPlayerSendTextMessage(cid,22,"Sorry, not possible.")
   		end
	else
		return 0
   	end

   	return 1
end