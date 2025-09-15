local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, 14)
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)

local exhaust = Condition(CONDITION_EXHAUSTED)
exhaust:setParameter(CONDITION_PARAM_TICKS, 5000)

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end
    
    creature:addCondition(exhaust)
    creature:getPosition():sendAnimatedText("Power Up!", 215)
    player:setStorageValue(7001, 1)
    
    if player:getStorageValue(7000) == 900 then
        player:setStorageValue(7000, player:getStorageValue(7000) + 1)
        player:say('Concentração Level Up!', TALKTYPE_MONSTER_SAY)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Sua concentração agora está level 2.')
    end
    
    if player:getStorageValue(7000) < 998 then
        player:setStorageValue(7000, player:getStorageValue(7000) + 1)
    end
    
    return combat:execute(creature, variant)
end
