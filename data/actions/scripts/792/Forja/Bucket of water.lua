function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if item:getId() == 13864 and target:getId() == 13663 then
        target:transform(13662)
        target:decay()
        item:transform(13660)
        item:decay()
    end
    
    return true
end
