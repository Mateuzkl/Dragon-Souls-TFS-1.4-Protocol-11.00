local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_PLANTATTACK)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -11.0, -490, -10.6, -545)

local area = createCombatArea(AREA_CIRCLE3X3)
combat:setArea(area)

function onCastSpell(cid, var)
    return combat:execute(cid, var)
end