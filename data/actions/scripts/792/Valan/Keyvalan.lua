function onUse(cid, item, frompos, item2, topos)

 

if item.uid ==7573 then --unique ID do bau da quest pode ser qualquer um

queststatus = getPlayerStorageValue(cid,7573) --storage value, para saber se fez a quest ou nao

if queststatus == 1 then

doPlayerSendTextMessage(cid,22,"This Chest is empty.") --msg caso ja tenha feito a quest

 

else

doPlayerSendTextMessage(cid,22,"you have found King Key")

doSendMagicEffect(topos,12)

key_uid = doPlayerAddItem(cid,2091,1) --ID da chave que voce recebe (crystal, woode, cooper, etc...)

doSetItemActionId(key_uid,2091) --action ID da key que vc ganha na quest

setPlayerStorageValue(cid,7573,1)

end

return 0

end

return 1

end