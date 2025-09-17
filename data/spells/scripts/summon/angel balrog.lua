function onCastSpell(cid, var)
    if #getCreatureSummons(cid) >= 1 then
        Player(cid):sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "Você não pode ter mais de um summon.")
        Game.sendAnimatedText("Falhou!", getCreaturePosition(cid), 215)
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end

    local manaPercent = 20
    local maxMana = getCreatureMaxMana(cid)
    local manaToUse = math.ceil((manaPercent * maxMana) / 100)
    Player(cid):addMana(manaToUse)

    local summonName = "Angel Balrog"
    if doSummonMonster(cid, summonName) then
        Creature(cid):addMana(-manaToUse)
        Player(cid):sendCancelMessage("Você invocou o grande " .. summonName .. "!")
        Position(getCreaturePosition(cid)):sendMagicEffect(CONST_ME_MAGIC_GREEN)
        Game.sendAnimatedText("Summon!", getCreaturePosition(cid), 179)
        return true
    else
        return false
    end
end
