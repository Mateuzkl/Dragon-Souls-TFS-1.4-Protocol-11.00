function onUse(cid, item, frompos, item2, topos)

if item.uid == 2003 then
doPlayerSendTextMessage(cid,22,"You have found a 100 Dragon Souls Points.")
doPlayerAddItem(cid,6527,100)
doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
doSendAnimatedText(getPlayerPosition(cid), "Cleck!", TEXTCOLOR_ORANGE)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
end
end 