function onCastSpell(cid, var)
    local player = Player(cid)

    if #getCreatureSummons(cid) >= 1 then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "Você não pode ter mais de um summon.")
        Game.sendAnimatedText("Falhou!", getCreaturePosition(cid), 215)
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end

    local requiredSoul = 150
    if player:getSoul(cid) < requiredSoul then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, 'Desculpe, você não tem número de alma suficiente.')
        Game.sendAnimatedText("Falhou!", player:getPosition(), 215)
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end

    local manaPercent = 80
    local maxMana = getCreatureMaxMana(cid)
    local manaToUse = math.ceil((manaPercent * maxMana) / 100)
    player:addMana(manaToUse)

    local summonName = "Shadow Balrog1"
    if doSummonMonster(cid, summonName) then
        Creature(cid):addMana(-manaToUse)
        player:addSoul(-100)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Você invocou o lendário ' .. summonName .. '!')
        Position(getCreaturePosition(cid)):sendMagicEffect(CONST_ME_FIREAREA)
        Position(getCreaturePosition(cid)):sendMagicEffect(CONST_ME_MAGIC_GREEN)
        Game.sendAnimatedText("Summon!", getCreaturePosition(cid), 179)
        return true
    else
        player:addMana(manaToUse)
        player:addSoul(100)
        player:sendCancelMessage("Falha ao invocar o " .. summonName .. ".")
        Position(getCreaturePosition(cid)):sendMagicEffect(CONST_ME_POFF)
        return false
    end
end
