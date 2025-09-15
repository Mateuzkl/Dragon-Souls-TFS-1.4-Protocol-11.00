local ArrayRopeSpot = {384, 418}

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end
    
    local pos = player:getPosition()
    local tile = Tile(pos)
    if not tile then
        return false
    end
    
    local ground = tile:getGround()
    if ground and table.contains(ArrayRopeSpot, ground:getId()) then
        local newpos = Position(pos.x, pos.y + 1, pos.z - 1)
        player:teleportTo(newpos)
        pos:sendMagicEffect(CONST_ME_ENERGYAREA)
        return true
    else
        player:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
        pos:sendMagicEffect(CONST_ME_POFF)
        return false
    end
end
