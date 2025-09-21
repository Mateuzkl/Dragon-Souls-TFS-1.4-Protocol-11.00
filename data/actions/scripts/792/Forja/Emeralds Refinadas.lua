function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if target:getId() == 13864 then
        target:transform(7759)
        target:decay()
        item:remove(10)
    end
    
    return true
end
