function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if not target or target:getId() ~= 1724 then
        return false
    end
    
    if item:getId() ~= 2391 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need a war hammer to break this.")
        return false
    end
    
    target:transform(2253)
    toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
    Game.sendAnimatedText("Crash!", toPosition, TEXTCOLOR_ORANGE)
    
    local pickaxe = Game.createItem(4874, 1, Position(469, 258, 14))
    if pickaxe then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You broke the dresser and found items inside!")
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Something went wrong.")
    end
    
    return true
end
