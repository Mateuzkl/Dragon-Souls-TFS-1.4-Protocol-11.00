local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_POISONDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_POISONAREA)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, 0, 0, 0, 0)

local arr = {
    {0, 0, 1, 1, 1, 0, 0},
    {0, 1, 1, 1, 1, 1, 0},
    {1, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 3, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 1},
    {0, 1, 1, 1, 1, 1, 0},
    {0, 0, 1, 1, 1, 0, 0},
}

local area = CombatArea()
area:setMatrix(arr)

combat:setArea(area)

local condition = Condition(CONDITION_POISON)
condition:setParameter(CONDITION_PARAM_DELAYED, 1)
condition:addDamage(1, 3000, -0)
condition:addDamage(1, 3000, -17)
condition:addDamage(1, 3000, -16)
condition:addDamage(1, 3000, -15)
condition:addDamage(1, 3000, -14)
condition:addDamage(2, 3000, -13)
condition:addDamage(2, 3000, -12)
condition:addDamage(2, 3000, -11)
condition:addDamage(2, 3000, -10)
condition:addDamage(3, 3000, -9)
condition:addDamage(3, 3000, -8)
condition:addDamage(3, 3000, -7)
condition:addDamage(4, 3000, -6)
condition:addDamage(4, 3000, -5)
condition:addDamage(5, 3000, -4)
condition:addDamage(5, 3000, -3)
condition:addDamage(6, 3000, -2)
condition:addDamage(10, 3000, -1)

combat:setCondition(condition)

function onCastSpell(cid, var)
    return combat:execute(cid, var)
end
