function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if fromPosition.x ~= 65535 or fromPosition.y < 64 then
        local n = math.random(28, 30)
        fromPosition:sendMagicEffect(n)
    else
        player:addHealth(-10)
        fromPosition:sendMagicEffect(CONST_ME_DRAWBLOOD)
    end
    
    item:remove(1)
    return true
end
