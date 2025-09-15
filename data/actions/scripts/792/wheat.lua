function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if target.itemid >= 1381 and target.itemid <= 1384 then
        if item.type <= 1 then
            item:transform(2692)
        else
            player:sendCancelMessage("Only one by one.")
        end
    else 
        return false
    end
    return true
end
