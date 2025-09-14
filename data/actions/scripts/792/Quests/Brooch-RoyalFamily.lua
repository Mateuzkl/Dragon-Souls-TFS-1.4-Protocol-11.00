function onUse(cid, item, frompos, item2, topos)

	if item.uid == 2122 then
 	queststatus = getPlayerStorageValue(cid,2122)
 	if queststatus == -1 then
 	doPlayerSendTextMessage(cid,22,"You have found an Brooch of Royal Family.")
	local item1 =  doPlayerAddItem(cid,2122,1)
	doSetItemSpecialDescription(item1, "It is a Brooch of Royal Family.")
	doPlayerSendTextMessage(cid,21,"Quest Adicionada 'The Royal Family.'.")
	doSendMagicEffect(topos,12)
	doSendAnimatedText(getPlayerPosition(cid), "Cleck !", TEXTCOLOR_ORANGE)
	doSendMagicEffect(getPlayerPosition(cid),12)
 	setPlayerStorageValue(cid,2122,1)
 	else
 	doPlayerSendTextMessage(cid,22,"It is empty.")
 	end
	else
	return 0
	end

	return 1
	end 