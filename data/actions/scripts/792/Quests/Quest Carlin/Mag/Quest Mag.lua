function onUse(cid, item, frompos, item2, topos)

if item.uid == 2662 then
	queststatus = getPlayerStorageValue(cid,2662)
	if queststatus == -1 then
		doPlayerSendTextMessage(cid,22,"You have found a Magician Hat.")
		doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
		doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
		doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
		doPlayerAddItem(cid,2323,1)
		setPlayerStorageValue(cid,2662,1)
	else
		doPlayerSendTextMessage(cid,22,"It is empty.")
		doSendMagicEffect(topos,CONST_ME_ENERGYHIT)
	end

elseif item.uid == 2198 then
	queststatus = getPlayerStorageValue(cid,2198)
	if queststatus == -1 then
		doPlayerSendTextMessage(cid,22,"You have found a Mysterious Necklace.")
		doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
		doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
		doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
		doPlayerAddItem(cid,2198,1)
		setPlayerStorageValue(cid,2198,1)
	else
		doPlayerSendTextMessage(cid,22,"It is empty.")
		doSendMagicEffect(topos,CONST_ME_ENERGYHIT)
   		end
	else
		return 0
   	end

   	return 1
end



