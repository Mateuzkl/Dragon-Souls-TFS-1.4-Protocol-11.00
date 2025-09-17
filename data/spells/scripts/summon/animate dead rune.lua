local function getTopMoveableThing(pos)
    local tile = getTileItemById(pos, 1) -- Obtenha o primeiro objeto na pilha da posição
    if tile.itemid > 0 and isMoveable(tile.uid) then
        return tile.uid
    end
    return 0
end

local function doTargetCorpse(cid, pos)
    local corpseUid = getTopMoveableThing(pos)
    if corpseUid > 0 and isCorpse(corpseUid) and getCreatureSkullType(cid) ~= SKULL_BLACK then
        doRemoveItem(corpseUid)
        local creature = doCreateMonster(cid, "Skeleton", pos)
        doConvinceCreature(cid, creature)
        doSendMagicEffect(pos, CONST_ME_MAGIC_BLUE)
        return true
    end

    doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
    doPlayerSendDefaultCancel(cid, RETURNVALUE_NOTPOSSIBLE)
    return false
end

function onCastSpell(cid, var)
    if getPlayerStorageValue(cid, 4515650569) == 1 then
        doSendAnimatedText(getCreaturePosition(cid), "Socorro!", 255)
        doSendMagicEffect(getCreaturePosition(cid), 19)
        doPlayerSendDefaultCancel(cid, RETURNVALUE_YOUAREEXHAUSTED)
        return false 
    end
    
    local pos = variantToPosition(var)
    if pos.x ~= 0 and pos.y ~= 0 then
        return doTargetCorpse(cid, pos)
    end
    
    doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
    doPlayerSendDefaultCancel(cid, RETURNVALUE_NOTPOSSIBLE)
    return false
end
