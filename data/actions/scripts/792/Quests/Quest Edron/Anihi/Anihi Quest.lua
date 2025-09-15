function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local questItems = {
        [5008] = {item = 2431, name = "Stonecutter Axe"},
        [5007] = {item = 2400, name = "Sword of Valor"},
        [5006] = {item = 5952, name = "Poem Scroll"},
        [5009] = {container = 1990, items = {{2421, 1}, {2160, 30}}, name = "a Present"}
    }
    
    local itemData = questItems[item:getUniqueId()]
    if not itemData then
        return false
    end
    
    local generalQuestStatus = player:getStorageValue(5000) 
    if generalQuestStatus ~= -1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "It is empty.")
        return true
    end
    
    if itemData.container then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found " .. itemData.name .. ".")
        local container = player:addItem(itemData.container, 1)
        if container then
            for i = 1, #itemData.items do
                container:addItem(itemData.items[i][1], itemData.items[i][2])
            end
        end
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found " .. itemData.name .. ".")
        player:addItem(itemData.item, 1)
    end
    
    fromPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
    
    Game.sendAnimatedText("Cleck!", fromPosition, TEXTCOLOR_ORANGE)
    
    player:setStorageValue(5000, 1)
    player:setStorageValue(item:getUniqueId(), 1)
    
    return true
end
