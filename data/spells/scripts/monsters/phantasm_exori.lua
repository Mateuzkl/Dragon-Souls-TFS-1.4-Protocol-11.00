local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_POISONDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_YELLOW_RINGS)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -2.3, -184, -3, -240)

local condition = Condition(CONDITION_POISON)
condition:setParameter(CONDITION_PARAM_DELAYED, 1)
condition:addDamage(1, 3000, -0)
condition:addDamage(2, 3000, -26)
condition:addDamage(3, 3000, -25)
condition:addDamage(3, 3000, -24)
condition:addDamage(4, 3000, -23)
condition:addDamage(4, 3000, -22)
condition:addDamage(6, 3000, -21)
condition:addDamage(6, 3000, -20)
condition:addDamage(8, 3000, -19)
condition:addDamage(10, 3000, -18)
condition:addDamage(14, 3000, -17)
condition:addDamage(17, 3000, -16)
condition:addDamage(19, 3000, -15)
condition:addDamage(21, 3000, -14)
condition:addDamage(24, 3000, -13)
condition:addDamage(28, 3000, -12)
condition:addDamage(32, 3000, -11)
condition:addDamage(38, 3000, -10)
condition:addDamage(42, 3000, -9)
condition:addDamage(47, 3000, -8)
condition:addDamage(51, 3000, -7)
condition:addDamage(55, 3000, -6)
condition:addDamage(59, 3000, -5)
condition:addDamage(61, 3000, -4)
condition:addDamage(64, 3000, -3)
condition:addDamage(77, 3000, -2)
condition:addDamage(80, 3000, -1)

combat:addCondition(condition)

local arr = {
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 3, 1, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
}

local area = createCombatArea(arr)
combat:setArea(area)

function onCastSpell(cid, var)
    return combat:execute(cid, var)
end
