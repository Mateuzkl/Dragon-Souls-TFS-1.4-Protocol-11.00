function onStepIn(creature, item, position, fromPosition)
    if not creature:isPlayer() then
        return true
    end
    
    local player = creature
    local storage = 89301
    local delay = 2
    
    if player:getStorageValue(storage) <= os.time() then
        player:setStorageValue(storage, os.time() + delay)
        return true
    else
        player:teleportTo(fromPosition)
        player:sendCancelMessage("Espere um momento para usar esta escada.")
    end
    
    return true
end
