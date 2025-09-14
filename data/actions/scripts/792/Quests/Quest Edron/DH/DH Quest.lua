function onUse(cid, item, frompos, item2, topos)

   	if item.uid == 5561 then
   		queststatus = getPlayerStorageValue(cid,5561)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found Demon Helmet.")
   			doPlayerAddItem(cid,2493,1)
   			setPlayerStorageValue(cid,5561,1)
			doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
			doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
			doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end
   	elseif item.uid == 6016 then
   		queststatus = getPlayerStorageValue(cid,6016)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found Demon Shield.")
   			doPlayerAddItem(cid,2520,1)
   			setPlayerStorageValue(cid,6016,1)
			doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
			doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
			doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end
   	elseif item.uid == 5005 then
   		queststatus = getPlayerStorageValue(cid,5005)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found a Steel Boots.")
   			doPlayerAddItem(cid,2645,1)
   			setPlayerStorageValue(cid,5005,1)
			doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
			doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
			doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end
	else
		return 0
   	end

   	return 1
end