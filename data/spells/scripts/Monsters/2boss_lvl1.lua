local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_SOUND_PURPLE)
combat:setParameter(COMBAT_PARAM_HITCOLOR, COLOR_PURPLE)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -0.4, -30, -0.5, 0)

local condition = Condition(CONDITION_CURSED)
condition:setParameter(CONDITION_PARAM_DELAYED, 1)
condition:addDamage(100, 3000, -50)
combat:addCondition(condition)

function onCastSpell(cid, var)
    return combat:execute(cid, var)
end
