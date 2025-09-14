function onUse(cid, item, frompos, item2, topos)

if item.uid == 2467 then
queststatus = getPlayerStorageValue(cid,2467)
if queststatus == -1 then
doPlayerSendTextMessage(cid,22,"You have found a Leather Armor and Studded Club.")
doPlayerAddItem(cid,1973,1)
doPlayerAddItem(cid,2448,1)
doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
else
doPlayerSendTextMessage(cid,22,"It is empty.")
end
else
return 0
end
return 1
end 