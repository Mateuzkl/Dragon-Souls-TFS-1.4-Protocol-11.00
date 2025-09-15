local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local condition = Condition(CONDITION_MANASHIELD)
condition:setParameter(CONDITION_PARAM_TICKS, 180000)

combat:addCondition(condition)

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if player then
        local rand = math.random(1, 30)
        if rand == 1 then
            player:say("The magic become to life!", TALKTYPE_MONSTER_SAY)
        end
    end
    
    return combat:execute(creature, variant)
end
