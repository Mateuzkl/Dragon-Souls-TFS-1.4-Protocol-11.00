local combat = Combat()
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 20)
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SPEAR)
combat:setFormula(COMBAT_FORMULA_SKILL, 0, 0, 0.10, 0)

function onUseWeapon(cid, var, item)
    -- By GENOMA

    chance = 11

    quebrar = math.random(1, chance)
    if quebrar == 1 then
        doPlayerRemoveItem(cid, 7378, 1)
    end

    return combat:execute(cid, var)
end
