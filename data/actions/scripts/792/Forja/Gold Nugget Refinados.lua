function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if target:getId() == 13628 then
        target:transform(13629)
        target:decay()
        item:remove(10)
    end
    
    return true
end
