local config = {
    newLevel = 8,
    redskull = true,
    battle = true,
    pz = true,
    levelRequired = 200,
    promotionMap = {
        [1] = {vocation = 9, name = "Wyzard"},   -- Sorcerer
        [5] = {vocation = 9, name = "Wyzard"},   -- Master Sorcerer
        [2] = {vocation = 10, name = "Cleric"},  -- Druid
        [6] = {vocation = 10, name = "Cleric"},  -- Elder Druid
        [3] = {vocation = 11, name = "Ranger"},  -- Archer
        [7] = {vocation = 11, name = "Ranger"},  -- Royal Archer
        [4] = {vocation = 12, name = "Slayer"},  -- Knight
        [8] = {vocation = 12, name = "Slayer"}   -- Elite Knight
    }
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local vocation = player:getVocation():getId()
    local promotion = config.promotionMap[vocation]
    
    if not promotion then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Sua vocação não pode ser promovida por esta orbe.")
        return true
    end

    if player:getLevel() < config.levelRequired then
        player:sendCancelMessage("Você precisa ser level " .. config.levelRequired .. " ou mais para usar esta orbe.")
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Clique no Pendulum Clock no templo quando atingir level 200 para se tornar um Valan Player e receber sua nova vocação!")
        return true
    end

    if config.battle and player:getCondition(CONDITION_INFIGHT) then
        player:sendCancelMessage("Você precisa estar fora de batalha para resetar.")
        return true
    end

    if config.pz then
        local tile = Tile(player:getPosition())
        if not tile or not tile:hasFlag(TILESTATE_PROTECTIONZONE) then
            player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Você precisa estar em uma protection zone para resetar.")
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Vá até o templo e clique no Pendulum Clock para se tornar um Valan Player!")
            return true
        end
    end

    if config.redskull and player:getSkull() == SKULL_RED then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Você precisa estar sem red skull para resetar.")
        return true
    end

    player:setVocation(Vocation(promotion.vocation))

    Game.broadcastMessage("O jogador " .. player:getName() .. " se tornou um Valan Player como " .. promotion.name .. "! Parabéns!", MESSAGE_EVENT_ADVANCE)

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "A força dos Semi-Deuses agora acompanham o nobre " .. promotion.name .. ".")
    player:sendTextMessage(MESSAGE_STATUS_WARNING, "Parabéns! Você agora é um Valan Player e sua nova vocação é " .. promotion.name .. "!")
    player:sendTextMessage(MESSAGE_INFO_DESCR, "Você foi resetado para o level 8 com sua nova vocação. Boa sorte em sua jornada!")
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)

    local query = string.format("UPDATE players SET level = %d, experience = %d WHERE id = %d",
                                config.newLevel, 4200, player:getGuid())
    player:remove()
    db.query(query)
    
    item:remove()
    return true
end
