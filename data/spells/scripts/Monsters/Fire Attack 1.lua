local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 146)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -13, 0, 0, 0)

local arr = {
    {0, 1, 0},
    {0, 1, 0},
    {0, 1, 0},
    {0, 1, 0},
    {0, 1, 0},
    {0, 3, 0},
}

local area = createCombatArea(arr)
combat:setArea(area)

function onCastSpell(cid, var)
    if getPlayerStorageValue(cid, 10569) == 1 then
        doSendAnimatedText(getCreaturePosition(cid), "Silence!", 255)
        doSendMagicEffect(getCreaturePosition(cid), 110)
        doPlayerSendDefaultCancel(cid, RETURNVALUE_YOUAREEXHAUSTED)
        return false
    end
    return combat:execute(cid, var)
end
