local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -35.0, -800, -30.0, -1000)

local cooldown = 10

local function mascold(cid)
    local player = Player(cid)
    if player then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "CD: Drainage.")
    end
end

function onCastSpell(creature, variant)
    local player = Player(creature)
    if player:getStorageValue(55555) >= os.time() then
        player:sendTextMessage(MESSAGE_STATUS_SMALL, "You are exhausted.")
        return true
    end

    local playerpos = player:getPosition()
    local target = creature:getTarget()
    local trapos = target:getPosition()

    local cooldownStorage = 23066
    local lastCastTime = player:getStorageValue(cooldownStorage)
    if lastCastTime and lastCastTime + cooldown > os.time() then
        playerpos:sendMagicEffect(2)
        player:sendCancelMessage("Drainage on cooldown for " .. (lastCastTime + cooldown - os.time()) .. " seconds.")
        return false
    end

    player:setStorageValue(55555, os.time() + 3) -- último número "3" é o cooldown em segundos
    player:setStorageValue(cooldownStorage, os.time())

    local mana1 = math.ceil(50 * player:getMaxMana() / 100 + 300)
    player:addMana(mana1)
    creature:addMana(mana1)

    trapos:sendMagicEffect(41)
    playerpos:sendMagicEffect(41)
    player:say("Aaaaaah..", TALKTYPE_MONSTER)
    trapos:sendDistanceEffect(playerpos, 28)
    addEvent(mascold, cooldown * 1000, creature:getId())

    return combat:execute(creature, variant)
end
