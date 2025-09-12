local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local talkState = {}
local guildName = {}
local targetPlayer = {}
local rankName = {}
local nickName = {}

-- Event Guild Settings
local EVENT_GUILD_PRICE = 10000 -- 10k gold to register guild for events
local EVENT_GUILD_NAME_MIN_LENGTH = 3
local EVENT_GUILD_NAME_MAX_LENGTH = 30
local EVENT_GUILD_LEVEL_REQUIREMENT = 50
local EVENT_GUILD_PREMIUM_REQUIRED = true

-- Event Guild status constants
local NONE = 0
local INVITED = 1
local MEMBER = 2
local VICE = 3
local LEADER = 4

local maxnamelen = 30
local maxranklen = 20
local maxnicklen = 20
local leaderlevel = 50
local allow_pattern = '^[a-zA-Z0-9 -]+$'

function onCreatureAppear(cid)
    npcHandler:onCreatureAppear(cid)
end

function onCreatureDisappear(cid)
    npcHandler:onCreatureDisappear(cid)
end

function onCreatureSay(cid, type, msg)
    npcHandler:onCreatureSay(cid, type, msg)
end

function onThink()
    npcHandler:onThink()
end

-- Utility functions for event guilds (separate from regular guilds)
local function getEventGuildStatus(playerName)
    local playerId = getPlayerGUIDByName(playerName)
    if not playerId then
        return NONE
    end
    
    -- Check if player has pending invitation to event guild
    local query = db.storeQuery("SELECT guild_id FROM event_guild_invitations WHERE player_id = " .. playerId)
    if query then
        result.free(query)
        return INVITED
    end
    
    -- Check event guild membership
    query = db.storeQuery(string.format([[
        SELECT egr.level 
        FROM event_guild_membership egm 
        INNER JOIN event_guild_ranks egr ON egm.rank_id = egr.id 
        WHERE egm.player_id = %d
    ]], playerId))
    
    if not query then
        return NONE
    end
    
    local level = result.getNumber(query, "level")
    result.free(query)
    
    if level == 4 then return LEADER
    elseif level == 3 then return VICE
    elseif level == 2 then return MEMBER
    end
    
    return NONE
end

local function getEventGuildName(playerName)
    local playerId = getPlayerGUIDByName(playerName)
    if not playerId then
        return nil
    end
    
    local query = db.storeQuery(string.format([[
        SELECT eg.name 
        FROM event_guild_membership egm 
        INNER JOIN event_guilds eg ON egm.guild_id = eg.id 
        WHERE egm.player_id = %d
    ]], playerId))
    
    if not query then
        return nil
    end
    
    local guildName = result.getString(query, "name")
    result.free(query)
    return guildName
end

local function foundEventGuild(name)
    -- Check if event guild already exists
    local query = db.storeQuery("SELECT id FROM event_guilds WHERE name = " .. db.escapeString(name))
    if query then
        result.free(query)
        return 0 -- Guild already exists
    end
    return 1 -- Guild name available
end

local function createEventGuildForPlayer(cid, name)
    local player = Player(cid)
    local playerId = player:getGuid()
    
    -- Verify player actually owns the guild
    local actualGuild = player:getGuild()
    if not actualGuild or actualGuild:getName() ~= name then
        return false
    end
    
    -- Create event guild in database
    db.query(string.format("INSERT INTO event_guilds (name, ownerid, creationdata) VALUES (%s, %d, %d)",
        db.escapeString(name), playerId, os.time()))
    
    -- Get newly created event guild ID
    local guildId = 0
    local query = db.storeQuery("SELECT id FROM event_guilds WHERE name = " .. db.escapeString(name))
    if query then
        guildId = result.getNumber(query, "id")
        result.free(query)
    else
        return false
    end
    
    -- Create event guild ranks
    db.query(string.format("INSERT INTO event_guild_ranks (guild_id, name, level) VALUES (%d, %s, %d)",
        guildId, db.escapeString("Representante-Lider"), 4))
    db.query(string.format("INSERT INTO event_guild_ranks (guild_id, name, level) VALUES (%d, %s, %d)",
        guildId, db.escapeString("Vice-Representante"), 3))
    db.query(string.format("INSERT INTO event_guild_ranks (guild_id, name, level) VALUES (%d, %s, %d)",
        guildId, db.escapeString("Representante"), 2))
    
    -- Get leader rank ID
    local leaderRankId = 0
    query = db.storeQuery("SELECT id FROM event_guild_ranks WHERE guild_id = " .. guildId .. " AND level = 4")
    if query then
        leaderRankId = result.getNumber(query, "id")
        result.free(query)
    else
        return false
    end
    
    -- Add player as event guild leader
    db.query(string.format("INSERT INTO event_guild_membership (player_id, guild_id, rank_id) VALUES (%d, %d, %d)",
        playerId, guildId, leaderRankId))
    
    return true
