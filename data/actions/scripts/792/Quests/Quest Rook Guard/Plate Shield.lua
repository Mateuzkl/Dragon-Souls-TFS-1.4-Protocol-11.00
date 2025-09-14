function onUse(cid, item, frompos, item2, topos)

if item.uid == 2510 then
queststatus = getPlayerStorageValue(cid,2510)
if queststatus == -1 then
doPlayerSendTextMessage(cid,22,"You have found a Plate Shield.")
doPlayerAddItem(cid,2510,1)
doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
setPlayerStorageValue(cid,2510,1)
else
doPlayerSendTextMessage(cid,22,"It is empty.")
end
else
return 0
end
return 1
end 