function onUse(cid, item, frompos, item2, topos)

	if item.uid == 6017 then
 	queststatus = getPlayerStorageValue(cid,6017)
 	if queststatus == -1 then
 	doPlayerSendTextMessage(cid,22,"You have found Vampire Shield and Dragon Lance.")
	doPlayerAddItem(cid,2414,1)
	doPlayerAddItem(cid,2534,1)
	doSendMagicEffect(topos,12)
	doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
	doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
	doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
 	setPlayerStorageValue(cid,6017,1)
 	else
 	doPlayerSendTextMessage(cid,22,"It is empty.")
 	end
	else
	return 0
	end

	return 1
	end 