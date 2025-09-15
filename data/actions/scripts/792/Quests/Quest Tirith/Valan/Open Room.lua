function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local gatepos1 = Position(460, 239, 13)
    local gatepos2 = Position(460, 239, 13)
    
    local gate1 = Tile(gatepos1):getItemById(3390)
    
    if item:getAttribute(ITEM_ATTRIBUTE_UNIQUEID) == 60023 and item:getId() == 1945 then
        if gate1 then
            gate1:remove()
        end
        
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You hear something open.")
        item:transform(item:getId() + 1)
        
        addEvent(function()
            local currentItem = Tile(item:getPosition()):getItemById(1946)
            if currentItem and currentItem:getAttribute(ITEM_ATTRIBUTE_UNIQUEID) == 60023 then
                currentItem:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
                Game.createItem(3390, 1, gatepos2)
                currentItem:transform(1945)
            end
        end, 1800000)
        
    elseif item:getAttribute(ITEM_ATTRIBUTE_UNIQUEID) == 60023 and item:getId() == 1946 then
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You hear something close.")
        Game.createItem(3390, 1, gatepos2)
        item:transform(item:getId() - 1)
        
    else
        player:sendCancelMessage("Sorry, not possible.")
    end
    
    return true
end
