function onUse(cid, item, frompos, item2, topos)

if item2.itemid == 13627 then
doTransformItem(item2.uid,13628)
doDecayItem(item2.uid)
doRemoveItem(item.uid,1)
end
end