function onStepIn(creature, item, position, fromPosition)
    if not creature:isPlayer() then
        return true
    end
    
    local player = creature
    local status = player:getStorageValue(1236)
    local msg = "Your death has come."
    
    if item:getActionId() == 7351 and status == 0 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, msg)
        local sarupos = Position(496, 258, 13)
        Game.createMonster("Saruman", sarupos)
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
    end
    
    return true
end
