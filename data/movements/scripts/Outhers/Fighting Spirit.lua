local FIGHTING_SPIRIT_ORIGINAL = 4863
local FIGHTING_SPIRIT_EQUIPPED = 5884

function onEquip(player, item, position, fromPosition)
    if item:getId() ~= FIGHTING_SPIRIT_ORIGINAL then
        return true
    end
    
    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "Os espiritos sagrados agora acompanham este bravo guerreiro.")
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
    item:transform(FIGHTING_SPIRIT_EQUIPPED)
    return true
end

function onDeEquip(player, item, position, fromPosition)
    if item:getId() ~= FIGHTING_SPIRIT_EQUIPPED then
        return true
    end
    return true
end
