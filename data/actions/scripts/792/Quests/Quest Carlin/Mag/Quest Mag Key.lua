function onUse(cid, item, frompos, item2, topos)

if item.uid == 15004 then
	queststatus = getPlayerStorageValue(cid,15004)
	if queststatus == -1 then
	doPlayerSendTextMessage(cid,22,"Você encontrou uma chave escondida.")
	key_uid = doPlayerAddItem(cid,2086,1)
	doSetItemActionId(key_uid,276)
	doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
	doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
	doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
	setPlayerStorageValue(cid,15004,1)
	else
		doPlayerSendTextMessage(cid,22,"It is empty.")
	end
	else
		return 0
   	end

   	return 1
end

