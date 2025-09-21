function onStepIn(creature, item, position, fromPosition)
    if not creature:isPlayer() then
        return true
    end
    
    local player = creature
    
    if item:getActionId() == 154 then
        local teleportPos = Position(318, 376, 9)
        player:teleportTo(teleportPos)
        player:getPosition():sendMagicEffect(CONST_ME_MORTAREA)
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
    end
    
    return true
end
