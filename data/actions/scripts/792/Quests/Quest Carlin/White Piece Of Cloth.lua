function onUse(cid, item, frompos, item2, topos)

if item.uid == 3310 then
doPlayerSendTextMessage(cid,22,"You have found a White Piece Of Cloth.")
doPlayerAddItem(cid,5909,math.random(1, 5))
doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
end
end 