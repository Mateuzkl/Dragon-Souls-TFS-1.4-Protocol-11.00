function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local piece1pos = Position(887, 645, 11)
    local rockpos = Position(887, 645, 11)
    local getpiece1 = Tile(piece1pos):getItemById(1355)

    if item:getUniqueId() == 6546 and item:getId() == 1945 and getpiece1 then
        getpiece1:remove()
        player:sendTextMessage(MESSAGE_INFO_DESCR, "get hear on something open.")
        item:transform(item:getId() + 1)
    elseif item:getUniqueId() == 6546 and item:getId() == 1946 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "get hear on something close.")
        Game.createItem(1355, 1, rockpos)
        item:transform(item:getId() - 1)
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Sorry, not possible.")
    end
    return true
end
