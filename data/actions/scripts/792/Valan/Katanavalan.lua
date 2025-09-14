-- Teleport By GM Xeysk --
function onUse(cid, item, frompos, item2, topos)

voc = getPlayerVocation(cid)
queststatus = getPlayerStorageValue(cid,11111)

if voc == 5 then
if queststatus == -1 then
doTeleportThing(cid,{x=439, y=238, z=15})
wall1 = {x=436, y=241, z=14, stackpos=1}
getwall1 = getThingfromPos(wall1)
doCreateItem(2412,1,wall1)
doPlayerSay(cid, "UnderWorld",16)
doSendMagicEffect(topos,10)
doSendMagicEffect(getPlayerPosition(cid),10)
doRemoveItem(item.uid,1)
setPlayerStorageValue(cid,11111,1)
else
doPlayerSendTextMessage(cid,22,"Only you put use.")
end
elseif voc == 6 then
if queststatus == -1 then
doTeleportThing(cid,{x=439, y=241, z=15})
wall1 = {x=436, y=241, z=14, stackpos=1}
getwall1 = getThingfromPos(wall1)
doCreateItem(2412,1,wall1)
doPlayerSay(cid, "UnderWorld",17)
doSendMagicEffect(topos,10)
doSendMagicEffect(getPlayerPosition(cid),10)
doRemoveItem(item.uid,1)
setPlayerStorageValue(cid,11111,1)
else
doPlayerSendTextMessage(cid,22,"Only you put use.")
end
elseif voc == 7 then
if queststatus == -1 then
doTeleportThing(cid,{x=439, y=238, z=15})
getwall1 = getThingfromPos(wall1)
doCreateItem(2412,1,wall1)
wall1 = {x=436, y=241, z=14, stackpos=1}
doPlayerSay(cid, "UnderWorld",16)
doSendMagicEffect(topos,10)
doSendMagicEffect(getPlayerPosition(cid),10)
doRemoveItem(item.uid,1)
setPlayerStorageValue(cid,11111,1)
else
doPlayerSendTextMessage(cid,22,"Only you put use.")
end
elseif voc == 8 then
if queststatus == -1 then
doTeleportThing(cid,{x=443, y=238, z=15})
wall1 = {x=436, y=241, z=14, stackpos=1}
getwall1 = getThingfromPos(wall1)
doCreateItem(2412,1,wall1)
doPlayerSay(cid, "UnderWorld",16)
doSendMagicEffect(topos,10)
doSendMagicEffect(getPlayerPosition(cid),10)
doRemoveItem(item.uid,1)
setPlayerStorageValue(cid,11111,1)
else
doPlayerSendTextMessage(cid,22,"Only you put use.")
end
else
doPlayerSendTextMessage(cid,22,"Only use in Protection Zone.")
end

return 1

end