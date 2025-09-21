function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if target:getId() == 5944 then
        item:transform(13663)
        item:decay()
        target:remove(1)
        Game.createItem(13651, 1, toPosition)
    end
    
    return true
end
