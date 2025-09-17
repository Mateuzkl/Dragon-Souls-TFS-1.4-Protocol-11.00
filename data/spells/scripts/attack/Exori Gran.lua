local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 26)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -20.6, -250, -30.1, 490)

local arr = {
    {0, 0, 1, 0, 0},
    {0, 1, 1, 1, 0},
    {1, 1, 3, 1, 1},
    {0, 1, 1, 1, 0},
    {0, 0, 1, 0, 0},
}

local stun = Condition(CONDITION_STUN)
stun:setParameter(CONDITION_PARAM_DELAYED, 25)
stun:addDamage(500, 5000, -100)
combat:addCondition(stun)

local area = createCombatArea(arr)
combat:setArea(area)

function onCastSpell(cid, var)
    return combat:execute(cid, var)
end
