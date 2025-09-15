function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if item:getActionId() == 333 then
        player:teleportTo(Position(121, 311, 7))
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    end
    
    return true
end
