function onUse(cid, item, frompos, item2, topos)

   	if item.uid == 5008 then
   		queststatus = getPlayerStorageValue(cid,5008)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found Stonecutter Axe.")
			doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
			doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
			doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
   			setPlayerStorageValue(cid,5008,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end
   	elseif item.uid == 5007 then
   		queststatus = getPlayerStorageValue(cid,5007)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found Sword of Valor.")
   			doPlayerAddItem(cid,2400,1)
			doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
			doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
			doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
   			setPlayerStorageValue(cid,5007,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end
   	elseif item.uid == 5006 then
   		queststatus = getPlayerStorageValue(cid,5006)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found Poem Scroll.")
   			doPlayerAddItem(cid,5952,1)
			doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
			doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
			doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
   			setPlayerStorageValue(cid,5006,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end
   	elseif item.uid == 5009 then
   		queststatus = getPlayerStorageValue(cid,5009)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found a Present.")
			container = doPlayerAddItem(cid, 1990, 1)
			doAddContainerItem(container, 2421, 1)
			doAddContainerItem(container, 2160, 30)
			doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
			doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
			doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
   			setPlayerStorageValue(cid,5009,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end
	else
		return 0
   	end

   	return 1
end