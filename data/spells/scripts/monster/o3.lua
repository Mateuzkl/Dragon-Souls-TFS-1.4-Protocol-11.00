local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 79)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -4.0, -300, -2.2, -300)

local area = createCombatArea(arr)
combat:setArea(area)

function onCastSpell(cid, var)
    return combat:execute(cid, var)
end
