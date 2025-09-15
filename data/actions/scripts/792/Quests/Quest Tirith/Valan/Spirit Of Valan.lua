local condition = Condition(CONDITION_ENERGY)
condition:setParameter(CONDITION_PARAM_DELAYED, 1)

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local vocation = player:getVocation():getId()
    local playerLevel = player:getLevel()
    
    if playerLevel == 8 then
        local promotionMap = {
            [1] = {vocation = 9, name = "Wyzard"},
            [2] = {vocation = 10, name = "Cleric"},
            [3] = {vocation = 11, name = "Ranger"},
            [4] = {vocation = 12, name = "Slayer"}
        }
        
        local promotion = promotionMap[vocation]
        if promotion then
            player:setVocation(Vocation(promotion.vocation))
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "A força dos Semi-Deuses agora acompanham o nobre " .. promotion.name .. ".")
            player:sendTextMessage(MESSAGE_STATUS_WARNING, "Parabéns, agora você é um valan player")
            
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
            player:addCondition(condition)
            
            item:remove()
        else
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Desculpe, você não tem vocação necessária ou nível suficiente.")
        end
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Desculpe, você não tem vocação necessária ou nível suficiente.")
    end
    
    return true
end

