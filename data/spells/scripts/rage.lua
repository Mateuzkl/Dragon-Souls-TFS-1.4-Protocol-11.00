local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, 13)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local condition = Condition(CONDITION_HASTE)
condition:setParameter(CONDITION_PARAM_TICKS, 20000)
condition:setFormula(1.7, -76, 1.7, -76)

combat:addCondition(condition)

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if player then
        player:getPosition():sendAnimatedText("Rage", TEXTCOLOR_LIGHTBLUE)
    end
    
    return combat:execute(creature, variant)
end
