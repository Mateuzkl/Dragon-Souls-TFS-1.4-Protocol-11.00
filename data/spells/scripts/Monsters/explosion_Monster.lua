local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 4)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -8.0, -50, -7.3, 0)

local arr = {
    {0, 1, 0},
    {1, 3, 1},
    {0, 1, 0}
}

local area = createCombatArea(arr)
combat:setArea(area)

function onCastSpell(cid, var)
    if getPlayerStorageValue(cid, 10569) == 1 then
        doSendAnimatedText(getCreaturePosition(cid), "Socorro!", 255)
        doSendMagicEffect(getCreaturePosition(cid), 19)
        doPlayerSendDefaultCancel(cid, RETURNVALUE_YOUAREEXHAUSTED)
        return false
    end
    return combat:execute(cid, var)
end
