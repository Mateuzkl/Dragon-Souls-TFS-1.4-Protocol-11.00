local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -0.2, -130, -0.2, -200)

local condition = Condition(CONDITION_ENERGY)
condition:setParameter(CONDITION_PARAM_DELAYED, 1)
condition:addDamage(1, 2300, -50)
condition:addDamage(1, 2300, -25)
condition:addDamage(1, 2300, -10)
combat:addCondition(condition)

function onCastSpell(cid, var)
    return combat:execute(cid, var)
end
