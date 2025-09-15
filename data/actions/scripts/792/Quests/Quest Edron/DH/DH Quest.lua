function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local uid = item:getUniqueId()
    
    if uid == 5561 then
        local queststatus = player:getStorageValue(5561)
        if queststatus == -1 then
            player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found Demon Helmet.")
            player:addItem(2493, 1)
            player:setStorageValue(5561, 1)
            toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
            Game.sendAnimatedText("Cleck!", toPosition, TEXTCOLOR_ORANGE)
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        else
            player:sendTextMessage(MESSAGE_INFO_DESCR, "It is empty.")
        end
    elseif uid == 6016 then
        local queststatus = player:getStorageValue(6016)
        if queststatus == -1 then
            player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found Demon Shield.")
            player:addItem(2520, 1)
            player:setStorageValue(6016, 1)
            toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
            Game.sendAnimatedText("Cleck!", toPosition, TEXTCOLOR_ORANGE)
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        else
            player:sendTextMessage(MESSAGE_INFO_DESCR, "It is empty.")
        end
    elseif uid == 5005 then
        local queststatus = player:getStorageValue(5005)
        if queststatus == -1 then
            player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a Steel Boots.")
            player:addItem(2645, 1)
            player:setStorageValue(5005, 1)
            toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
            Game.sendAnimatedText("Cleck!", toPosition, TEXTCOLOR_ORANGE)
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        else
            player:sendTextMessage(MESSAGE_INFO_DESCR, "It is empty.")
        end
    else
        return false
    end
    return true
end
