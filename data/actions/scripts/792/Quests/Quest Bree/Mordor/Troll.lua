function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if item:getActionId() == 100 then
        player:teleportTo(Position(997, 1796, 7))
        
        Game.sendAnimatedText("Cleck!", toPosition, TEXTCOLOR_ORANGE)
        toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
    end
    
    return true
end
