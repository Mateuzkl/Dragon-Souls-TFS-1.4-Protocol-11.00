function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local positions = {
        Position(toPosition.x, toPosition.y, toPosition.z),
        Position(toPosition.x, toPosition.y-1, toPosition.z),
        Position(toPosition.x, toPosition.y+1, toPosition.z),
        Position(toPosition.x-1, toPosition.y, toPosition.z),
        Position(toPosition.x+1, toPosition.y, toPosition.z),
        Position(toPosition.x+1, toPosition.y-1, toPosition.z),
        Position(toPosition.x-1, toPosition.y+1, toPosition.z),
        Position(toPosition.x+1, toPosition.y+1, toPosition.z),
        Position(toPosition.x-1, toPosition.y-1, toPosition.z)
    }
    
    for effect = 1, 24 do
        for _, pos in ipairs(positions) do
            pos:sendMagicEffect(effect)
        end
    end
    
    return true
end
