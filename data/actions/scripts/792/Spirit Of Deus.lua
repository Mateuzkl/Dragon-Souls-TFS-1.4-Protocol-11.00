function onUse(cid, item, frompos, item2, topos)

voc = getPlayerVocation(cid)
queststatus = getPlayerStorageValue(cid,5952)

if voc == 5 then
if queststatus == -1 then
doPlayerSendTextMessage(cid,22,"You receive The Spirit of God.")
local item1 = doPlayerAddItem(cid,5952,1)
doSetItemSpecialDescription(item1, "This iten recorded the name vocation of Dark Wyzard\'s. " .. getPlayerName(cid) .. " Gratz for Deus Quest.")
doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_LIGHTGREEN)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
doShowTextDialog(cid,2180,"Crie novo character é use esse spirit of valan no seu novo char level 8 ele ira ser seu novo Deus.")
setPlayerStorageValue(cid,5952,1)
else
doPlayerSendTextMessage(cid,22,"It is empty.")
end
elseif voc == 6 then
if queststatus == -1 then
doPlayerSendTextMessage(cid,22,"You receive The Spirit of God.")
local item1 = doPlayerAddItem(cid,5952,1)
doSetItemSpecialDescription(item1, "This iten recorded the name vocation of Elemental Cleric\'s. " .. getPlayerName(cid) .. " Gratz for Deus Quest.")
doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_LIGHTGREEN)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
doShowTextDialog(cid,2180,"Crie novo character é use esse spirit of valan no seu novo char level 8 ele ira ser seu novo Deus.")
setPlayerStorageValue(cid,5952,1)
else
doPlayerSendTextMessage(cid,22,"It is empty.")
end
elseif voc == 7 then
if queststatus == -1 then
doPlayerSendTextMessage(cid,22,"You receive The Spirit of God.")
local item1 = doPlayerAddItem(cid,5952,1)
doSetItemSpecialDescription(item1, "This iten recorded the name vocation of Elven Ranger\'s. " .. getPlayerName(cid) .. " Gratz for Deus Quest.")
doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_LIGHTGREEN)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
doShowTextDialog(cid,2180,"Crie novo character é use esse spirit of valan no seu novo char level 8 ele ira ser seu novo valan.")
setPlayerStorageValue(cid,5952,1)
else
doPlayerSendTextMessage(cid,22,"It is empty.")
end
elseif voc == 8 then
if queststatus == -1 then
doPlayerSendTextMessage(cid,22,"You receive The Spirit of God.")
local item1 = doPlayerAddItem(cid,5952,1)
doSetItemSpecialDescription(item1, "This iten recorded the name vocation of Dragon Slayer\'s. " .. getPlayerName(cid) .. " Gratz for Deus Quest.")
doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_LIGHTGREEN)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
doShowTextDialog(cid,2180,"Crie novo character é use esse spirit of valan no seu novo char level 8 ele ira ser seu novo Deus.")
setPlayerStorageValue(cid,5952,1)
else
doPlayerSendTextMessage(cid,22,"It is empty.")
end
else
doPlayerSendTextMessage(cid,22,"Desculpe, você não tem vocação necessaria.")
return 0
end
return 1
end
