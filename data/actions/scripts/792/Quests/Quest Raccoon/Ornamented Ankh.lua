function onUse(cid, item, frompos, item2, topos)

if item.uid == 6024 then
queststatus = getPlayerStorageValue(cid,6024)
if queststatus == -1 then
doPlayerSendTextMessage(cid,25,"You have found 5 Crystal coin.")
doPlayerAddItem(cid,2160,5)
doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
setPlayerStorageValue(cid,6024,1)
else
doPlayerSendTextMessage(cid,24,"Está vazio, você já completou essa quest.")
end
else
return 0
end
return 1
end 