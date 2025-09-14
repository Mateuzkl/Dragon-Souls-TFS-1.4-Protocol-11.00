function onUse(cid, item, frompos, item2, topos)
if item2.itemid == 4995 then
doSendAnimatedText(topos, "Teck!", TEXTCOLOR_LIGHTBLUE)
doSendMagicEffect(topos,CONST_ME_BLOCKHIT)
doTransformItem(item2.uid,2016)
doDecayItem(item2.uid)
doRemoveItem(item.uid,1)
end
end