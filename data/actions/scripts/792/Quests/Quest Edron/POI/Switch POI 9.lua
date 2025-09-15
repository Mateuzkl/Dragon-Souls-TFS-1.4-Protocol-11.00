function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local piece1pos = Position(616, 629, 13)
    local piece2pos = Position(618, 629, 13)
    
    local piece1 = Tile(piece1pos):getTopVisibleThing(player)
    local piece2 = Tile(piece2pos):getTopVisibleThing(player)
    
    if item:getActionId() == 113 and item:getId() == 1945 then
        if piece1 then
            piece1:remove(1)
        end
        if piece2 then
            piece2:remove(1)
        end
        
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You hear something open.")
        item:transform(item:getId() + 1)
        
        addEvent(function()
            local currentItem = Tile(item:getPosition()):getItemById(1946)
            if currentItem then
                currentItem:transform(1945)
                currentItem:getPosition():sendMagicEffect(CONST_ME_POFF)
            end
        end, 1800000)
        
    elseif item:getActionId() == 113 and item:getId() == 1946 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You hear something close.")
        item:transform(1945)
        
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Sorry, not possible.")
    end
    
    return true
end
