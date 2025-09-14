function onUse(cid, item, frompos, item2, topos)

	if item.uid == 6018 then
 	queststatus = getPlayerStorageValue(cid,6018)
 	if queststatus == -1 then
 	doPlayerSendTextMessage(cid,22,"You have found Mana Rune.")
	doPlayerAddItem(cid,2281,100)
	doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
	doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
	doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
 	setPlayerStorageValue(cid,6018,1)
 	else
 	doPlayerSendTextMessage(cid,22,"It is empty.")
 	end
	else
	return 0
	end

	return 1
	end 