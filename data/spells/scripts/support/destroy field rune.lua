local UNREMOVABLE_FIELDS = {1497, 1498, 1499, 1505, 1506, 1507, 1508, 7465, 7466, 7467, 7468, 7469, 7470, 7471, 7472, 7473, 11094, 11095}

local function doRemoveField(creature, pos)
    local tile = Tile(pos)
    if not tile then
        return false
    end
    
    local field = tile:getFieldItem()
    if field and not table.contains(UNREMOVABLE_FIELDS, field:getId()) then
        field:remove()
        pos:sendMagicEffect(CONST_ME_POFF)
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
        return doRemoveField(creature, pos)
    end
    
    local player = creature:getPlayer()
    if player then
        player:sendCancelMessage("Not possible.")
        creature:getPosition():sendMagicEffect(CONST_ME_POFF)
    end
    return false
end
