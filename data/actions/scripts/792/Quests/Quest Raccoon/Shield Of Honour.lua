function onUse(cid, item, frompos, item2, topos)

if item.uid == 5022 then
queststatus = getPlayerStorageValue(cid,5022)
if queststatus == -1 then
doPlayerSendTextMessage(cid,22,"You have found a Shield Of Honour.")
doPlayerAddItem(cid,2517,1)
doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
setPlayerStorageValue(cid,5022,1)
else
doPlayerSendTextMessage(cid,22,"It is empty.")
end
else
return 0
end
return 1
end 