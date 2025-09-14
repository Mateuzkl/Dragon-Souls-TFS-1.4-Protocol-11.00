function onUse(cid, item, frompos, item2, topos)

	if item.uid == 2488 then
 	queststatus = getPlayerStorageValue(cid,2488)
 	if queststatus == -1 then
 	doPlayerSendTextMessage(cid,22,"You have found an Crown Legs.")
	doPlayerAddItem(cid,2488,1)
	doSendMagicEffect(topos,12)
	doSendAnimatedText(getPlayerPosition(cid), "Cleck !", TEXTCOLOR_ORANGE)
	doSendMagicEffect(getPlayerPosition(cid),12)
 	setPlayerStorageValue(cid,2488,1)
 	else
 	doPlayerSendTextMessage(cid,22,"It is empty.")
 	end
	else
	return 0
	end

	return 1
	end 