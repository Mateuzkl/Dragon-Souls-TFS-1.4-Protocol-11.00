function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local validItems = {4608, 4609, 4610, 4611, 4612, 4613, 4614, 4615, 4616, 4617, 4618, 4619, 4620, 4621, 4622, 4623, 4624, 4625}
    
    if table.contains(validItems, target:getId()) then
        item:transform(13661)
        item:decay()
    end
    
    return true
end

function table.contains(t, value)
    for _, v in ipairs(t) do
        if v == value then
            return true
        end
    end
    return false
end
