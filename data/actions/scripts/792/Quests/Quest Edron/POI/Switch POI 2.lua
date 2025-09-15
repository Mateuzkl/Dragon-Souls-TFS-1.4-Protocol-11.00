function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local piece1pos = Position(618, 644, 10)
    local rockpos = Position(618, 644, 10)
    local rockpos2 = Position(603, 626, 11)
    local getpiece1 = Tile(piece1pos):getItemById(3375)

    if item:getActionId() == 106 and item:getId() == 1945 and getpiece1 then
        getpiece1:remove()
        Game.createItem(5070, 1, rockpos2)
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "get hear on something open.")
        item:transform(item:getId() + 1)
        
        local leverPos = item:getPosition()
        addEvent(function()
            local lever = Tile(leverPos):getItemById(1946)
            if lever then
                Game.createItem(3375, 1, piece1pos)
                local rockItem = Tile(rockpos2):getItemById(5070)
                if rockItem then
                    rockItem:remove()
                end
                lever:transform(1945)
            end
        end, 30 * 60 * 1000)
        
    elseif item:getActionId() == 106 and item:getId() == 1946 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "get hear on something close.")
        Game.createItem(3375, 1, piece1pos)
        local rockItem = Tile(rockpos2):getItemById(5070)
        if rockItem then
            rockItem:remove()
        end
        item:transform(item:getId() - 1)
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Sorry, not possible.")
    end
    return true
end
