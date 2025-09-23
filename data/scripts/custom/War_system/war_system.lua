local minPlayersOnline = 50
local minLevel = 150

local function trim(str)
    return str:match("^%s*(.-)%s*$")
end

local function hasMinimumMembersInGuild(guild)
    local membersOnline = guild:getMembersOnline()
    local total = 0
    for _, member in ipairs(membersOnline) do
        if member:getLevel() >= minLevel then
            total = total + 1
        end
    end
    return total >= minPlayersOnline
end

local function setWarEmblem(player)
    local guild = player:getGuild()
    if not guild then
        return
    end
    
    local guildId = guild:getId()
    local warQuery = db.storeQuery(string.format("SELECT `guild1`, `guild2` FROM `guild_wars` WHERE (`guild1` = %d OR `guild2` = %d) AND `status` = 1", guildId, guildId))
    
    if warQuery then
        repeat
            local guild1 = result.getNumber(warQuery, "guild1")
            local guild2 = result.getNumber(warQuery, "guild2")
            
            local enemyGuildId = (guild1 == guildId) and guild2 or guild1
            
            for _, otherPlayer in pairs(Game.getPlayers()) do
                local otherGuild = otherPlayer:getGuild()
                if otherGuild and otherGuild:getId() == enemyGuildId then
                    if player.setGuildEmblem then
                        player:setGuildEmblem(enemyGuildId, 2)
                    end
                end
            end
        until not result.next(warQuery)
        result.free(warQuery)
    end
    
    for _, otherPlayer in pairs(Game.getPlayers()) do
        local otherGuild = otherPlayer:getGuild()
        if otherGuild then
            local otherGuildId = otherGuild:getId()
            if otherGuildId ~= guildId then
                local isEnemy = false
                local checkWarQuery = db.storeQuery(string.format("SELECT `id` FROM `guild_wars` WHERE ((`guild1` = %d AND `guild2` = %d) OR (`guild1` = %d AND `guild2` = %d)) AND `status` = 1", guildId, otherGuildId, otherGuildId, guildId))
                if checkWarQuery then
                    isEnemy = true
                    result.free(checkWarQuery)
                end
                
                if not isEnemy and player.setGuildEmblem then
                    player:setGuildEmblem(otherGuildId, 0)
                end
            end
        end
    end
end

local function updateAllWarEmblems(guild1Id, guild2Id)
    for _, player in pairs(Game.getPlayers()) do
        local guild = player:getGuild()
        if guild then
            local guildId = guild:getId()
            if guildId == guild1Id then
                for _, otherPlayer in pairs(Game.getPlayers()) do
                    local otherGuild = otherPlayer:getGuild()
                    if otherGuild and otherGuild:getId() == guild2Id then
                        if player.setGuildEmblem then
                            player:setGuildEmblem(guild2Id, 2)
                        end
                    end
                end
            elseif guildId == guild2Id then
                for _, otherPlayer in pairs(Game.getPlayers()) do
                    local otherGuild = otherPlayer:getGuild()
                    if otherGuild and otherGuild:getId() == guild1Id then
                        if player.setGuildEmblem then
                            player:setGuildEmblem(guild1Id, 2)
                        end
                    end
                end
            end
        end
    end
end

local function removeAllWarEmblems(guild1Id, guild2Id)
    for _, player in pairs(Game.getPlayers()) do
        local guild = player:getGuild()
        if guild then
            local guildId = guild:getId()
            if guildId == guild1Id then
                if player.setGuildEmblem then
                    player:setGuildEmblem(guild2Id, 0)
                end
            elseif guildId == guild2Id then
                if player.setGuildEmblem then
                    player:setGuildEmblem(guild1Id, 0)
                end
            end
        end
    end
end

