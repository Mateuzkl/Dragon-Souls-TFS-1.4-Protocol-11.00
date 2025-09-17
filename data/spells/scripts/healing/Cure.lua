local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, 49) -- Substitua 49 pelo número do efeito desejado
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, 1, 3, 70, 100)

local SPELL_COOLDOWN = 2 -- Tempo de recarga em segundos

function onCastSpell(cid, var)
    local storage = getPlayerStorageValue(cid, 1051236569)
    if storage == 1 then
        doSendAnimatedText(getCreaturePosition(cid), "Silence!", 255)
        doSendMagicEffect(getCreaturePosition(cid), 50) -- Substitua 110 pelo número do efeito desejado
        doPlayerSendDefaultCancel(cid, RETURNVALUE_YOUAREEXHAUSTED)
        return false
    elseif storage == -1 then
        setPlayerStorageValue(cid, 10569, os.time() + SPELL_COOLDOWN)
       doSendAnimatedText("Healing!", getPlayerPosition(cid), 210)
        return combat:execute(cid, var)
    else
        local remainingCooldown = storage - os.time()
        if remainingCooldown <= 0 then
            setPlayerStorageValue(cid, 10569, os.time() + SPELL_COOLDOWN)
           doSendAnimatedText("Healing!", getPlayerPosition(cid), 210)
            return combat:execute(cid, var)
        else
            -- Informar ao jogador que a magia está em recarga
            local remainingSeconds = math.ceil(remainingCooldown)
            doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "A magia está em recarga. Aguarde " .. remainingSeconds .. " segundos.")
            return false
        end
    end
end
