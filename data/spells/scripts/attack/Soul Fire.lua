local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITBYFIRE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)

local condition = Condition(CONDITION_FIRE)
condition:setParameter(CONDITION_PARAM_DELAYED, 1)
condition:addDamage(10, 2000, -10)
combat:addCondition(condition)

function onCastSpell(cid, var)
    if getPlayerStorageValue(cid, 10569) == 1 then
        doSendAnimatedText(getCreaturePosition(cid), "Silence!", COLOR_WHITE)
        doSendMagicEffect(getCreaturePosition(cid), CONST_ME_MAGIC_RED)
        doPlayerSendCancel(cid, RETURNVALUE_YOUAREEXHAUSTED)
        return false
    end
    return combat:execute(cid, var)
end
