function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local piece1pos = Position(71, 307, 7)
    local piece2pos = Position(70, 307, 7)
    
    if item:getUniqueId() ~= 10009 then
        return false
    end
    
    if item:getId() == 1945 then
        local tile1 = Tile(piece1pos)
        local tile2 = Tile(piece2pos)
        
        if not tile1 or not tile2 then
            return true
        end
        
        local piece1 = tile1:getItemById(1544)
        local piece2 = tile2:getItemById(1544)
        
        if piece1 and piece2 then
            piece1:remove()
            piece2:remove()
            item:transform(1946)
            player:sendTextMessage(MESSAGE_INFO_DESCR, "get hear on something open.")
        end
        
    elseif item:getId() == 1946 then
        Game.createItem(1544, 1, piece1pos)
        Game.createItem(1544, 1, piece2pos)
        item:transform(1945)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "get hear on something close.")
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Sorry, not possible.")
    end
    
    return true
end
