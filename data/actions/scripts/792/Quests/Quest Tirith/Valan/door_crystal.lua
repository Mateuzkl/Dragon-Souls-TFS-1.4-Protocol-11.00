function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local itemId = item:getId()
    
    if itemId == 2090 then
        if not target then
            return false
        end
        
        if target:getActionId() ~= 4507 then
            return false
        end
        
        if player:getStorageValue(7573) ~= 1 then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "This door is locked.")
            return false
        end
        
        local doorId = target:getId()
        if doorId == 1212 then
            target:transform(1214)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You opened the door with crystal key.")
            toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
            
            addEvent(function()
                local door = Tile(toPosition):getItemById(1214)
                if door then
                    door:transform(1212)
                    toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
                end
            end, 1800000)
            
            return true
        else
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You cannot use the key on this.")
            return false
        end
    end
    
    if target and target:getActionId() == 4507 then
        local doorId = target:getId()
        if doorId == 1214 then
            target:transform(1212)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You closed the door.")
            toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
            return true
        else
            return false
        end
    end
    
    return false
end
