function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local piece1pos = Position(762, 689, 13)
    local rockpos = Position(762, 689, 13)
    local rockpos2 = Position(743, 682, 13)
    local getpiece1 = Tile(piece1pos):getItemById(1354)

    if item:getUniqueId() == 6547 and item:getId() == 1945 and getpiece1 then
        getpiece1:remove()
        player:sendTextMessage(MESSAGE_INFO_DESCR, "get hear on something open.")
        item:transform(item:getId() + 1)
    elseif item:getUniqueId() == 6547 and item:getId() == 1946 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "get hear on something close.")
        Game.createItem(1354, 1, rockpos)
        item:transform(item:getId() - 1)
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Sorry, not possible.")
    end
    return true
end
