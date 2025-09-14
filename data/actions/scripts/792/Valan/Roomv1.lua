function onUse(cid, item, frompos, item2, topos)
gatepos = {x=460, y=239, z=13, stackpos=1}
getgate = getThingfromPos(gatepos)

if item.uid == 60023 and item.itemid == 1945 and getgate.itemid == 3390 then
doRemoveItem(getgate.uid,1)
doSendAnimatedText(getPlayerPosition(cid), "Open", TEXTCOLOR_GREEN)
doSendMagicEffect(topos,10)
doSendMagicEffect(getPlayerPosition(cid),10)
doTransformItem(item.uid,item.itemid+1)
elseif item.uid == 60023 and item.itemid == 1946 and getgate.itemid == 0 then
doCreateItem(3390,1,gatepos)
doTransformItem(item.uid,item.itemid-1)
else
doPlayerSendCancel(cid,"Sorry not possible.")
end
  return 1
  end