local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 15)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)
combat:setParameter(COMBAT_PARAM_CREATEITEM, 1492)

local area = createCombatArea({
{0, 1, 0},
{1, 3, 1},
{0, 1, 0}
})

combat:setArea(area)

function onCastSpell(cid, var)
return combat:execute(cid, var)
end