end

local function setEventGuildStatus(playerName, status)
    local playerId = getPlayerGUIDByName(playerName)
    if not playerId then
        return false
    end
    
    if status == MEMBER then
        -- Accept invitation
        local query = db.storeQuery("SELECT guild_id FROM event_guild_invitations WHERE player_id = " .. playerId)
        if not query then
            return false
        end
        
        local guildId = result.getNumber(query, "guild_id")
        result.free(query)
        
        -- Get member rank ID
        local rankId = 0
        query = db.storeQuery("SELECT id FROM event_guild_ranks WHERE guild_id = " .. guildId .. " AND level = 2")
        if query then
            rankId = result.getNumber(query, "id")
            result.free(query)
        end
        
        -- Add to event guild
        db.query(string.format("INSERT INTO event_guild_membership (player_id, guild_id, rank_id) VALUES (%d, %d, %d)",
            playerId, guildId, rankId))
        
        -- Remove invitation
        db.query("DELETE FROM event_guild_invitations WHERE player_id = " .. playerId)
        
    elseif status == VICE then
        -- Promote to vice-representative
        local query = db.storeQuery(string.format([[
            SELECT egm.guild_id 
            FROM event_guild_membership egm 
            WHERE egm.player_id = %d
        ]], playerId))
        
        if not query then
            return false
        end
        
        local guildId = result.getNumber(query, "guild_id")
        result.free(query)
        
        -- Get vice rank ID
        local rankId = 0
        query = db.storeQuery("SELECT id FROM event_guild_ranks WHERE guild_id = " .. guildId .. " AND level = 3")
        if query then
            rankId = result.getNumber(query, "id")
            result.free(query)
        end
        
        -- Update rank
        db.query("UPDATE event_guild_membership SET rank_id = " .. rankId .. " WHERE player_id = " .. playerId)
        
    elseif status == LEADER then
        -- Transfer leadership
        local query = db.storeQuery(string.format([[
            SELECT egm.guild_id 
            FROM event_guild_membership egm 
            WHERE egm.player_id = %d
        ]], playerId))
        
        if not query then
            return false
        end
        
        local guildId = result.getNumber(query, "guild_id")
        result.free(query)
        
        -- Get leader rank ID
        local leaderRankId = 0
        query = db.storeQuery("SELECT id FROM event_guild_ranks WHERE guild_id = " .. guildId .. " AND level = 4")
        if query then
            leaderRankId = result.getNumber(query, "id")
            result.free(query)
        end
        
        -- Update rank and guild owner
        db.query("UPDATE event_guild_membership SET rank_id = " .. leaderRankId .. " WHERE player_id = " .. playerId)
        db.query("UPDATE event_guilds SET ownerid = " .. playerId .. " WHERE id = " .. guildId)
    end
    
    return true
end

local function setEventPlayerGuild(playerName, status, rank, guildName)
    local playerId = getPlayerGUIDByName(playerName)
    if not playerId then
        return false
    end
    
    if status == INVITED then
        -- Get event guild ID
        local query = db.storeQuery("SELECT id FROM event_guilds WHERE name = " .. db.escapeString(guildName))
        if not query then
            return false
        end
        
        local guildId = result.getNumber(query, "id")
        result.free(query)
        
        -- Create invitation
        db.query(string.format("INSERT INTO event_guild_invitations (player_id, guild_id, rank_name) VALUES (%d, %d, %s)",
            playerId, guildId, db.escapeString(rank)))
        
        -- Notify player if online
        local targetPlayer = Player(playerName)
        if targetPlayer then
            targetPlayer:sendTextMessage(MESSAGE_INFO_DESCR,
                string.format("Voce foi convidado para representar a guilda '%s' nos eventos. Visite o registrador para aceitar.", guildName))
        end
    end
    
    return true
end

local function clearEventPlayerGuild(playerName)
    local playerId = getPlayerGUIDByName(playerName)
    if not playerId then
        return false
    end
    
    -- Remove from event guild
    db.query("DELETE FROM event_guild_membership WHERE player_id = " .. playerId)
    -- Remove any pending invitations
    db.query("DELETE FROM event_guild_invitations WHERE player_id = " .. playerId)
    
    return true
