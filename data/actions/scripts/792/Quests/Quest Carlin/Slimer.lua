function onUse(cid, item, frompos, item2, topos)

if item.uid == 6005 then
	queststatus = getPlayerStorageValue(cid,6005)
	if queststatus == -1 then
		doPlayerSendTextMessage(cid,22,"You have found a spikesword.")
		doPlayerAddItem(cid,2383,1)
		doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
		doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
		doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
		setPlayerStorageValue(cid,6005,1)
	else
		doPlayerSendTextMessage(cid,22,"It is empty.")
	end

elseif item.uid == 6004 then
	queststatus = getPlayerStorageValue(cid,6005)
	if queststatus == -1 then
		doPlayerSendTextMessage(cid,22,"You have found a barbarian axe.")
		doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
		doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
		doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
		doPlayerAddItem(cid,2429,1)
		setPlayerStorageValue(cid,6005,1)
	else
		doPlayerSendTextMessage(cid,22,"It is empty.")
	end
	else
		return 0
   	end

   	return 1
end

