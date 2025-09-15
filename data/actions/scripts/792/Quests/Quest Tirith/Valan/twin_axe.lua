function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if item:getId() ~= 2447 then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, "You can only use this with a twin axe.")
        return false
    end
    
    if not target or target:getId() ~= 1411 then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, "You can only use this on a specific target.")
        return false
    end
    
    local actionId = target:getActionId()
    local stalagmitePositions = {
        [4509] = Position(420, 227, 15),
        [4510] = Position(456, 221, 15),
        [4511] = Position(421, 254, 15),
        [4512] = Position(462, 246, 15)
    }
    
    local targetPosition = stalagmitePositions[actionId]
    if not targetPosition then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, "Invalid action ID.")
        return false
    end
    
    local stalagmiteTile = Tile(targetPosition)
    if not stalagmiteTile then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, "Target location not found.")
        return false
    end
    
    local stalagmite = stalagmiteTile:getItemById(387)
    if not stalagmite then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, "Stalagmite not found.")
        return false
    end
    
    stalagmite:remove()
    item:remove()
    
    toPosition:sendMagicEffect(CONST_ME_POFF)
    player:getPosition():sendMagicEffect(CONST_ME_HITAREA)
    toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
    Game.sendAnimatedText("Pick!", toPosition, TEXTCOLOR_ORANGE)
    
    return true
end
