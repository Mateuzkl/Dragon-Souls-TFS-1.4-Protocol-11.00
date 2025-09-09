local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local condition = Condition(CONDITION_SILENCE)
condition:setParameter(CONDITION_PARAM_TICKS, 15000)
combat:addCondition(condition)

function onCastSpell(creature, variant)
    local target = creature:getTarget()
    if not target then
        creature:sendCancelMessage("You need a target.")
        creature:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end
    
    if target:isPlayer() then
        combat:execute(creature, variant)
        
        target:getPosition():sendMagicEffect(110)
        target:say("Silence!", TALKTYPE_MONSTER_SAY, false, nil, target:getPosition())
        
        return true
    else
        creature:sendCancelMessage("You can only silence players.")
        creature:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end
end