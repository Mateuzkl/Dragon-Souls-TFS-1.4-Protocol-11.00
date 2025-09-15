local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local condition = Condition(CONDITION_HASTEGA)
condition:setParameter(CONDITION_PARAM_TICKS, 60000)
condition:setFormula(1.7, -76, 1.7, -76)
combat:addCondition(condition)

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end
    
    local rand = math.random(1, 50)
    if rand == 1 then
        player:say("HA! Try get me now!", TALKTYPE_MONSTER_SAY)
    elseif rand == 2 then
        player:say("See ya!", TALKTYPE_MONSTER_SAY)
    end
    
    return combat:execute(creature, variant)
end
