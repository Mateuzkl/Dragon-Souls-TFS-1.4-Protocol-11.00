function onUse(cid, item, frompos, item2, topos)

if item.uid == 6025 then
queststatus = getPlayerStorageValue(cid,6025)
if queststatus == -1 then
doPlayerSendTextMessage(cid,22,"You have found a Holy Falcon and Strange Symbol and 10 Small Amethysts.")
doPlayerAddItem(cid,2141,1)
doPlayerAddItem(cid,2319,1)
doPlayerAddItem(cid,2150,10)
doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
setPlayerStorageValue(cid,6025,1)
else
doPlayerSendTextMessage(cid,22,"It is empty.")
end
else
return 0
end
return 1
end