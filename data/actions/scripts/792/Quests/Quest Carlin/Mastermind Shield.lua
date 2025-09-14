function onUse(cid, item, frompos, item2, topos)

if item.uid == 6011 then
	queststatus = getPlayerStorageValue(cid,6011)
	if queststatus == -1 then
		doPlayerSendTextMessage(cid,22,"You have found a Mastermind Shield.")
		doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
		doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
		doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
		doPlayerAddItem(cid,2514,1)
		setPlayerStorageValue(cid,6011,1)
	else
		doPlayerSendTextMessage(cid,22,"It is empty.")
	end
	else
		return 0
   	end

   	return 1
end

