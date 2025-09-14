function onUse(cid, item, frompos, item2, topos)

if item2.itemid == 13628 then
doTransformItem(item2.uid,13629)
doDecayItem(item2.uid)
doRemoveItem(item.uid,10)
end
end