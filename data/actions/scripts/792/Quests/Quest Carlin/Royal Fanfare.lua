function onUse(cid, item, frompos, item2, topos)

if item.uid == 6012 then
	queststatus = getPlayerStorageValue(cid,6012)
	if queststatus == -1 then
		doPlayerSendTextMessage(cid,22,"You have found a Royal Fanfare.")
		doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
		doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
		doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
		doPlayerAddItem(cid,2077,1)
		setPlayerStorageValue(cid,6012,1)
	else
		doPlayerSendTextMessage(cid,22,"It is empty.")
	end
	else
		return 0
   	end

   	return 1
end

