function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local gateposu = Position(232, 55, 11)
    local gateposd = Position(232, 56, 11)
    local gatepost = Position(233, 55, 11)
    local gateposq = Position(233, 56, 11)
    
    local tile = Tile(gateposu)
    local getgate = tile and tile:getTopVisibleThing() or nil
    
    if item.actionid == 3021 and item.itemid == 1945 and (not getgate or getgate:getId() == 0) then
        item:transform(item.itemid + 1)
    elseif item.actionid == 3021 and item.itemid == 1946 and (not getgate or getgate:getId() == 0) then
        Game.createItem(407, 1, gateposu)
        Game.createItem(407, 1, gateposd)
        Game.createItem(407, 1, gatepost)
        Game.createItem(407, 1, gateposq)
        item:transform(item.itemid - 1)
    else
        player:sendCancelMessage("Sorry, not possible.")
    end
    
    return true
end