local warTalkAction = TalkAction("!war")
function warTalkAction.onSay(player, words, param)
    if player:getStorageValue(98772) > os.time() then
        player:sendCancelMessage("You are exhausted.")
        return false
    end
    
    player:setStorageValue(98772, os.time() + 1)
    
    local guild = player:getGuild()
    if not guild then
        player:sendCancelMessage("Voce precisa estar em uma Guild para usar esse comando.")
        return false
    end
    
    local p = param:split(',')
    local action, targetGuildName = trim(p[1] or ""), trim(p[2] or "")
    
    if not action or not targetGuildName then
        player:popupFYI('Utilize o comando corretamente:' .. '\n\n' .. 'Para invitar warmode contra a guild Batmans por 30 frags:\n' .. '--> !war invite,Batmans,30' .. '\n\n' .. 'Para aceitar o pedido de warmode contra a guild Zords:\n' .. '--> !war accept,Zords' .. '\n\n' .. 'Para rejeitar o pedido de warmode da guild Zords:\n' .. '--> !war reject,Zords' .. '\n\n' .. 'Para cancelar o pedido de warmode da guild Zords:\n' .. '--> !war cancel,Zords' .. '\n\n' .. 'Para terminar a warmode contra a guild Zords:\n' .. '--> !war end,Zords')
        return true
    end
    
    local resultName = db.storeQuery(string.format('SELECT `id` FROM `guilds` WHERE `name` = %s', db.escapeString(targetGuildName)))
    if not resultName then
        player:sendCancelMessage(string.format("A guild %s nao existe.", targetGuildName))
        return false
    end
    
    local targetGuildId = result.getNumber(resultName, "id")
    result.free(resultName)
    
    local guildId, guildName = guild:getId(), guild:getName()
    
    if action:lower() == "invite" then
        if not hasMinimumMembersInGuild(guild) then
            player:sendTextMessage(MESSAGE_INFO_DESCR, string.format('Voce precisa ter no mínimo %d player%s online na sua Guild que sejam maior que o level %d para usar esse comando.', minPlayersOnline, minPlayersOnline ~= 1 and 's', minLevel))
            return false
        end
        
        if #p ~= 3 then
            player:sendTextMessage(MESSAGE_INFO_DESCR, 'Por favor utilize o comando corretamente:\n!war invite, nome_da_guild_inimiga, frags\n\nPor exemplo:\n!war invite,Blackout,100')
            return false
        end
        
        local frags = trim(p[3])
        
        if targetGuildName:lower() == guildName:lower() or guildId == targetGuildId then
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce nao pode invitar a sua propria guild para warmode.")
            return false
        end
        
        local resultInvite = db.storeQuery(string.format("SELECT `id` FROM `guild_wars` WHERE (((guild1 = %d AND guild2 = %d) OR (guild1 = %d AND guild2 = %d)) AND (status = 0 OR status = 1))", guildId, targetGuildId, targetGuildId, guildId))
        if resultInvite then
            player:sendCancelMessage("Voce ja enviou um convite de warmode para essa guild.")
            result.free(resultInvite)
            return false
        end
        
        local fragsLimit = tonumber(frags)
        if not fragsLimit then
            player:sendCancelMessage("Por favor utilize so numeros nos frags.")
            return false
        end
        
        if fragsLimit < 20 or fragsLimit > 999 then
            player:sendCancelMessage("A quantidade minima eh de 20 frags e 999 a maxima.")
            return false
        end
        
        db.query(string.format('INSERT INTO `guild_wars`(`guild1`, `guild2`, `name1`, `name2`, `status`, `started`, `ended`, `fraglimit`) VALUES (%d, %d, %s, %s, %d, %d, %d, %d)', guildId, targetGuildId, db.escapeString(guildName), db.escapeString(targetGuildName), 0, 0, 0, fragsLimit))
        
        Game.broadcastMessage(string.format('[WARMODE] %s invitou a guild %s para warmode de %d frags!', guild:getName(), targetGuildName, fragsLimit), MESSAGE_EVENT_ADVANCE)
        
    elseif action:lower() == "accept" then
        if not hasMinimumMembersInGuild(guild) then
            player:sendTextMessage(MESSAGE_INFO_DESCR, string.format('Voce precisa ter no minimo %d player%s online na sua Guild que sejam maior que o level %d para usar esse comando.', minPlayersOnline, minPlayersOnline ~= 1 and 's', minLevel))
            return false
        end
        
        local acceptResult = db.storeQuery(string.format("SELECT `id`, `guild1`, `guild2` FROM `guild_wars` WHERE (`status` = 0 AND (name1 = %s AND name2 = %s) OR (name2 = %s AND name1 = %s))", db.escapeString(targetGuildName), db.escapeString(guildName), db.escapeString(guildName), db.escapeString(targetGuildName)))
        if not acceptResult then
            player:sendCancelMessage('Nao tem nenhum convite pendente de warmode contra essa guild.')
            return false
        end
        
        local invitationId = result.getNumber(acceptResult, "id")
        local guildInvited = result.getNumber(acceptResult, "guild1")
        local guild2 = result.getNumber(acceptResult, "guild2")
        result.free(acceptResult)
        
        if guildInvited == guildId then
            player:sendCancelMessage('Voce nao pode aceitar uma Warmode que foi voce que invitou.')
            return false
        end
        
        db.query(string.format('UPDATE `guild_wars` SET `status` = 1, `started` = %d WHERE `id` = %d', os.time(), invitationId))
        
        updateAllWarEmblems(guildInvited, guild2)
        
        Game.broadcastMessage(string.format('[WARMODE] A guild %s aceitou o pedido de warmode da guild %s.', guildName, targetGuildName), MESSAGE_EVENT_ADVANCE)
        
    elseif action:lower() == "reject" then
        if not hasMinimumMembersInGuild(guild) then
            player:sendTextMessage(MESSAGE_INFO_DESCR, string.format('Voce precisa ter no minimo %d player%s online na sua Guild que sejam maior que o level %d para usar esse comando.', minPlayersOnline, minPlayersOnline ~= 1 and 's', minLevel))
            return false
        end
        
        local rejectId = db.storeQuery(string.format("SELECT `id`, `guild1`, `guild2` FROM `guild_wars` WHERE (`status` = 0 AND (name1 = %s AND name2 = %s) OR (name2 = %s AND name1 = %s))", db.escapeString(targetGuildName), db.escapeString(guildName), db.escapeString(guildName), db.escapeString(targetGuildName)))
        if not rejectId then
            player:sendCancelMessage('Nao tem nenhum convite pendente de warmode contra essa guild.')
            return false
        end
        
        local invitationId = result.getNumber(rejectId, "id")
        local guildInvited = result.getNumber(rejectId, "guild2")
        result.free(rejectId)
        
        if guildInvited == guildId then
            player:sendCancelMessage('Voce nao pode rejeitar uma Warmode que foi voce que invitou.')
            return false
        end
        
        db.query(string.format('UPDATE `guild_wars` SET `status` = 2 WHERE `id` = %d', invitationId))
        
        Game.broadcastMessage(string.format('A guild %s rejeitou o pedido de warmode da guild %s.', guildName, targetGuildName), MESSAGE_EVENT_ADVANCE)
        
    elseif action:lower() == "end" then
        local endResult = db.storeQuery(string.format("SELECT `id`, `guild1`, `guild2` FROM `guild_wars` WHERE (`status` = 1 AND (name1 = %s AND name2 = %s) OR (name2 = %s AND name1 = %s))", db.escapeString(targetGuildName), db.escapeString(guildName), db.escapeString(guildName), db.escapeString(targetGuildName)))
        if not endResult then
            player:sendCancelMessage('Atualmente a sua Guild nao esta em nenhuma warmode ativa com essa guild.')
            return false
        end
        
        local warId = result.getNumber(endResult, "id")
        local guild1Id = result.getNumber(endResult, "guild1")
        local guild2Id = result.getNumber(endResult, "guild2")
        result.free(endResult)
        
        removeAllWarEmblems(guild1Id, guild2Id)
        
        db.query(string.format('UPDATE `guild_wars` SET `status` = 4, `ended` = %d WHERE `id` = %d', os.time(), warId))
        
        Game.broadcastMessage(string.format('A guild %s encerrou a warmode contra a guild %s.', guildName, targetGuildName), MESSAGE_EVENT_ADVANCE)
        
    elseif action:lower() == "cancel" then
        if not hasMinimumMembersInGuild(guild) then
            player:sendTextMessage(MESSAGE_INFO_DESCR, string.format('Voce precisa ter no minimo %d player%s online na sua Guild que sejam maior que o level %d para usar esse comando.', minPlayersOnline, minPlayersOnline ~= 1 and 's', minLevel))
            return false
        end
        
        local resultCancel = db.storeQuery(string.format("SELECT `id`, `guild1` FROM `guild_wars` WHERE (`status` = 0 AND (name1 = %s AND name2 = %s) OR (name2 = %s AND name1 = %s))", db.escapeString(targetGuildName), db.escapeString(guildName), db.escapeString(guildName), db.escapeString(targetGuildName)))
        if not resultCancel then
            player:sendCancelMessage('Nao tem nenhum convite pendente de warmode contra essa guild.')
            return false
        end
        
        local invitationId = result.getNumber(resultCancel, "id")
        local guildInvited = result.getNumber(resultCancel, "guild1")
        result.free(resultCancel)
        
        if guildInvited ~= guildId then
            player:sendCancelMessage('Voce nao pode cancelar uma War que nao foi voce que invitou.')
            return false
        end
        
        db.query(string.format('UPDATE `guild_wars` SET `status` = 3 WHERE `id` = %d', invitationId))
        
        Game.broadcastMessage(string.format('A guild %s cancelou o pedido de warmode a guild %s.', guildName, targetGuildName), MESSAGE_EVENT_ADVANCE)
    end
    
    return false
