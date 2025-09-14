function onUse(cid, item, frompos, item2, topos)

 

if item.uid ==15003 then --unique ID do bau da quest pode ser qualquer um

queststatus = getPlayerStorageValue(cid,15003) --storage value, para saber se fez a quest ou nao

if queststatus == 1 then

doPlayerSendTextMessage(cid,22,"This Chest is empty.") --msg caso ja tenha feito a quest

 

else

doPlayerSendTextMessage(cid,22,"Você encontrou uma chave atras da cortina.")

doSendMagicEffect(topos,12)

key_uid = doPlayerAddItem(cid,2088,1) --ID da chave que voce recebe (crystal, woode, cooper, etc...)

doSetItemActionId(key_uid,277) --action ID da key que vc ganha na quest
doPlayerAddItem(cid,2637,1)
	doSendAnimatedText(getPlayerPosition(cid), "Cleck !", TEXTCOLOR_ORANGE)
 	doPlayerSendTextMessage(cid,22,"Peça a ela para te levar para ( Carlin ).")
setPlayerStorageValue(cid,15003,1)

end

return 0

end

return 1

end