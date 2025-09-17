local function doRemoveObject(cid, pos)
    pos.stackpos = 255
    local tileItem = getTileItemById(pos, 0)
    local object = tileItem and tileItem.uid > 0 and tileItem or nil
    if object and object.uid > 65535 and not isCreature(object.uid) and isMoveable(object.uid) and object.actionid == 0 and not getTileInfo(pos).protection then
        doRemoveItem(object.uid)
        doSendMagicEffect(pos, CONST_ME_BLOCKHIT)
        return true
    end

    doPlayerSendDefaultCancel(cid, RETURNVALUE_NOTPOSSIBLE)
    doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
    return false
end

function onCastSpell(cid, var)
    if getPlayerStorageValue(cid, 45465465464546) == 1 then
        doSendAnimatedText(getCreaturePosition(cid), "Silence!", 255)
        doSendMagicEffect(getCreaturePosition(cid), 110)
        doPlayerSendDefaultCancel(cid, RETURNVALUE_YOUAREEXHAUSTED)
        return false
    end

    local pos = variantToPosition(var)
    if pos.x == CONTAINER_POSITION then
        pos = getThingPos(cid)
    end

    if pos.x ~= 0 and pos.y ~= 0 then
        return doRemoveObject(cid, pos)
    end

    doPlayerSendDefaultCancel(cid, RETURNVALUE_NOTPOSSIBLE)
    doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
    return false
end
