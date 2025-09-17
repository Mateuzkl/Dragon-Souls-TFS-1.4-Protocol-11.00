local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_TARGETCASTERORTOPMOST, 1)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, 0)

function onGetFormulaValues(cid, level, maglevel)
    local min = (level * 4 + maglevel * 2) * 2.6
    local max = (level * 4 + maglevel * 2) * 2.0

    return min, max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(cid, var)
    if getPlayerStorageValue(cid, 13654564950569) == 1 then
        doSendAnimatedText(getCreaturePosition(cid), "Silence!", TEXTCOLOR_LIGHTBLUE)
        doSendMagicEffect(getCreaturePosition(cid), CONST_ME_MAGIC_BLUE)
        doPlayerSendDefaultCancel(cid, RETURNVALUE_YOUAREEXHAUSTED)
        return false
    end

    return combat:execute(cid, var)
end
