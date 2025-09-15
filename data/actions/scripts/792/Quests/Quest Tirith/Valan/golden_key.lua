function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if item:getActionId() == 4506 then
        local queststatus = player:getStorageValue(4506)
        if queststatus == -1 then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found King Key")
            local key = player:addItem(2091, 1)
            if key then
                key:setActionId(2091)
            end
            toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
            player:setStorageValue(4506, 1)
        else
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "It is empty.")
        end
    else
        return false
    end
    
    return true
end