end

local function setEventPlayerGuildNick(playerName, nick)
    local playerId = getPlayerGUIDByName(playerName)
    if not playerId then
        return false
    end
    
    -- Update nickname
    db.query("UPDATE event_guild_membership SET nick = " .. db.escapeString(nick) .. " WHERE player_id = " .. playerId)
    
    -- Notify player if online
    local targetPlayer = Player(playerName)
    if targetPlayer then
        if nick == "" then
            targetPlayer:sendTextMessage(MESSAGE_INFO_DESCR, "Seu apelido de evento foi removido.")
        else
            targetPlayer:sendTextMessage(MESSAGE_INFO_DESCR, 
                string.format("Seu apelido de evento foi definido como '%s'.", nick))
        end
    end
    
    return true
end

-- Main dialog
function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    local cname = player:getName()
    msg = msg:lower()
    
    -- Initialize talkState if needed
    if not talkState[cid] then
        talkState[cid] = 0
    end
    
    if msgcontains(msg, 'ajuda') then
        npcHandler:say('Para inscrever sua guilda diga "inscrever", para invitar um representante diga "representante", para representar uma guilda diga "representar", para excluir algum representante diga "excluir"...', cid)
        npcHandler:say('Para passar a liderança diga "passar", para escolher um vice-representante diga "vice", para rebaixar algum vice diga "rebaixar" e para parar de representar a guilda diga "sair".', cid)
        talkState[cid] = 0
        
    elseif talkState[cid] == 0 then
        if msgcontains(msg, 'inscrever') then
            local level = player:getLevel()
            if level >= leaderlevel then
                if player:isPremium() then
                    local gstat = getEventGuildStatus(cname)
                    if gstat == NONE or gstat == INVITED then
                        npcHandler:say('Qual o nome de sua guilda que deseja inscrever?', cid)
                        talkState[cid] = 1
                    else
                        npcHandler:say('Desculpe, mas sua guild ja esta inscrita. Diga "sair" para desinscrever a sua guilda atual.', cid)
                    end
                else
                    npcHandler:say('Desculpe, mas somente lideres de guildas premium podem inscrever a guilda.', cid)
                end
            else
                npcHandler:say('Desculpe, mas somente lideres de guildas podem inscrever a guilda.', cid)
            end
            
        elseif msgcontains(msg, 'representar') then -- join when invited
            local gstat = getEventGuildStatus(cname)
            if gstat == NONE then
                npcHandler:say('Desculpe, mas não estou sabendo que voce vai representar alguma guilda. Peça para seu lider coloca-lo como representante.', cid)
            elseif gstat == INVITED then
                local gname = getEventGuildName(cname)
                npcHandler:say('Voce aceita representar a guilda ' .. gname .. ' nos eventos?', cid)
                talkState[cid] = 3
            else
                npcHandler:say('Desculpe, voce já é um representante da Guilda.', cid)
            end
            
        elseif msgcontains(msg, 'excluir') or msgcontains(msg, 'chutar') then -- kick representative
            local gstat = getEventGuildStatus(cname)
            if gstat == VICE or gstat == LEADER then
                npcHandler:say('Qual representante da guilda voce deseja excluir?', cid)
                talkState[cid] = 4
            else
                npcHandler:say('Desculpe, somente o lider ou vice-lider, pode excluir um representante.', cid)
            end
            
        elseif msgcontains(msg, 'representante') then -- invite representative
            local gstat = getEventGuildStatus(cname)
            if gstat == VICE or gstat == LEADER then
                npcHandler:say('Quem voce deseja colocar como representante da guilda?', cid)
                talkState[cid] = 5
            else
                npcHandler:say('Desculpe, somente o lider ou vice-lider, pode invitar um representante.', cid)
            end
            
        elseif msgcontains(msg, 'sair') then -- leave event guild
            local gstat = getEventGuildStatus(cname)
            if gstat == NONE or gstat == INVITED then
                npcHandler:say('Voce não esta representando nenhuma guilda.', cid)
            elseif gstat == MEMBER or gstat == VICE then
                local gname = getEventGuildName(cname)
                npcHandler:say('Voce deseja parar de representar a guilda ' .. gname .. ' nos eventos?', cid)
                talkState[cid] = 7
            elseif gstat == LEADER then
                npcHandler:say('Voce é o lider da guilda, se voce sair, ninguem mais podera representar sua guilda, utilizando o "passar" voce pode passar sua guilda para outra pessoa, tem certeza que deseja sair?', cid)
                talkState[cid] = 7
            end
            
        elseif msgcontains(msg, 'passar') then -- pass leadership
            local gstat = getEventGuildStatus(cname)
            if gstat == LEADER then
                npcHandler:say('Quem voce quer que seja o principal representante da guilda?', cid)
                talkState[cid] = 8
            else
                npcHandler:say('Desculpe, mas somente liders podem passar a liderança.', cid)
            end
            
        elseif msgcontains(msg, 'vice') then -- set vice leader
            local gstat = getEventGuildStatus(cname)
            if gstat == LEADER then
                npcHandler:say('Qual representante voce gostaria de passar para vice-representante?', cid)
                talkState[cid] = 9
            else
                npcHandler:say('Desculpe, apenas liders podem promover a vice-representante.', cid)
            end
            
        elseif msgcontains(msg, 'rebaixar') then -- remove vice-leader
            local gstat = getEventGuildStatus(cname)
            if gstat == LEADER then
                npcHandler:say('Qual vice-representante voce gostaria de rebaixar a representante?', cid)
                talkState[cid] = 10
            else
                npcHandler:say('Desculpe, apenas liders podem rebaixar um vice-representante.', cid)
            end
        end
        
    else -- talkState != 0
        if talkState[cid] == 1 then -- get name of event guild
            local gname = msg
            if string.len(gname) <= maxnamelen then
                if string.match(gname, allow_pattern) then
                    if player:removeMoney(EVENT_GUILD_PRICE) then
                        if foundEventGuild(gname) >= 1 then
                            if createEventGuildForPlayer(cid, gname) then
                                npcHandler:say('Parabens, sua guilda foi inscrita com sucesso.', cid)
                            else
                                npcHandler:say('Desculpe, mas essa guilda não é sua.', cid)
                                player:addMoney(EVENT_GUILD_PRICE) -- Refund
                            end
                        else
                            npcHandler:say('Desculpe, mas essa guilda ja esta inscrita, se voce e o dono dela e não foi voce que inscreveu, Contate o GM.', cid)
                            player:addMoney(EVENT_GUILD_PRICE) -- Refund
                        end
                    else
                        npcHandler:say('Desculpe, mas voce não tem o dinheiro da inscrição.', cid)
                    end
                else
                    npcHandler:say('Desculpe, mas esta guilda contém caracteres inválidos.', cid)
                end
            else
                npcHandler:say('Desculpe, nome muito longo.', cid)
            end
            talkState[cid] = 0
            
        elseif talkState[cid] == 3 then -- join event guild
            if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
                if setEventGuildStatus(cname, MEMBER) then
                    npcHandler:say('Parabens, voce é agora um representante da guilda.', cid)
                else
                    npcHandler:say('Erro ao aceitar convite.', cid)
                end
            else
                npcHandler:say('O que posso fazer por voce?', cid)
            end
            talkState[cid] = 0
            
        elseif talkState[cid] == 4 then -- kick representative
            local pname = msg
            local gname = getEventGuildName(cname)
            local gname2 = getEventGuildName(pname)
            if cname == pname then
                npcHandler:say('Para excluir voce mesmo, diga "sair".', cid)
            elseif gname == gname2 then
                local gstat = getEventGuildStatus(cname)
                local gstat2 = getEventGuildStatus(pname)
                if gstat > gstat2 then
                    if clearEventPlayerGuild(pname) then
                        npcHandler:say('Voce excluiu o representante ' .. pname .. ' de sua guilda.', cid)
                    else
                        npcHandler:say('Erro ao excluir representante.', cid)
                    end
                else
                    npcHandler:say('Apenas liders e vices podem excluir um representante.', cid)
                end
            else
                npcHandler:say('Desculpe, ' .. pname .. ' não é um representante da guilda.', cid)
            end
            talkState[cid] = 0
            
        elseif talkState[cid] == 5 then -- get representative name to invite
            local pname = msg
            local gstat = getEventGuildStatus(pname)
            if gstat == MEMBER or gstat == VICE or gstat == LEADER then
                npcHandler:say('Desculpe, ' .. pname .. ' é representante de outra guilda.', cid)
                talkState[cid] = 0
            else
                targetPlayer[cid] = pname
                npcHandler:say('Deseja invitar ' .. pname .. ' como representante da guilda?', cid)
                talkState[cid] = 6
            end
            
        elseif talkState[cid] == 6 then -- confirm invitation
            if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
                local gname = getEventGuildName(cname)
                if setEventPlayerGuild(targetPlayer[cid], INVITED, "Representante", gname) then
                    npcHandler:say('Voce invitou ' .. targetPlayer[cid] .. ' como representante da guilda.', cid)
                else
                    npcHandler:say('Erro ao enviar convite.', cid)
                end
            else
                npcHandler:say('Convite cancelado.', cid)
            end
            talkState[cid] = 0
            
        elseif talkState[cid] == 7 then -- leave event guild
            if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
                if clearEventPlayerGuild(cname) then
                    npcHandler:say('Voce não é mais representante da guilda.', cid)
                else
                    npcHandler:say('Erro ao sair da guilda.', cid)
                end
            else
                npcHandler:say('Oque posso fazer por voce?', cid)
            end
            talkState[cid] = 0
            
        elseif talkState[cid] == 8 then -- pass leadership
            local pname = msg
            local targetPlayer = Player(pname)
            if targetPlayer and targetPlayer:getLevel() >= leaderlevel then
                local gname = getEventGuildName(cname)
                local gname2 = getEventGuildName(pname)
                if gname == gname2 then
                    -- Demote current leader to member
                    setEventGuildStatus(cname, MEMBER)
                    -- Promote target to leader
                    setEventGuildStatus(pname, LEADER)
                    npcHandler:say(pname .. ' é o novo Lider-Representante de ' .. gname .. '.', cid)
                else
                    npcHandler:say('Desculpe, ' .. pname .. ' não é um representante.', cid)
                end
            else
                npcHandler:say('Desculpe, ' .. pname .. ' não esta online.', cid)
            end
            talkState[cid] = 0
            
        elseif talkState[cid] == 9 then -- set vice-leader
            local pname = msg
            local gname = getEventGuildName(cname)
            local gname2 = getEventGuildName(pname)
            if cname == pname then
                npcHandler:say('Para passar o lider representante diga "passar".', cid)
            elseif gname == gname2 then
                local gstat = getEventGuildStatus(pname)
                if gstat == INVITED then
                    npcHandler:say('Desculpe, ' .. pname .. ' não aceitou ser representante ainda.', cid)
                elseif gstat == VICE then
                    npcHandler:say(pname .. ' já é um vice-representante.', cid)
                elseif gstat == MEMBER then
                    if setEventGuildStatus(pname, VICE) then
                        npcHandler:say(pname .. ' é agora um vice-representante da guilda.', cid)
                    else
                        npcHandler:say('Erro ao promover representante.', cid)
                    end
                end
            else
                npcHandler:say('Desculpe, ' .. pname .. ' não é um representante.', cid)
            end
            talkState[cid] = 0
            
        elseif talkState[cid] == 10 then -- set member (demote vice)
            local pname = msg
            local gname = getEventGuildName(cname)
            local gname2 = getEventGuildName(pname)
            if cname == pname then
                npcHandler:say('Para passar o lider representante diga "passar".', cid)
            elseif gname == gname2 then
                local gstat = getEventGuildStatus(pname)
                if gstat == INVITED then
                    npcHandler:say('Desculpe, ' .. pname .. ' não aceitou ser representante ainda.', cid)
                elseif gstat == VICE then
                    if setEventGuildStatus(pname, MEMBER) then
                        npcHandler:say(pname .. ' é agora apenas um representante da guilda.', cid)
                    else
                        npcHandler:say('Erro ao rebaixar vice-representante.', cid)
                    end
                elseif gstat == MEMBER then
                    npcHandler:say(pname .. ' já é apenas um representante.', cid)
                end
            else
                npcHandler:say('Desculpe, ' .. pname .. ' não é um vice-representante.', cid)
            end
            talkState[cid] = 0
        end
    end
    
    return true
end

-- Greet message
npcHandler:setMessage(MESSAGE_GREET, 'Ola |PLAYERNAME|! Sou responsavel pelas inscrições das guildas participantes de eventos e inscrições de representantes das guildas, preço de inscrição por guilda 10k, diga "ajuda" se houver alguma duvida!')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Adeus, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Adeus então.')
npcHandler:setMessage(MESSAGE_DECLINE, 'Sorry, |PLAYERNAME|! I talk to you in a minute.')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
