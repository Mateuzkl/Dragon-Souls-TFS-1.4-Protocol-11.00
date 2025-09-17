local regenTime = 20 -- Tempo em segundos.
local regenAmount = 30 -- Quantidade de mana regenerada a cada intervalo.
local effect = 63 -- Efeito de partículas na regeneração.
local characterEffect = 28 -- Efeito visual do personagem durante a regeneração.
local cooldownTime = 60 -- Tempo de cooldown em segundos.

local function getRandomAdjacentPosition(position)
    local adjacentPositions = {
        {x = position.x + 1, y = position.y, z = position.z},
        {x = position.x - 1, y = position.y, z = position.z},
        {x = position.x, y = position.y + 1, z = position.z},
        {x = position.x, y = position.y - 1, z = position.z},
    }
    local randomIndex = math.random(1, #adjacentPositions)
    return adjacentPositions[randomIndex]
end

function sendAnimatedText(player, text)
    Game.sendAnimatedText(text, player:getPosition(), TEXTCOLOR_BLUE)
end

function onCastSpell(cid, var)
    local player = Player(cid)
    if not player then
        return false
    end

    local cooldownStorage = 89635 -- Substitua pelo valor de storage único para o cooldown deste feitiço

    if player:getCondition(CONDITION_REGENERATION, CONDITION_SUBID_NONE) or player:getStorageValue(cooldownStorage) > os.time() then
        player:sendCancelMessage("Você já está sob o efeito de uma regeneração de mana ou está em cooldown.")
        return false
    end

    player:addManaSpent(regenAmount * regenTime) -- Registra o gasto de mana para fins estatísticos (opcional)

    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Você entra em um estado de regeneração de mana.")
    player:getPosition():sendMagicEffect(characterEffect) -- Efeito visual do personagem

    local function magicEffect8()
        local position = player:getPosition()
        position:sendMagicEffect(effect)

        local playerPosition = getRandomAdjacentPosition(position)
        local tile = Tile(playerPosition)
        if tile then
            local creature = tile:getTopCreature()
            if creature and creature:isPlayer() then
                creature:getPosition():sendMagicEffect(effect)
            end
        end

        sendAnimatedText(player, "Regen Mana!")
        player:addMana(regenAmount)

        player:setStorageValue(cooldownStorage, os.time() + cooldownTime) -- Define o tempo de cooldown
    end

    for i = 1, regenTime do
        addEvent(magicEffect8, i * 1000)
    end

    return true
end
