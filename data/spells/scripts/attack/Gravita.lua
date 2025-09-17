local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_BIGPLANTS)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SUDDENDEATH)

function onTargetCreature(cid, target)
    if isPlayer(cid) and isPlayer(target) then
        local rand = math.random(1, 5)
        if getCreatureMaxHealth(target) == getCreatureHealth(target) then
            if rand == 1 then
                doSendAnimatedText("Gravita!", getPlayerPosition(cid), 154)
                doPlayerAddMana(cid, -5000)
                doSendMagicEffect(getCreaturePosition(cid), CONST_ME_BIGPLANTS)
                doSendMagicEffect(getCreaturePosition(target), CONST_ME_POFF)
            else
                doSendAnimatedText("Gravita!", getPlayerPosition(cid), 154)
                doCreatureAddHealth(target, -getCreatureHealth(target) / 2)
            end
        else
            doSendAnimatedText("Gravita!", getPlayerPosition(cid), 154)
            doSendAnimatedText("Gravita!", getPlayerPosition(cid), 154)
            doCreatureAddHealth(target, getCreatureHealth(cid) * 3 / 4)
            doCreatureAddHealth(cid, -5000)
        end
    end
    if not isPlayer(cid) and isPlayer(target) then
        doSendAnimatedText(getCreaturePosition(target), "Gravita!", TEXTCOLOR_PURPLE)
        doCreatureAddHealth(target, -getCreatureHealth(target))
    end
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(cid, var)
    if getPlayerStorageValue(cid, 10569) == 1 then
        doSendAnimatedText(getCreaturePosition(cid), "Silence!", TEXTCOLOR_GREY)
        doPlayerSendDefaultCancel(cid, RETURNVALUE_YOUAREEXHAUSTED)
        return false
    end
    return combat:execute(cid, var)
end
