function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if not target or target:getActionId() ~= 4505 then
        return false
    end
    
    if item:getId() ~= 2091 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need a golden key to open this chest.")
        return false
    end
    
    if player:getStorageValue(4505) == 1 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have already taken the war hammer from this chest.")
        return false
    end
    
    local warHammer = player:addItem(2391, 1)
    if warHammer then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found a war hammer!")
        toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
        player:setStorageValue(4505, 1)
        item:remove()
        
        Game.createItem(5070, 1, Position(458, 258, 14))
        
        addEvent(function()
            local item5070 = Tile(Position(458, 258, 14)):getItemById(5070)
            if item5070 then
                item5070:remove()
            end
        end, 1800000)
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You don't have enough capacity.")
    end
    
    return true
end
