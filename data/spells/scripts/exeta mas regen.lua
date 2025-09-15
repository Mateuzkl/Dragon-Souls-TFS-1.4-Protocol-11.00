local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_TARGETCASTERORTOPMOST, true)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setParameter(COMBAT_PARAM_EFFECT, 40)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, 0, 1, 0, 10)

local condition = Condition(CONDITION_REGENERATION)
condition:setParameter(CONDITION_PARAM_TICKS, 15000)
condition:setParameter(CONDITION_PARAM_HEALTHGAIN, 10000)
condition:setParameter(CONDITION_PARAM_HEALTHTICKS, 1)
combat:addCondition(condition)

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end
    
    player:say("Exeta mas regen", TALKTYPE_MONSTER_SAY)
    
    return combat:execute(creature, variant)
end
