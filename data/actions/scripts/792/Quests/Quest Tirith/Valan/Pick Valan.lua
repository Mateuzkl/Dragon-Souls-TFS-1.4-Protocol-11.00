function onUse(cid, item, frompos, item2, topos)
if item2.itemid == 6299 then
doTransformItem(item2.uid,383)
doDecayItem(item2.uid)

elseif item2.itemid == 7186 then
doTransformItem(item2.uid,383)
doDecayItem(item2.uid)
end
end