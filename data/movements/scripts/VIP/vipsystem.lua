function onStepIn(creature, item, position, fromPosition)
    if not creature:isPlayer() then
        return true
    end
    
    local player = creature
    local timeNow = os.time()
    local quantity = math.floor((player:getStorageValue(13544) - timeNow) / (24 * 60 * 60))
    
    if quantity > 0 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce tem " .. (quantity < 0 and 0 or quantity) .. " dias de VIP no seu character.")
    else
        local dir = player:getDirection()
        local pos = player:getPosition()
        local newPos
        
        if dir == DIRECTION_NORTH then
            newPos = Position(pos.x, pos.y + 1, pos.z)
        elseif dir == DIRECTION_SOUTH then
            newPos = Position(pos.x, pos.y - 1, pos.z)
        elseif dir == DIRECTION_EAST then
            newPos = Position(pos.x - 1, pos.y, pos.z)
        elseif dir == DIRECTION_WEST then
            newPos = Position(pos.x + 1, pos.y, pos.z)
        end
        
        if newPos then
            player:teleportTo(newPos)
        end
        player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Somente jogadores VIPs podem entrar nesta area.")
    end
    
    return true
end
