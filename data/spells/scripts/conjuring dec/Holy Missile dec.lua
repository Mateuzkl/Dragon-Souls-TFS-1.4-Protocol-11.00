function onCastSpell(creature, variant)
    local requiredItemID = 2260
    local newItemID = 2295
    local newItemCount = 50

    local player = Player(creature)
    local hands = player:getSlotItem(CONST_SLOT_LEFT)
    local backpack = player:getItemById(requiredItemID)

    if hands and hands:getId() == requiredItemID then
        hands:transform(newItemID, newItemCount)
    elseif backpack then
        local count = math.min(backpack:getCount(), newItemCount)
        backpack:remove(count)
        player:addItem(newItemID, newItemCount)
    else
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Voce precisa ter pelo menos 1 adori blank para lancar a magia.")
        return false
    end

     player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
    local itemName = getItemNameById(newItemID)
    player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce lancou a magia e obteve " .. newItemCount .. " " .. itemName .. ".")
    return true
end