function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local piece1pos = Position(645, 639, 11)
    local rockpos = Position(645, 639, 11)
    local rockpos2 = Position(689, 622, 12)
    
    local piece1 = Tile(piece1pos):getTopVisibleThing(player)
    
    if item:getActionId() == 112 and item:getId() == 1945 and piece1 and piece1:getId() == 1354 then
        piece1:remove(1)
        
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
        
    elseif item:getActionId() == 112 and item:getId() == 1946 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You hear something close.")
        item:transform(1945)
        
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Sorry, not possible.")
    end
    
    return true
end
