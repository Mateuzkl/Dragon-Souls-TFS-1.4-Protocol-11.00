function onCastSpell(cid, var)
    local player = Player(cid)

    if #getCreatureSummons(cid) >= 1 then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "Você não pode ter mais de um summon.")
        Game.sendAnimatedText("Falhou!", player:getPosition(), 215)
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end

    local requiredSoul = 50
    if player:getSoul() < requiredSoul then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, 'Desculpe, você não tem número de alma suficiente.')
        Game.sendAnimatedText("Falhou!", player:getPosition(), 215)
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end

    local manaPercent = 20
    local maxMana = player:getMaxMana()
    local manaToUse = math.ceil((manaPercent * maxMana) / 100)
    player:addMana(manaToUse)

    local summonName = "Ghost Soul1"
    if doSummonMonster(cid, summonName) then
        Creature(cid):addMana(-manaToUse)
        player:sendCancelMessage("Você invocou o fantasma " .. summonName .. "!")
        Position(player:getPosition()):sendMagicEffect(CONST_ME_MAGIC_GREEN)
        Game.sendAnimatedText("Summon!", player:getPosition(), 179)
        return true
    else
        return false
    end
end
