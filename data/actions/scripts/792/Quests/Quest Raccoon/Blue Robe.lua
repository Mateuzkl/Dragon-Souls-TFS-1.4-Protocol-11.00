function onUse(cid, item, frompos, item2, topos)

if item.uid == 2364 then
queststatus = getPlayerStorageValue(cid,2364)
if queststatus == -1 then
doPlayerSendTextMessage(cid,22,"You have found a Blue Robe.")
local item1 =  doPlayerAddItem(cid,2656,1)
doSetItemSpecialDescription(item1, "It is a cursed Robe of Kraven.")
doTeleportThing(cid,{x=146, y=100, z=8})
doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
setPlayerStorageValue(cid,2364,1)
else
doPlayerSendTextMessage(cid,22,"It is empty.")
doTeleportThing(cid,{x=146, y=100, z=8})
end
else
return 0
end
return 1
end