local combat = Combat()
combat:setParameter(COMBAT_PARAM_CREATEITEM, 1487)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)

local arr = {
    {1, 1, 1},
    {1, 3, 1},
    {1, 1, 1},
}

local area = createCombatArea(arr)
combat:setArea(area)

function onCastSpell(cid, var)
    return combat:execute(cid, var)
end
