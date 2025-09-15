function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local itemId = item:getId()
    if itemId == 2064 then
        item:getPosition():sendMagicEffect(6)
        
        Game.createItem(5061, 1, Position(468, 257, 14))
        
        if fromPosition.x == 464 and fromPosition.y == 258 and fromPosition.z == 14 then
            local door = Tile(Position(464, 257, 14)):getItemById(5134)
            if door then
                door:remove()
            end
            
            Game.createItem(5061, 1, Position(464, 257, 14))
        end
        
        addEvent(function()
            local item5061_1 = Tile(Position(468, 257, 14)):getItemById(5061)
            if item5061_1 then
                item5061_1:remove()
            end
            
            local item5061_2 = Tile(Position(464, 257, 14)):getItemById(5061)
            if item5061_2 then
                item5061_2:remove()
            end
        end, 1800000)
        
        item:transform(2065)
    elseif itemId == 2065 then
        item:transform(2064)
    else
        item:getPosition():sendMagicEffect(6)
        item:transform(item:getId() + 1)
    end
    
    return true
end
