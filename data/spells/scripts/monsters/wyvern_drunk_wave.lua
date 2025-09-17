local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_SOUND_RED)

local arr = {
    {1, 1, 1},
    {0, 1, 0},
    {0, 3, 0},
}

local area = createCombatArea(arr)

combat:setArea(area)

local condition = Condition(CONDITION_DRUNK)
condition:setParameter(CONDITION_PARAM_TICKS, 20000)
combat:addCondition(condition)

function onCastSpell(cid, var)
    return combat:execute(cid, var)
end
