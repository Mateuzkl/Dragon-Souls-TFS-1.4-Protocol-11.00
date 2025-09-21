function onStepOut(creature, item, position, fromPosition)
    if not creature:isPlayer() then
        return true
    end
    
    local actionId = item:getActionId()
    if actionId >= 2000 and actionId < 3000 then
        local door = item
        local doorPosition = item:getPosition()
        
        -- Transforma a porta para fechada
        if door:getType():isDoor() then
            door:transform(door:getId() - 1)
        end
    end
    
    return true
end
