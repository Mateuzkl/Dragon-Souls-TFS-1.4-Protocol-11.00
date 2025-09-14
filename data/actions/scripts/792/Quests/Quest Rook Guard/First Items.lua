local firstItems =
{
	2050,
	2382
}

function onUse(cid, item, frompos, item2, topos)
	if isPlayer(cid) == TRUE then
		if getPlayerStorageValue(cid, 1001) == -1 then
			for i = 1, table.maxn(firstItems) do
				doPlayerAddItem(cid, firstItems[i], 1)
			end
			if getPlayerSex(cid) == 0 then
				doPlayerAddItem(cid, 2651, 1)
			else
				doPlayerAddItem(cid, 2650, 1)
			end
			local bag = doPlayerAddItem(cid, 1987, 1)
			doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
                        doPlayerSendTextMessage(cid,20,"Quest completada 'First Itens'.")
			doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
			doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
			doAddContainerItem(bag, 2674, 1)
			setPlayerStorageValue(cid, 1001, 1)
		end
	end
 	return TRUE
end