function onUse(cid, item, frompos, item2, topos)

if item.uid == 2001 then
doPlayerSendTextMessage(cid,22,"You have found a Parcel.")
doPlayerAddItem(cid,2595,1)
doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
doSendAnimatedText(getPlayerPosition(cid), "Cleck!", TEXTCOLOR_ORANGE)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
end
end 