function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if target:getId() == 13627 then
        target:transform(13628)
        target:decay()
        item:remove(1)
    end
    
    return true
end