end
warTalkAction:separator(" ")
warTalkAction:register()

local warGlobalEvent = GlobalEvent("war_check")
function warGlobalEvent.onThink(interval)
    local resultid = db.storeQuery("SELECT * FROM guild_wars WHERE status = 1")
    if resultid then
        repeat
            local warid = result.getNumber(resultid, "id")
            local guild1 = result.getNumber(resultid, "guild1")
            local guild2 = result.getNumber(resultid, "guild2")
            local frags = result.getNumber(resultid, "fraglimit")
            local cleaned = false
            
            local secondQuery = db.storeQuery("SELECT COUNT(*) as 'count' FROM guildwar_kills WHERE warid = ".. warid .. " and killerguild = ".. guild1)
            if secondQuery then
                local count = result.getNumber(secondQuery, "count")
                if count >= frags then
                    removeAllWarEmblems(guild1, guild2)
                    db.asyncQuery("UPDATE `guild_wars` SET `status` = 4, `ended` = " .. os.time() .. " WHERE id = " .. warid)
                    cleaned = true
                end
                result.free(secondQuery)
            end
            
            if not cleaned then
                secondQuery = db.storeQuery("SELECT COUNT(*) as 'count' FROM guildwar_kills WHERE warid = ".. warid .. " and killerguild = ".. guild2)
                if secondQuery then
                    local count = result.getNumber(secondQuery, "count")
                    if count >= frags then
                        removeAllWarEmblems(guild1, guild2)
                        db.asyncQuery("UPDATE `guild_wars` SET `status` = 4, `ended` = " .. os.time() .. " WHERE id = " .. warid)
                        cleaned = true
                    end
                    result.free(secondQuery)
                end
            end
        until not result.next(resultid)
        result.free(resultid)
    end
    return true
end
warGlobalEvent:interval(5000)
warGlobalEvent:register()

local warLoginEvent = CreatureEvent("warLogin")
function warLoginEvent.onLogin(player)
    addEvent(function()
        if player and player:isPlayer() then
            setWarEmblem(player)
        end
    end, 1000)
    return true
end
warLoginEvent:register()
