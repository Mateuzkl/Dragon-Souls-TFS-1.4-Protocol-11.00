function onUse(cid, item, frompos, item2, topos)

if item2.itemid == 5944 then
doTransformItem(item.uid,13663)
doDecayItem(item.uid)
doRemoveItem(item2.uid,1)
doCreateItem(13651,1,topos)
end
end