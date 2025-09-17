local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local condition = Condition(CONDITION_ATTRIBUTES)
condition:setParameter(CONDITION_PARAM_TICKS, 10000)
condition:setParameter(CONDITION_PARAM_SKILL_DISTANCE, 50)
condition:setParameter(CONDITION_PARAM_STAT_MAGICPOINTS, 5)
condition:setParameter(CONDITION_PARAM_DISABLE_DEFENSE, true)
condition:setParameter(CONDITION_PARAM_BUFF_SPELL, true)
combat:addCondition(condition)

local condition2 = Condition(CONDITION_REGENERATION)
condition2:setParameter(CONDITION_PARAM_SUBID, 1)
condition2:setParameter(CONDITION_PARAM_BUFF, true)
combat:addCondition(condition2)

local cooldown = 20
local magic = 246

function onCastSpell(cid, variant)
    local player = Player(cid)
    if not player then
        return false
    end

    if player:getStorageValue(10569) == 1 then
        player:sendCancelMessage(RETURNVALUE_YOUAREEXHAUSTED)
        player:getPosition():sendMagicEffect(CONST_ME_EXPLOSIONAREA)
        return false
    end

    local lastCastTime = player:getStorageValue(23076)
    local currentTime = os.time()
    if lastCastTime > currentTime then
        player:sendCancelMessage("Desculpe, mas você ainda está no efeito da magia. Aguarde alguns segundos.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end

    player:setStorageValue(23076, currentTime + cooldown)
    player:sendTextMessage(MESSAGE_STATUS_WARNING, "CD: Exevo San.")

    local duration = 20000 -- Duração total do efeito em milissegundos
    local interval = 2000 -- Intervalo entre os efeitos em milissegundos

    local function sendMagicEffect()
        player:getPosition():sendMagicEffect(magic)
    end

    for i = 0, duration, interval do
        addEvent(sendMagicEffect, i)
    end

    -- Aplicar a condição temporária para exibir o efeito mágico enquanto o jogador se move
    local effectCondition = Condition(CONDITION_OUTFIT)
    effectCondition:setTicks(duration / 1000 + 1)
    effectCondition:setOutfit({lookTypeEx = magic})
    player:addCondition(effectCondition)

    -- Exibir o texto animado em intervalos junto com o efeito de regeneração
    local textInterval = 2000 -- Intervalo entre os textos em milissegundos

    local function sendAnimatedText()
        local position = player:getPosition()
        Game.sendAnimatedText("Regen San", position, 215)
    end

    for i = textInterval, duration, textInterval do
        addEvent(sendAnimatedText, i)
    end

    return combat:execute(player, variant)
end
