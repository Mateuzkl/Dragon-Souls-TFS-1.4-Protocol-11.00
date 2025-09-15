function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local uid = item:getUniqueId()
    
    if uid == 5903 then
        local queststatus = player:getStorageValue(5903)
        if queststatus == -1 then
            player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found Ferumbras Hat.")
            toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
            Game.sendAnimatedText("Cleck!", toPosition, TEXTCOLOR_ORANGE)
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
            player:addItem(5903, 1)
            player:setStorageValue(5903, 1)
        else
            player:sendTextMessage(MESSAGE_INFO_DESCR, "It is empty.")
        end
    elseif uid == 5803 then
        local queststatus = player:getStorageValue(5903)
        if queststatus == -1 then
            player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found Arbalest.")
            toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
            Game.sendAnimatedText("Cleck!", toPosition, TEXTCOLOR_ORANGE)
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
            player:addItem(5803, 1)
            player:setStorageValue(5903, 1)
        else
            player:sendTextMessage(MESSAGE_INFO_DESCR, "It is empty.")
        end
    elseif uid == 6528 then
        local queststatus = player:getStorageValue(5903)
        if queststatus == -1 then
            player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a The Avenger.")
            toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
            Game.sendAnimatedText("Cleck!", toPosition, TEXTCOLOR_ORANGE)
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
            player:addItem(6528, 1)
            player:setStorageValue(5903, 1)
        else
            player:sendTextMessage(MESSAGE_INFO_DESCR, "It is empty.")
        end
    else
        return false
    end
    return true
end
