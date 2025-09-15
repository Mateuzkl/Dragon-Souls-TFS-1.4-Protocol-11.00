function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local piece1pos = Position(650, 639, 11)
    local rockpos = Position(650, 639, 11)
    local getpiece1 = Tile(piece1pos):getItemById(1354)

    if item:getActionId() == 107 and item:getId() == 1945 and getpiece1 then
        getpiece1:remove()
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "get hear on something open.")
        item:transform(item:getId() + 1)
        
        local leverPos = item:getPosition()
        addEvent(function()
            local lever = Tile(leverPos):getItemById(1946)
            if lever then
                Game.createItem(1354, 1, piece1pos)
                lever:transform(1945)
            end
        end, 30 * 60 * 1000)
        
    elseif item:getActionId() == 107 and item:getId() == 1946 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "get hear on something close.")
        Game.createItem(1354, 1, piece1pos)
        item:transform(item:getId() - 1)
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Sorry, not possible.")
    end
    return true
end
