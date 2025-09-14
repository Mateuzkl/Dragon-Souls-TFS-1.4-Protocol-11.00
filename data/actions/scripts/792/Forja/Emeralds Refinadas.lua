function onUse(cid, item, frompos, item2, topos)

if item2.itemid == 13662 then
doTransformItem(item2.uid,13627)
doDecayItem(item2.uid)
doRemoveItem(item.uid,10)
end
end