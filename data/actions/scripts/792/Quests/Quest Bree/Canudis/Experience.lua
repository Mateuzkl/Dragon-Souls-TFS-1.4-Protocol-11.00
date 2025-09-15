local condition = Condition(CONDITION_ENERGY)
condition:setParameter(CONDITION_PARAM_DELAYED, 1)

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local questStatus = player:getStorageValue(5200)
    local expGain = math.random(3000000, 4000000)
    local playerLevel = player:getLevel()
    
    if playerLevel > 149 then
        if questStatus == -1 then
            player:addExperience(expGain)
            player:addCondition(condition)
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
            
            player:sendTextMessage(MESSAGE_STATUS_WARNING, 'Você recebeu ' .. expGain .. ' de experiência.')
            Game.sendAnimatedText(tostring(expGain), player:getPosition(), TEXTCOLOR_WHITE)
            
            player:setStorageValue(5200, 1)
        else
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "It is empty.")
        end
    else
        player:sendTextMessage(MESSAGE_STATUS_WARNING, 'Desculpe, você não tem nível suficiente.')
    end
    
    return true
end
