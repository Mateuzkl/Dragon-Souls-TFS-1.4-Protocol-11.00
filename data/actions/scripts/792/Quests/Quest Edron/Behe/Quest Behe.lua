function onUse(cid, item, frompos, item2, topos)

   	if item.uid == 3123 then
   		queststatus = getPlayerStorageValue(cid,3123)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found Platinum Amulet.")
   			doPlayerAddItem(cid,2171,1)
			doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
			doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
			doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
   			setPlayerStorageValue(cid,3123,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end
   	elseif item.uid == 6013 then
   		queststatus = getPlayerStorageValue(cid,6013)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found Demon Shield.")
   			doPlayerAddItem(cid,2520,1)
			doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
			doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
			doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
   			setPlayerStorageValue(cid,6013,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end
   	elseif item.uid == 6014 then
   		queststatus = getPlayerStorageValue(cid,6014)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found Golden Armor.")
   			doPlayerAddItem(cid,2466,1)
			doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
			doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
			doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
   			setPlayerStorageValue(cid,6014,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end
   	elseif item.uid == 6015 then
   		queststatus = getPlayerStorageValue(cid,6015)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found Guardian Halberd.")
   			doPlayerAddItem(cid,2427,1)
			doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
			doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
			doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
   			setPlayerStorageValue(cid,6015,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end
	else
		return 0
   	end

   	return 1
end