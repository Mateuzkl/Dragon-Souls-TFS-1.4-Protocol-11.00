local firstItems = {
    2050,
    2382
}

function onStepIn(creature, item, position, fromPosition)
    if not creature:isPlayer() then
        return true
    end
    
    local player = creature
    
    if player:getStorageValue(30001) == -1 then
        for i = 1, #firstItems do
            player:addItem(firstItems[i], 1)
        end
        
        if player:getSex() == PLAYERSEX_FEMALE then
            player:addItem(2651, 1)
        else
            player:addItem(2650, 1)
        end
        
        local bag = player:addItem(1987, 1)
        if bag then
            bag:addItem(2674, 1)
        end
        
        player:setStorageValue(30001, 1)
    end
    
    return true
end
