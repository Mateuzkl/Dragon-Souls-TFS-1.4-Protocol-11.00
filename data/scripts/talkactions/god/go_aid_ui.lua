local goCommand = TalkAction("/go")

function goCommand.onSay(player, words, param, type)
    if not player:getGroup():getAccess() then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You don't have access to use this command.")
        return false
    end

    local uid = tonumber(param)
    if not uid then
        player:sendCancelMessage("You must provide a valid UID.")
        return false
    end

    -- Usar a função Item(uid) para encontrar o item e sua posição
    local item = Item(uid)
    if item and item:getPosition() then
        local position = item:getPosition()
        player:teleportTo(position)
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Teleported to UID: " .. uid)
    else
        player:sendCancelMessage("UID not found.")
    end

    return false
end

goCommand:separator(" ")
goCommand:register()
