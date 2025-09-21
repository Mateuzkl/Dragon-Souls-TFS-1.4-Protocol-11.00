function onStepIn(creature, item, position, fromPosition)
    if not creature:isPlayer() then
        return true
    end
    
    local player = creature
    local teleport1 = Position(60, 396, 6)
    
    if item:getActionId() == 13540 then
        local vip = player:getStorageValue(13540)
        if vip == -1 then
            player:sendCancelMessage("Va ate a Rainha e pergunte a ela sobre a passagem.")
            player:teleportTo(teleport1)
        end
    end
    
    return true
end
