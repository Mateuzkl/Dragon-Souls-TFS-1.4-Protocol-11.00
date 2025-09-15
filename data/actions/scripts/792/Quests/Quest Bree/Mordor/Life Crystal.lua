function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if not target or target:getActionId() ~= 100 or target:getId() ~= 3900 then
        return false
    end
    
    local wallPositions = {
        {x = 1055, y = 1772, z = 4},
        {x = 1055, y = 1773, z = 4}
    }
    
    local createPositions = {
        {x = 1052, y = 1762, z = 4, itemId = 5070},
        {x = 1052, y = 1762, z = 4, itemId = 2177}
    }
    
    local wallsRemoved = 0
    for _, pos in ipairs(wallPositions) do
        local tile = Tile(Position(pos.x, pos.y, pos.z))
        if tile then
            local wall = tile:getTopDownItem()
            if wall then
                wall:remove()
                wallsRemoved = wallsRemoved + 1
            end
        end
    end
    
    if wallsRemoved > 0 then
        for _, data in ipairs(createPositions) do
            Game.createItem(data.itemId, 1, Position(data.x, data.y, data.z))
        end
        
        toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
        Game.sendAnimatedText("Cleck!", toPosition, TEXTCOLOR_ORANGE)
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You hear something open.")
        
        item:remove()
    end
    
    return true
end
