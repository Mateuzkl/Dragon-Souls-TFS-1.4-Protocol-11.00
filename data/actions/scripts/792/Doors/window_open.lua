function onUse(cid, item, frompos, item2, topos)
	if getTileHouseInfo(getPlayerPosition(cid)) ~= 0 then
		return doTransformItem(item.uid, item.itemid + 2)
	else
	doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR,"Voce não pode abrir esta janela.")
		return 0	
	end
end