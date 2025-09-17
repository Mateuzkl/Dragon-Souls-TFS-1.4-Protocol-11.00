local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_HITCOLOR, COLOR_WHITE)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)

function onCastSpell(cid, var)
    combat:execute(cid, var)
end
