function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if target.type == 1 then
        if item.type <= 1 then
            if target.itemid == 1775 or (target.itemid >= 2005 and target.itemid <= 2009) then
                item:transform(2693)
                target:transform(target.itemid, 0)
            else
                return false
            end
        else
            player:sendCancelMessage("Only one by one.")
        end
    else 
        return false
    end
    return true
end
