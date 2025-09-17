function onCastSpell(cid, var)
    local player = Player(cid)
    
    if #getCreatureSummons(cid) >= 1 then
        Player(cid):sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "Você não pode ter mais de um summon.")
        Game.sendAnimatedText("Falhou!", getCreaturePosition(cid), 215)
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end

    if player:getSoul(cid) < 100 then
        Player(cid):sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, 'Desculpe, você não tem número de alma suficiente.')
        Game.sendAnimatedText("Falhou!", getCreaturePosition(cid), 215)
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end

    local manaPercent = 50
    local maxMana = getCreatureMaxMana(cid)
    local manaToUse = math.ceil((manaPercent * maxMana) / 100)
    Player(cid):addMana(manaToUse)

    local summonName = "Cerberus1"
    if doSummonMonster(cid, summonName) then
        Creature(cid):addMana(-manaToUse)
        Player(cid):addSoul(-100)
        Player(cid):sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Você invocou a grande besta de três cabeças, Cerberus!')
        Position(getCreaturePosition(cid)):sendMagicEffect(CONST_ME_FIREAREA)
        Position(getCreaturePosition(cid)):sendMagicEffect(CONST_ME_MAGIC_GREEN)
        Game.sendAnimatedText("Summon!", getCreaturePosition(cid), 179)
        return true
    else
        Player(cid):addMana(manaToUse)
        Player(cid):addSoul(100)
        Player(cid):sendCancelMessage("Falha ao invocar o Cerberus.")
        Position(getCreaturePosition(cid)):sendMagicEffect(CONST_ME_POFF)
        return false
    end
end
