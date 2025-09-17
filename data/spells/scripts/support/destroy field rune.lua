UNREMOVABLE_FIELDS = {1497, 1498, 1499, 1505, 1506, 1507, 1508, 7465, 7466, 7467, 7468, 7469, 7470, 7471, 7472, 7473, 11094, 11095}

local function doRemoveField(cid, pos)
local field = getTileItemByType(pos, ITEM_TYPE_MAGICFIELD)
if(not isInArray(UNREMOVABLE_FIELDS, field.itemid)) then
doRemoveItem(field.uid)
doSendMagicEffect(pos, CONST_ME_POFF)
return true
end

doPlayerSendDefaultCancel(cid, RETURNVALUE_NOTPOSSIBLE)
doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
return false
end

function onCastSpell(cid, var)
if getPlayerStorageValue(cid, 10569) == 1 then
doSendAnimatedText((getCreaturePosition(cid)), "Silence!", 255)
doSendMagicEffect(getCreaturePosition(cid), 110)
doPlayerSendDefaultCancel(cid, RETURNVALUE_YOUAREEXHAUSTED)
return false 
end

local pos = variantToPosition(var)
if(pos.x == CONTAINER_POSITION) then
pos = getThingPos(cid)
end

if(pos.x ~= 0 and pos.y ~= 0) then
return doRemoveField(cid, pos)
end

doPlayerSendDefaultCancel(cid, RETURNVALUE_NOTPOSSIBLE)
doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF
return false
end
end