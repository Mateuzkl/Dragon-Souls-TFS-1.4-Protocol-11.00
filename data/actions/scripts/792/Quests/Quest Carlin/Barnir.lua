function onUse(cid, item, frompos, item2, topos)

wall1 = {x=191, y=371, z=8, stackpos=1}
wall2 = {x=192, y=371, z=8, stackpos=1}

getwall1 = getThingfromPos(wall1)
getwall2 = getThingfromPos(wall2)

if item.uid == 15000 then
queststatus = getPlayerStorageValue(cid,15000)
if queststatus == -1 then
key_uid = doPlayerAddItem(cid,2088,1)
doSetItemActionId(key_uid,133)
doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
doPlayerSendTextMessage(cid,22,"Você encontrou uma chave escondida.")
setPlayerStorageValue(cid,15000,1)
else
doTransformItem(getwall1.uid,1756)
doTransformItem(getwall2.uid,1757)
doRemoveItem(item.uid,1)
doPlayerSendTextMessage(cid,22,"Voce despertou o Barnir.")
doSummonCreature("Barnir", {x=191, y=370, z=8})
end
end
end

