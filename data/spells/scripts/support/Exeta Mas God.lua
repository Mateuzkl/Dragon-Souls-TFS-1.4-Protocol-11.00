local config = { 
    storage = 3482101,
    cooldown = 20,  -- tempo entre um uso e outro
    duration = 10,  -- duração
}

local tempo = 10000
local moutfit = {lookType = 268, lookHead = 0, lookBody = 114, lookLegs = 114, lookFeet = 114, lookTypeEx = 0, lookAddons = 3}
local foutfit = {lookType = 269, lookHead = 0, lookBody = 114, lookLegs = 114, lookFeet = 114, lookTypeEx = 0, lookAddons = 3}

local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, 82)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, 0)

local condition = Condition(CONDITION_REGENERATION)
condition:setParameter(CONDITION_PARAM_TICKS, tempo)
condition:setParameter(CONDITION_PARAM_BUFF, true)
combat:addCondition(condition)

function onCastSpell99(cid)
    if isPlayer(cid) then
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "CD: Aurea of the Gods.")
    end
end

function onCastSpell(cid, var)
    if getPlayerStorageValue(cid, 10569) == 1 then
        doSendAnimatedText(getPlayerPosition(cid), "Silence!", 255)
        doPlayerSendDefaultCancel(cid, RETURNVALUE_YOUAREEXHAUSTED)
        return false 
    end

    if os.time() - getPlayerStorageValue(cid, 55695) < config.cooldown then
        doPlayerSendCancel(cid, "Sua habilidade está em recarga, você deve esperar "..(config.cooldown - (os.time() - getPlayerStorageValue(cid, 55695))).." segundos.")
        doSendMagicEffect(getCreaturePosition(cid), 2)
        return false
    end

    setPlayerStorageValue(cid, 55695, os.time())

    if getPlayerSex(cid) == 0 then
        doSetCreatureOutfit(cid, foutfit, tempo)
        doSendAnimatedText("Immortal!", getPlayerPosition(cid), 20)
        doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você está imortal.")
        doSendMagicEffect(getCreaturePosition(cid), 35)
        setPlayerStorageValue(cid, config.storage, os.time() + config.duration)
        addEvent(onCastSpell99, config.cooldown * 1000, cid)
    else 
        doSetCreatureOutfit(cid, moutfit, tempo)
        doPlayerSendTextMessage(cid, 20, "Você está imortal.")
        setPlayerStorageValue(cid, config.storage, os.time() + config.duration)
        addEvent(function()
            onCastSpell99(cid)
        end, config.cooldown * 1000)
    end
        doSendAnimatedText("Immortal!", getPlayerPosition(cid), 21)
    return combat:execute(cid, var) 
end
