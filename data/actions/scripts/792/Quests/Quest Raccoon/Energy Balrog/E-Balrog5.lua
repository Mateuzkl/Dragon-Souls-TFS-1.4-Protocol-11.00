function onUse(cid, item, frompos, item2, topos)

if item.uid == 3571 then
queststatus = getPlayerStorageValue(cid,3571)
if queststatus == -1 then
doPlayerSendTextMessage(cid,22,"You have found a Plasma Shield.")
doPlayerAddItem(cid,2542,1)
doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
doSendMagicEffect(getPlayerPosition(cid),12)
setPlayerStorageValue(cid,3571,1)
else
doPlayerSendTextMessage(cid,22,"It is empty.")
end
else
return 0
end
return 1
end 