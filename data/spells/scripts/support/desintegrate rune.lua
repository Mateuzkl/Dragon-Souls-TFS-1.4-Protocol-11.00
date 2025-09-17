local function doRemoveObject(creature, pos)
    local tile = Tile(pos)
    if not tile then
        return false
    end
    
    local topItem = tile:getTopTopItem()
    if topItem and topItem:isMoveable() and topItem:getActionId() == 0 and not tile:hasFlag(TILESTATE_PROTECTIONZONE) then
        topItem:remove()
        pos:sendMagicEffect(CONST_ME_BLOCKHIT)
        return true
    end
    
    local player = creature:getPlayer()
    if player then
        player:sendCancelMessage("Not possible.")
        creature:getPosition():sendMagicEffect(CONST_ME_POFF)
    end
    return false
end

function onCastSpell(creature, variant)
    local pos = variant:getPosition()
    if pos.x == 0 and pos.y == 0 then
        pos = creature:getPosition()
    end
    
    if pos.x ~= 0 and pos.y ~= 0 then
        return doRemoveObject(creature, pos)
    end
    
    local player = creature:getPlayer()
    if player then
        player:sendCancelMessage("Not possible.")
        creature:getPosition():sendMagicEffect(CONST_ME_POFF)
    end
    return false
end
