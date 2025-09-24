local FIGHTING_SPIRIT_ORIGINAL = 4863
local FIGHTING_SPIRIT_EQUIPPED = 5884
local DURATION = 15 * 60 * 1000
local WARNING_TIME = 5 * 60 * 1000

function onEquip(player, item, position, fromPosition)
    if item:getId() ~= FIGHTING_SPIRIT_ORIGINAL then
        return true
    end
    
    local playerGUID = player:getGuid()
    
    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "Os espiritos sagrados agora acompanham este bravo guerreiro por 15 minutos.")
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
    item:transform(FIGHTING_SPIRIT_EQUIPPED)
    
    addEvent(function()
        local targetPlayer = Player(playerGUID)
        if targetPlayer then
            local equippedItem = targetPlayer:getSlotItem(CONST_SLOT_RING)
            if equippedItem and equippedItem:getId() == FIGHTING_SPIRIT_EQUIPPED then
                targetPlayer:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "Os espiritos sagrados estao se enfraquecendo... 5 minutos restantes.")
                targetPlayer:getPosition():sendMagicEffect(CONST_ME_MAGIC_YELLOW)
            end
        end
    end, WARNING_TIME)
    
    addEvent(function()
        local targetPlayer = Player(playerGUID)
        if targetPlayer then
            local equippedItem = targetPlayer:getSlotItem(CONST_SLOT_RING)
            if equippedItem and equippedItem:getId() == FIGHTING_SPIRIT_EQUIPPED then
                targetPlayer:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "Os espiritos sagrados se despedem deste guerreiro.")
                targetPlayer:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
                equippedItem:remove()
            end
        end
    end, DURATION)
    
    return true
end

function onDeEquip(player, item, position, fromPosition)
    if item:getId() ~= FIGHTING_SPIRIT_EQUIPPED then
        return true
    end
    
    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "Os espiritos sagrados se despedem deste guerreiro.")
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
    return true
end
