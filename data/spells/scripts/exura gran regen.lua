local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, 0.6, -30, 0.9, 0)

local condition = Condition(CONDITION_ENERGY)
condition:setParameter(CONDITION_PARAM_DELAYED, true)
condition:addDamage(120, 1000, 250, 250)

combat:addCondition(condition)

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if player then
        local rand = math.random(1, 50)
        if rand == 1 then
            player:say("From the death to life!", TALKTYPE_MONSTER_SAY)
        elseif rand == 2 then
            player:say("Feel the life on Gaya!", TALKTYPE_MONSTER_SAY)
        elseif rand == 3 then
            player:say("The light on the darkness!", TALKTYPE_MONSTER_SAY)
        end
    end
    
    return combat:execute(creature, variant)
end
