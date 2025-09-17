local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local tempo = 20

local conditionAttr = Condition(CONDITION_ATTRIBUTES)
conditionAttr:setParameter(CONDITION_PARAM_TICKS, tempo * 1000)
conditionAttr:setParameter(CONDITION_PARAM_SKILL_MELEE, 50)
conditionAttr:setParameter(CONDITION_PARAM_SKILL_FIST, 50)
conditionAttr:setParameter(CONDITION_PARAM_SKILL_SHIELD, 50)
conditionAttr:setParameter(CONDITION_PARAM_DISABLE_DEFENSE, true)
conditionAttr:setParameter(CONDITION_PARAM_BUFF_SPELL, true)
combat:addCondition(conditionAttr)

local conditionRegen = Condition(CONDITION_REGENERATION)
conditionRegen:setParameter(CONDITION_PARAM_SUBID, 1)
conditionRegen:setParameter(CONDITION_PARAM_BUFF, true)
conditionRegen:setParameter(CONDITION_PARAM_TICKS, tempo * 1000)
combat:addCondition(conditionRegen)

local cooldown = 20
local magic = 195

function onCastSpell(cid, var)
    local player = Player(cid)
    if player:getStorageValue(10569) == 1 then
        player:sendCancelMessage(RETURNVALUE_YOUAREEXHAUSTED)
        player:getPosition():sendMagicEffect(CONST_ME_EXPLOSIONAREA)
        return false
    end

    local lastCastTime = player:getStorageValue(91831)
    local currentTime = os.time()
    if lastCastTime > currentTime then
        player:sendCancelMessage("Desculpe, mas você ainda está no efeito da magia. Aguarde alguns segundos.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end

    local duration = 20000
    local interval = 2000

    local function sendMagicEffect()
        player:getPosition():sendMagicEffect(magic)
    end

    for i = 0, duration, interval do
        addEvent(sendMagicEffect, i)
    end

    local textInterval = 2000

    local function sendAnimatedText()
        Game.sendAnimatedText("Skill Up!", player:getPosition(), 215)
    end

    for i = textInterval, duration, textInterval do
        addEvent(sendAnimatedText, i)
    end

    player:setStorageValue(91831, currentTime + cooldown)
    addEvent(function()
        player:sendTextMessage(MESSAGE_STATUS_WARNING, "CD: Exevo Grav.")
    end, duration)

    local effectCondition = Condition(CONDITION_OUTFIT)
    effectCondition:setTicks(duration / 1000 + 1)
    effectCondition:setOutfit({lookTypeEx = magic})
    player:addCondition(effectCondition)

    return combat:execute(player, var)
end
