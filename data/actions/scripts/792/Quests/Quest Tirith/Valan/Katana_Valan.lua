function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if not target or target:getId() ~= 3900 then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, "You can only use this on a specific target.")
        return false
    end
    
    local actionId = target:getActionId()
    if actionId ~= 2412 then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, "Invalid action ID.")
        return false
    end
    
    if toPosition.x ~= 438 or toPosition.y ~= 234 or toPosition.z ~= 14 then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, "Use na posição correta.")
        return false
    end
    
    local teleportPositions = {
        Position(438, 238, 15),
        Position(443, 236, 15),
        Position(443, 241, 15),
        Position(439, 242, 15)
    }
    
    local randomPosition = teleportPositions[math.random(1, #teleportPositions)]
    
    target:setActionId(0)
    
    Game.createItem(5068, 1, Position(438, 234, 14))
    Game.createItem(5069, 1, Position(438, 234, 14))
    
    player:teleportTo(randomPosition)
    player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
    Game.sendAnimatedText("Wooow!", player:getPosition(), TEXTCOLOR_ORANGE)
    
    addEvent(function()
        local tile = Tile(Position(438, 234, 14))
        if tile then
            local item5068 = tile:getItemById(5068)
            if item5068 then
                item5068:remove()
            end
            
            local item5069 = tile:getItemById(5069)
            if item5069 then
                item5069:remove()
            end
        end
        
        local newItem = Game.createItem(2412, 1, Position(436, 241, 14))
        
    end, 30 * 60 * 1000)
    
    item:remove()
    
    return true
end
