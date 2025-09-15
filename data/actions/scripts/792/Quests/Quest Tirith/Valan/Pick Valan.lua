function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if not target or not target.getId then
        return onUsePick(player, item, fromPosition, target, toPosition, isHotkey)
    end
    
    local targetId = target:getId()
    if targetId == 6299 or targetId == 7186 then
        target:transform(383)
        target:decay()
        return true
    end
    
    return onUsePick(player, item, fromPosition, target, toPosition, isHotkey)
end
