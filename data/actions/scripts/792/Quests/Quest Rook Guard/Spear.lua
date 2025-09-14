function onUse(cid, item, frompos, item2, topos)

if item.uid == 2389 then
doPlayerSendTextMessage(cid,22,"You have found a Spear.")
doPlayerAddItem(cid,2389,1)
doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
end
end 