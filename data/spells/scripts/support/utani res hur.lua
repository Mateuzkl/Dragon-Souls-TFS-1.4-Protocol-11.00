local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, 221)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local condition = Condition(CONDITION_HASTE)
condition:setParameter(CONDITION_PARAM_TICKS, 30000)
condition:setFormula(0.8, -75, 1.5, -80)
combat:addCondition(condition)

local cooldown = 5

function onCastSpell(creature, variant)
    local player = Player(creature)
    local exhaustStorage = 13014 -- Valor do armazenamento de cooldown

    if player:getStorageValue(exhaustStorage) <= os.time() then
        player:setStorageValue(exhaustStorage, os.time() + cooldown)
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Seu metabolismo foi acelerado.")
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        return combat:execute(creature, variant)
    else
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        player:sendCancelMessage("Warrior Acceleration em recarga por " .. (player:getStorageValue(exhaustStorage) - os.time()) .. " segundos.")
        return false
    end
end
