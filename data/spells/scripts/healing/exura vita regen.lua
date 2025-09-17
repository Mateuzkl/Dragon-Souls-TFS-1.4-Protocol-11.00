local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_TARGETCASTERORTOPMOST, true)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, 0, 1, 0, 10)

local condition = Condition(CONDITION_REGENERATION)
condition:setParameter(CONDITION_PARAM_TICKS, 60000)
condition:setParameter(CONDITION_PARAM_HEALTHGAIN, 2000)
condition:setParameter(CONDITION_PARAM_HEALTHTICKS, 1)
combat:setCondition(condition)

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end
    
    local rand = math.random(1, 50)
    if rand == 1 then
        player:say("From the death to life!", TALKTYPE_MONSTER_SAY)
    elseif rand == 2 then
        player:say("Feel the life on your soul!", TALKTYPE_MONSTER_SAY)
    elseif rand == 3 then
        player:say("The light on the darkness!", TALKTYPE_MONSTER_SAY)
    end
    
    return combat:execute(creature, variant)
end
