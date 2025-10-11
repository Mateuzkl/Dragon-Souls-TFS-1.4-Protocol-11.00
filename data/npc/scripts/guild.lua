local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local talkState = {}
local guildName = {}
local targetPlayer = {}

-- Guild Settings
local GUILD_CREATION_PRICE = 0
local GUILD_NAME_MIN_LENGTH = 3
local GUILD_NAME_MAX_LENGTH = 30
local GUILD_INVITATION_EXPIRE_TIME = 86400
local GUILD_CREATION_LEVEL_REQUIREMENT = 50
local GUILD_CREATION_PREMIUM_REQUIRED = false
local GUILD_DEFAULT_LEVEL = 1

-- Guild status constants
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

-- Utility functions
local function hasGuild(cid)
    local player = Player(cid)
    return player:getGuild() ~= nil
end

local function getGuildRank(cid)
    local player = Player(cid)
    if not player:getGuild() then
        return 0
    end
    return player:getGuildLevel()
end

local function getPlayerGuildStatus(playerName)
    local playerId = getPlayerGUIDByName(playerName)
    if not playerId then
        return NONE
    end
    
    local query = db.storeQuery(string.format("SELECT guild_id FROM guild_invitations WHERE player_id = %d AND expiration > %d", playerId, os.time()))
    if query then
        result.free(query)
        return INVITED
    end
    
    query = db.storeQuery(string.format([[
        SELECT gr.level 
        FROM guild_membership gm 
        INNER JOIN guild_ranks gr ON gm.rank_id = gr.id 
        WHERE gm.player_id = %d
    ]], playerId))
    
    if not query then
        return NONE
    end
    
    local level = result.getNumber(query, "level")
    result.free(query)
    
    if level == 3 then return LEADER
    elseif level == 2 then return VICE
    elseif level == 1 then return MEMBER
    end
    
    return NONE
end

local function getPlayerGuildName(playerName)
    local playerId = getPlayerGUIDByName(playerName)
    if not playerId then
        return nil
    end
    
    local query = db.storeQuery(string.format([[
        SELECT g.name 
        FROM guild_membership gm 
        INNER JOIN guilds g ON gm.guild_id = g.id 
        WHERE gm.player_id = %d
    ]], playerId))
    
    if not query then
        return nil
    end
    
    local guildName = result.getString(query, "name")
    result.free(query)
    return guildName
end

local function getInvitedGuildName(playerName)
    local playerId = getPlayerGUIDByName(playerName)
    if not playerId then
        return nil
    end
    
    local query = db.storeQuery(string.format([[
        SELECT g.name 
        FROM guild_invitations gi 
        INNER JOIN guilds g ON gi.guild_id = g.id 
        WHERE gi.player_id = %d AND gi.expiration > %d
    ]], playerId, os.time()))
    
    if not query then
        return nil
    end
    
    local guildName = result.getString(query, "name")
    result.free(query)
    return guildName
end

local function foundNewGuild(name)
    local query = db.storeQuery("SELECT id FROM guilds WHERE name = " .. db.escapeString(name))
    if query then
        result.free(query)
        return 0
    end
    return 1
end

local function getGuildMemberCount(guildId)
    local query = db.storeQuery("SELECT COUNT(*) as total FROM guild_membership WHERE guild_id = " .. guildId)
    if not query then
        return 0
    end
    local count = result.getNumber(query, "total")
    result.free(query)
    return count
end

local function getGuildMembers(guildName)
    -- Get guild ID
    local query = db.storeQuery("SELECT id FROM guilds WHERE name = " .. db.escapeString(guildName))
    if not query then
        return nil
    end
    local guildId = result.getNumber(query, "id")
    result.free(query)
    
    -- Get all members
    local members = {
        leaders = {},
        vices = {},
        members = {}
    }
    
    query = db.storeQuery(string.format([[
        SELECT p.name, gr.level, gr.name as rank_name, gm.nick
        FROM guild_membership gm 
        INNER JOIN players p ON gm.player_id = p.id 
        INNER JOIN guild_ranks gr ON gm.rank_id = gr.id 
        WHERE gm.guild_id = %d
        ORDER BY gr.level DESC, p.name ASC
    ]], guildId))
    
    if query then
        repeat
            local memberInfo = {
                name = result.getString(query, "name"),
                rank = result.getString(query, "rank_name"),
                nick = result.getString(query, "nick"),
                level = result.getNumber(query, "level")
            }
            
            if memberInfo.level == 3 then
                table.insert(members.leaders, memberInfo)
            elseif memberInfo.level == 2 then
                table.insert(members.vices, memberInfo)
            else
                table.insert(members.members, memberInfo)
            end
        until not result.next(query)
        result.free(query)
    end
    
    return members
end

local function deleteGuild(guildId)
    db.query("DELETE FROM guild_invitations WHERE guild_id = " .. guildId)
    db.query("DELETE FROM guild_membership WHERE guild_id = " .. guildId)
    db.query("DELETE FROM guild_ranks WHERE guild_id = " .. guildId)
    db.query("DELETE FROM guilds WHERE id = " .. guildId)
    return true
end

local function createGuildForPlayer(cid, name)
    local player = Player(cid)
    local playerId = player:getGuid()
    
    local check = db.storeQuery("SELECT 1 FROM guild_membership WHERE player_id = " .. playerId .. " LIMIT 1")
    if check then
        result.free(check)
        return false
    end
    
    check = db.storeQuery("SELECT id FROM guilds WHERE ownerid = " .. playerId .. " LIMIT 1")
    if check then
        result.free(check)
        return false
    end
    
    db.query(string.format("INSERT INTO guilds (name, ownerid, creationdata, points, level, residence, description) VALUES (%s, %d, %d, %d, %d, %d, %s)",
        db.escapeString(name), playerId, os.time(), 0, GUILD_DEFAULT_LEVEL, 0, db.escapeString("")))
    
    local guildId = 0
    local query = db.storeQuery("SELECT id FROM guilds WHERE name = " .. db.escapeString(name))
    if query then
        guildId = result.getNumber(query, "id")
        result.free(query)
    else
        return false
    end
    
    db.query(string.format("INSERT INTO guild_ranks (guild_id, name, level) VALUES (%d, %s, %d)",
        guildId, db.escapeString("Leader"), 3))
    db.query(string.format("INSERT INTO guild_ranks (guild_id, name, level) VALUES (%d, %s, %d)",
        guildId, db.escapeString("Vice-Leader"), 2))
    db.query(string.format("INSERT INTO guild_ranks (guild_id, name, level) VALUES (%d, %s, %d)",
        guildId, db.escapeString("Member"), 1))
    
    local leaderRankId = 0
    query = db.storeQuery("SELECT id FROM guild_ranks WHERE guild_id = " .. guildId .. " AND level = 3")
    if query then
        leaderRankId = result.getNumber(query, "id")
        result.free(query)
    else
        return false
    end
    
    db.query(string.format("INSERT INTO guild_membership (player_id, guild_id, rank_id) VALUES (%d, %d, %d)",
        playerId, guildId, leaderRankId))
    
    return true
end

local function setPlayerGuildStatus(playerName, status)
    local playerId = getPlayerGUIDByName(playerName)
    if not playerId then
        return false
    end
    
    if status == MEMBER then
        local query = db.storeQuery(string.format("SELECT guild_id FROM guild_invitations WHERE player_id = %d AND expiration > %d", playerId, os.time()))
        if not query then
            return false
        end
        
        local guildId = result.getNumber(query, "guild_id")
        result.free(query)
        
        local rankId = 0
        query = db.storeQuery("SELECT id FROM guild_ranks WHERE guild_id = " .. guildId .. " AND level = 1")
        if query then
            rankId = result.getNumber(query, "id")
            result.free(query)
        end
        
        db.query(string.format("INSERT INTO guild_membership (player_id, guild_id, rank_id) VALUES (%d, %d, %d)",
            playerId, guildId, rankId))
        
        db.query(string.format("DELETE FROM guild_invitations WHERE player_id = %d", playerId))
        
    elseif status == VICE then
        local query = db.storeQuery(string.format([[
            SELECT gm.guild_id 
            FROM guild_membership gm 
            WHERE gm.player_id = %d
        ]], playerId))
        
        if not query then
            return false
        end
        
        local guildId = result.getNumber(query, "guild_id")
        result.free(query)
        
        local rankId = 0
        query = db.storeQuery("SELECT id FROM guild_ranks WHERE guild_id = " .. guildId .. " AND level = 2")
        if query then
            rankId = result.getNumber(query, "id")
            result.free(query)
        end
        
        db.query("UPDATE guild_membership SET rank_id = " .. rankId .. " WHERE player_id = " .. playerId)
        
    elseif status == LEADER then
        local query = db.storeQuery(string.format([[
            SELECT gm.guild_id 
            FROM guild_membership gm 
            WHERE gm.player_id = %d
        ]], playerId))
        
        if not query then
            return false
        end
        
        local guildId = result.getNumber(query, "guild_id")
        result.free(query)
        
        local leaderRankId = 0
        query = db.storeQuery("SELECT id FROM guild_ranks WHERE guild_id = " .. guildId .. " AND level = 3")
        if query then
            leaderRankId = result.getNumber(query, "id")
            result.free(query)
        end
        
        db.query("UPDATE guild_membership SET rank_id = " .. leaderRankId .. " WHERE player_id = " .. playerId)
        db.query("UPDATE guilds SET ownerid = " .. playerId .. " WHERE id = " .. guildId)
    end
    
    return true
end

local function setPlayerGuild(playerName, status, rank, guildName)
    local playerId = getPlayerGUIDByName(playerName)
    if not playerId then
        return false
    end
    
    if status == INVITED then
        local query = db.storeQuery("SELECT id FROM guilds WHERE name = " .. db.escapeString(guildName))
        if not query then
            return false
        end
        
        local guildId = result.getNumber(query, "id")
        result.free(query)
        
        local expirationTime = os.time() + GUILD_INVITATION_EXPIRE_TIME
        db.query(string.format("INSERT INTO guild_invitations (player_id, guild_id, expiration, rank_name) VALUES (%d, %d, %d, %s)",
            playerId, guildId, expirationTime, db.escapeString(rank)))
        
        local targetPlayer = Player(playerName)
        if targetPlayer then
            targetPlayer:sendTextMessage(MESSAGE_INFO_DESCR,
                string.format("Você foi convidado para se juntar à guilda '%s' com o cargo '%s'. Visite o Gerente de Guildas para aceitar ou recusar.", guildName, rank))
        end
    end
    
    return true
end

local function clearPlayerGuild(playerName)
    local playerId = getPlayerGUIDByName(playerName)
    if not playerId then
        return false
    end
    
    db.query("DELETE FROM guild_membership WHERE player_id = " .. playerId)
    db.query("DELETE FROM guild_invitations WHERE player_id = " .. playerId)
    
    return true
end

local function setPlayerGuildNick(playerName, nick)
    local playerId = getPlayerGUIDByName(playerName)
    if not playerId then
        return false
    end
    
    db.query("UPDATE guild_membership SET nick = " .. db.escapeString(nick) .. " WHERE player_id = " .. playerId)
    
    local targetPlayer = Player(playerName)
    if targetPlayer then
        if nick == "" then
            targetPlayer:sendTextMessage(MESSAGE_INFO_DESCR, "Seu apelido de guilda foi removido.")
        else
            targetPlayer:sendTextMessage(MESSAGE_INFO_DESCR, 
                string.format("Seu apelido de guilda foi definido como '%s'.", nick))
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
    
    if not talkState[cid] then
        talkState[cid] = 0
    end
    
    if talkState[cid] == 0 then
        if msgcontains(msg, 'ajuda') or msgcontains(msg, 'help') or msgcontains(msg, 'comandos') then
            local helpText = "========== SISTEMA DE GUILDAS ==========\n\n"
            helpText = helpText .. "COMANDOS DISPONÍVEIS:\n\n"
            helpText = helpText .. "[CRIAR GUILDA]\n"
            helpText = helpText .. "- fundar ou criar: Criar uma nova guilda\n"
            helpText = helpText .. "- Requer nível " .. leaderlevel .. "\n\n"
            helpText = helpText .. "[GERENCIAR MEMBROS]\n"
            helpText = helpText .. "- convidar: Convidar um jogador\n"
            helpText = helpText .. "- expulsar/kickar/remover: Expulsar um membro\n"
            helpText = helpText .. "- entrar/aceitar: Aceitar convite de guilda\n"
            helpText = helpText .. "- sair: Sair da sua guilda\n\n"
            helpText = helpText .. "[GERENCIAR CARGOS]\n"
            helpText = helpText .. "- vice/promover: Promover membro a vice-líder\n"
            helpText = helpText .. "- membro/rebaixar: Rebaixar vice para membro\n"
            helpText = helpText .. "- passar/transferir: Transferir liderança\n"
            helpText = helpText .. "- apelido/titulo/nick: Alterar apelido de membro\n\n"
            helpText = helpText .. "[INFORMAÇÕES]\n"
            helpText = helpText .. "- membros/lista: Ver lista de membros da guilda\n"
            helpText = helpText .. "- info: Ver informações da sua guilda\n\n"
            helpText = helpText .. "Diga o comando desejado para começar!"
            
            player:popupFYI(helpText)
            npcHandler:say('Abri uma janela com todos os comandos disponíveis!', cid)
            talkState[cid] = 0
            
        elseif msgcontains(msg, 'membros') or msgcontains(msg, 'lista') or msgcontains(msg, 'members') then
            local gstat = getPlayerGuildStatus(cname)
            if gstat == NONE or gstat == INVITED then
                npcHandler:say('Você não está em nenhuma guilda.', cid)
                talkState[cid] = 0
            else
                local gname = getPlayerGuildName(cname)
                local members = getGuildMembers(gname)
                
                if members then
                    local memberText = "========== MEMBROS DA GUILDA ==========\n\n"
                    memberText = memberText .. "Guilda: " .. gname .. "\n\n"
                    
                    -- Leaders
                    if #members.leaders > 0 then
                        memberText = memberText .. "=== LÍDERES ===\n"
                        for _, m in ipairs(members.leaders) do
                            memberText = memberText .. "• " .. m.name
                            if m.nick and m.nick ~= "" then
                                memberText = memberText .. " (" .. m.nick .. ")"
                            end
                            memberText = memberText .. " - " .. m.rank .. "\n"
                        end
                        memberText = memberText .. "\n"
                    end
                    
                    -- Vice-Leaders
                    if #members.vices > 0 then
                        memberText = memberText .. "=== VICE-LÍDERES ===\n"
                        for _, m in ipairs(members.vices) do
                            memberText = memberText .. "• " .. m.name
                            if m.nick and m.nick ~= "" then
                                memberText = memberText .. " (" .. m.nick .. ")"
                            end
                            memberText = memberText .. " - " .. m.rank .. "\n"
                        end
                        memberText = memberText .. "\n"
                    end
                    
                    -- Members
                    if #members.members > 0 then
                        memberText = memberText .. "=== MEMBROS ===\n"
                        for _, m in ipairs(members.members) do
                            memberText = memberText .. "• " .. m.name
                            if m.nick and m.nick ~= "" then
                                memberText = memberText .. " (" .. m.nick .. ")"
                            end
                            memberText = memberText .. " - " .. m.rank .. "\n"
                        end
                    end
                    
                    local totalMembers = #members.leaders + #members.vices + #members.members
                    memberText = memberText .. "\nTotal de membros: " .. totalMembers
                    
                    player:popupFYI(memberText)
                    npcHandler:say('Abri uma janela com a lista de membros da guilda!', cid)
                else
                    npcHandler:say('Não foi possível carregar os membros da guilda.', cid)
                end
                talkState[cid] = 0
            end
            
        elseif msgcontains(msg, 'info') or msgcontains(msg, 'informacao') then
            local gstat = getPlayerGuildStatus(cname)
            if gstat == NONE then
                npcHandler:say('Você não está em nenhuma guilda.', cid)
                talkState[cid] = 0
            elseif gstat == INVITED then
                local gname = getInvitedGuildName(cname)
                npcHandler:say('Você foi convidado para a guilda: ' .. gname .. '. Diga "entrar" para aceitar.', cid)
                talkState[cid] = 0
            else
                local gname = getPlayerGuildName(cname)
                local rankText = ""
                if gstat == LEADER then
                    rankText = "Líder"
                elseif gstat == VICE then
                    rankText = "Vice-Líder"
                else
                    rankText = "Membro"
                end
                
                local infoText = "========== INFORMAÇÕES DA GUILDA ==========\n\n"
                infoText = infoText .. "Nome da Guilda: " .. gname .. "\n"
                infoText = infoText .. "Seu Cargo: " .. rankText .. "\n\n"
                infoText = infoText .. "Use o comando 'membros' ou 'lista' para ver todos os membros!"
                
                player:popupFYI(infoText)
                npcHandler:say('Abri uma janela com as informações da sua guilda!', cid)
                talkState[cid] = 0
            end
            
        elseif msgcontains(msg, 'fundar') or msgcontains(msg, 'criar') then
            local level = player:getLevel()
            if level >= leaderlevel then
                local gstat = getPlayerGuildStatus(cname)
                if gstat == NONE or gstat == INVITED then
                    npcHandler:say('Qual nome a sua guilda deve ter?', cid)
                    talkState[cid] = 1
                elseif gstat == MEMBER or gstat == VICE or gstat == LEADER then
                    npcHandler:say('Desculpe, você já é membro de uma guilda.', cid)
                    talkState[cid] = 0
                end
            else
                npcHandler:say('Desculpe, você precisa de nível ' .. leaderlevel .. ' para fundar uma guilda.', cid)
            end
            
        elseif msgcontains(msg, 'entrar') or msgcontains(msg, 'aceitar') then
            local gstat = getPlayerGuildStatus(cname)
            if gstat == NONE then
                npcHandler:say('Desculpe, você não foi convidado para nenhuma guilda.', cid)
                talkState[cid] = 0
            elseif gstat == INVITED then
                local gname = getInvitedGuildName(cname)
                if gname then
                    npcHandler:say('Você deseja entrar na guilda ' .. gname .. '?', cid)
                    talkState[cid] = 3
                else
                    npcHandler:say('Desculpe, houve um erro ao encontrar seu convite de guilda.', cid)
                    talkState[cid] = 0
                end
            elseif gstat == MEMBER or gstat == VICE or gstat == LEADER then
                npcHandler:say('Desculpe, você já é membro de uma guilda.', cid)
                talkState[cid] = 0
            end
            
        elseif msgcontains(msg, 'expulsar') or msgcontains(msg, 'kickar') or msgcontains(msg, 'remover') then
            local gstat = getPlayerGuildStatus(cname)
            if gstat == VICE or gstat == LEADER then
                npcHandler:say('Quem você deseja expulsar?', cid)
                talkState[cid] = 4
            else
                npcHandler:say('Desculpe, apenas líderes e vice-líderes podem expulsar jogadores da guilda.', cid)
                talkState[cid] = 0
            end
            
        elseif msgcontains(msg, 'convidar') then
            local gstat = getPlayerGuildStatus(cname)
            if gstat == VICE or gstat == LEADER then
                npcHandler:say('Quem você deseja convidar para sua guilda?', cid)
                talkState[cid] = 5
            else
                npcHandler:say('Desculpe, apenas líderes e vice-líderes podem convidar jogadores para a guilda.', cid)
                talkState[cid] = 0
            end
            
        elseif msgcontains(msg, 'sair') then
            local gstat = getPlayerGuildStatus(cname)
            if gstat == NONE or gstat == INVITED then
                npcHandler:say('Você não está em nenhuma guilda.', cid)
                talkState[cid] = 0
            elseif gstat == MEMBER or gstat == VICE then
                local gname = getPlayerGuildName(cname)
                npcHandler:say('Você deseja sair da guilda ' .. gname .. '?', cid)
                talkState[cid] = 7
            elseif gstat == LEADER then
                npcHandler:say('Você é o líder da guilda. Deseja transferir a liderança para outro membro ou deletar completamente a guilda?', cid)
                talkState[cid] = 13
            end
            
        elseif msgcontains(msg, 'passar') or msgcontains(msg, 'transferir') then
            local gstat = getPlayerGuildStatus(cname)
            if gstat == LEADER then
                npcHandler:say('Quem você deseja que seja o novo líder?', cid)
                talkState[cid] = 8
            else
                npcHandler:say('Desculpe, apenas o líder pode renunciar sua posição.', cid)
                talkState[cid] = 0
            end
            
        elseif msgcontains(msg, 'vice') or msgcontains(msg, 'promover') then
            local gstat = getPlayerGuildStatus(cname)
            if gstat == LEADER then
                npcHandler:say('Qual membro você deseja promover a vice-líder?', cid)
                talkState[cid] = 9
            else
                npcHandler:say('Desculpe, apenas o líder pode promover membros a vice-líder.', cid)
                talkState[cid] = 0
            end
            
        elseif msgcontains(msg, 'membro') or msgcontains(msg, 'rebaixar') then
            local gstat = getPlayerGuildStatus(cname)
            if gstat == LEADER then
                npcHandler:say('Qual vice-líder você deseja rebaixar para membro comum?', cid)
                talkState[cid] = 10
            else
                npcHandler:say('Desculpe, apenas o líder pode rebaixar vice-líderes a membros.', cid)
                talkState[cid] = 0
            end
            
        elseif msgcontains(msg, 'apelido') or msgcontains(msg, 'titulo') or msgcontains(msg, 'nick') then
            local gstat = getPlayerGuildStatus(cname)
            if gstat == LEADER then
                npcHandler:say('De qual jogador você deseja alterar o apelido?', cid)
                talkState[cid] = 11
            else
                npcHandler:say('Desculpe, apenas o líder pode alterar apelidos.', cid)
                talkState[cid] = 0
            end
        end
        
    else
        if talkState[cid] == 1 then
            local gname = msg
            if string.len(gname) <= maxnamelen then
                if string.find(gname, allow_pattern) then
                    if foundNewGuild(gname) == 0 then
                        npcHandler:say('Desculpe, já existe uma guilda com este nome.', cid)
                        talkState[cid] = 0
                    else
                        local player2 = Player(cid)
                        local playerId = player2:getGuid()
                        local q = db.storeQuery("SELECT 1 FROM guild_membership WHERE player_id = " .. playerId .. " LIMIT 1")
                        if q then
                            result.free(q)
                            npcHandler:say('Desculpe, você já está em uma guilda. Saia dela antes de criar outra.', cid)
                            talkState[cid] = 0
                        else
                            q = db.storeQuery("SELECT id FROM guilds WHERE ownerid = " .. playerId .. " LIMIT 1")
                            if q then
                                result.free(q)
                                npcHandler:say('Desculpe, você já é líder de uma guilda. Saia dela antes de criar outra.', cid)
                                talkState[cid] = 0
                            else
                                if createGuildForPlayer(cid, gname) then
                                    npcHandler:say('Parabéns! Você agora é o líder da guilda ' .. gname .. '!', cid)
                                else
                                    npcHandler:say('Houve um erro ao criar sua guilda.', cid)
                                end
                                talkState[cid] = 0
                            end
                        end
                    end
                else
                    npcHandler:say('Desculpe, o nome da guilda contém caracteres ilegais.', cid)
                    talkState[cid] = 0
                end
            else
                npcHandler:say('Desculpe, o nome da guilda não pode ter mais de ' .. maxnamelen .. ' caracteres.', cid)
                talkState[cid] = 0
            end
            
        elseif talkState[cid] == 3 then
            if msgcontains(msg, 'sim') or msgcontains(msg, 'yes') then
                if setPlayerGuildStatus(cname, MEMBER) then
                    npcHandler:say('Você agora é membro de uma guilda.', cid)
                else
                    npcHandler:say('Houve um erro ao entrar na guilda.', cid)
                end
                talkState[cid] = 0
            else
                npcHandler:say('O que mais posso fazer por você?', cid)
                talkState[cid] = 0
            end
            
        elseif talkState[cid] == 4 then
            local pname = msg
            local gname = getPlayerGuildName(cname)
            local gname2 = getPlayerGuildName(pname)
            if cname == pname then
                npcHandler:say('Para sair da guilda, diga sair.', cid)
                talkState[cid] = 0
            elseif gname == gname2 then
                local gstat = getPlayerGuildStatus(cname)
                local gstat2 = getPlayerGuildStatus(pname)
                if gstat > gstat2 then
                    if clearPlayerGuild(pname) then
                        npcHandler:say('Você expulsou ' .. pname .. ' da sua guilda.', cid)
                    else
                        npcHandler:say('Houve um erro ao expulsar o jogador.', cid)
                    end
                    talkState[cid] = 0
                else
                    npcHandler:say('Desculpe, vice-líderes só podem expulsar membros comuns.', cid)
                    talkState[cid] = 0
                end
            else
                npcHandler:say('Desculpe, ' .. pname .. ' não está na sua guilda.', cid)
                talkState[cid] = 0
            end
            
        elseif talkState[cid] == 5 then
            local pname = msg
            local gstat = getPlayerGuildStatus(pname)
            if gstat == MEMBER or gstat == VICE or gstat == LEADER then
                npcHandler:say('Desculpe, ' .. pname .. ' já está em outra guilda.', cid)
                talkState[cid] = 0
            else
                targetPlayer[cid] = pname
                npcHandler:say('E qual cargo você deseja dar a ele/ela?', cid)
                talkState[cid] = 6
            end
            
        elseif talkState[cid] == 6 then
            local grank = msg
            if string.len(grank) <= maxranklen then
                if string.find(grank, allow_pattern) then
                    local gname = getPlayerGuildName(cname)
                    if setPlayerGuild(targetPlayer[cid], INVITED, grank, gname) then
                        npcHandler:say('Você convidou ' .. targetPlayer[cid] .. ' para sua guilda.', cid)
                    else
                        npcHandler:say('Houve um erro ao enviar o convite.', cid)
                    end
                    talkState[cid] = 0
                else
                    npcHandler:say('Desculpe, o nome do cargo contém caracteres ilegais.', cid)
                    talkState[cid] = 0
                end
            else
                npcHandler:say('Desculpe, o nome do cargo não pode ter mais de ' .. maxranklen .. ' caracteres.', cid)
                talkState[cid] = 0
            end
            
        elseif talkState[cid] == 7 then
            if msgcontains(msg, 'sim') or msgcontains(msg, 'yes') then
                if clearPlayerGuild(cname) then
                    npcHandler:say('Você saiu da sua guilda.', cid)
                else
                    npcHandler:say('Houve um erro ao sair da guilda.', cid)
                end
                talkState[cid] = 0
            else
                npcHandler:say('O que mais posso fazer por você?', cid)
                talkState[cid] = 0
            end
            
        elseif talkState[cid] == 8 then
            local pname = msg
            local targetP = Player(pname)
            if targetP and targetP:getLevel() >= leaderlevel then
                local gname = getPlayerGuildName(cname)
                local gname2 = getPlayerGuildName(pname)
                if gname == gname2 then
                    setPlayerGuildStatus(cname, MEMBER)
                    setPlayerGuildStatus(pname, LEADER)
                    npcHandler:say(pname .. ' agora é o novo líder da guilda ' .. gname .. '.', cid)
                    talkState[cid] = 0
                else
                    npcHandler:say('Desculpe, ' .. pname .. ' não está na sua guilda.', cid)
                    talkState[cid] = 0
                end
            else
                npcHandler:say('Desculpe, ' .. pname .. ' não está online ou não tem o nível necessário.', cid)
                talkState[cid] = 0
            end
            
        elseif talkState[cid] == 9 then
            local pname = msg
            local gname = getPlayerGuildName(cname)
            local gname2 = getPlayerGuildName(pname)
            if cname == pname then
                npcHandler:say('Para renunciar à liderança, diga passar.', cid)
                talkState[cid] = 0
            elseif gname == gname2 then
                local gstat = getPlayerGuildStatus(pname)
                if gstat == INVITED then
                    npcHandler:say('Desculpe, ' .. pname .. ' ainda não entrou na sua guilda.', cid)
                    talkState[cid] = 0
                elseif gstat == VICE then
                    npcHandler:say(pname .. ' já é um vice-líder.', cid)
                    talkState[cid] = 0
                elseif gstat == MEMBER then
                    if setPlayerGuildStatus(pname, VICE) then
                        npcHandler:say(pname .. ' agora é vice-líder da sua guilda.', cid)
                    else
                        npcHandler:say('Houve um erro ao promover o jogador.', cid)
                    end
                    talkState[cid] = 0
                end
            else
                npcHandler:say('Desculpe, ' .. pname .. ' não está na sua guilda.', cid)
                talkState[cid] = 0
            end
            
        elseif talkState[cid] == 10 then
            local pname = msg
            local gname = getPlayerGuildName(cname)
            local gname2 = getPlayerGuildName(pname)
            if cname == pname then
                npcHandler:say('Para renunciar à liderança, diga passar.', cid)
                talkState[cid] = 0
            elseif gname == gname2 then
                local gstat = getPlayerGuildStatus(pname)
                if gstat == INVITED then
                    npcHandler:say('Desculpe, ' .. pname .. ' ainda não entrou na sua guilda.', cid)
                    talkState[cid] = 0
                elseif gstat == VICE then
                    if setPlayerGuildStatus(pname, MEMBER) then
                        npcHandler:say(pname .. ' agora é um membro comum da sua guilda.', cid)
                    else
                        npcHandler:say('Houve um erro ao rebaixar o jogador.', cid)
                    end
                    talkState[cid] = 0
                elseif gstat == MEMBER then
                    npcHandler:say(pname .. ' já é um membro comum.', cid)
                    talkState[cid] = 0
                end
            else
                npcHandler:say('Desculpe, ' .. pname .. ' não está na sua guilda.', cid)
                talkState[cid] = 0
            end
            
        elseif talkState[cid] == 11 then
            local pname = msg
            local gname = getPlayerGuildName(cname)
            local gname2 = getPlayerGuildName(pname)
            if gname == gname2 then
                targetPlayer[cid] = pname
                npcHandler:say('E qual apelido você quer que ele tenha? (diga nenhum para remover)', cid)
                talkState[cid] = 12
            else
                npcHandler:say('Desculpe, ' .. pname .. ' não está na sua guilda.', cid)
                talkState[cid] = 0
            end
            
        elseif talkState[cid] == 12 then
            if msgcontains(msg, 'nenhum') or msgcontains(msg, 'none') then
                if setPlayerGuildNick(targetPlayer[cid], '') then
                    npcHandler:say(targetPlayer[cid] .. ' agora não tem mais apelido.', cid)
                else
                    npcHandler:say('Houve um erro ao remover o apelido.', cid)
                end
                talkState[cid] = 0
            else
                if string.len(msg) <= maxnicklen then
                    if string.find(msg, allow_pattern) then
                        if setPlayerGuildNick(targetPlayer[cid], msg) then
                            npcHandler:say('Você alterou o apelido de ' .. targetPlayer[cid] .. '.', cid)
                        else
                            npcHandler:say('Houve um erro ao definir o apelido.', cid)
                        end
                        talkState[cid] = 0
                    else
                        npcHandler:say('Desculpe, o apelido contém caracteres ilegais.', cid)
                        talkState[cid] = 0
                    end
                else
                    npcHandler:say('Desculpe, o apelido não pode ter mais de ' .. maxnicklen .. ' caracteres.', cid)
                    talkState[cid] = 0
                end
            end
            
        elseif talkState[cid] == 13 then
            if msgcontains(msg, 'transferir') or msgcontains(msg, 'passar') then
                npcHandler:say('Para quem você deseja transferir a liderança?', cid)
                talkState[cid] = 8
            elseif msgcontains(msg, 'deletar') or msgcontains(msg, 'apagar') then
                npcHandler:say('Tem certeza que deseja deletar completamente a guilda? Digite sim para confirmar.', cid)
                talkState[cid] = 14
            else
                npcHandler:say('Desculpe, não entendi. Você quer transferir a liderança ou deletar a guilda?', cid)
                talkState[cid] = 13
            end
            
        elseif talkState[cid] == 14 then
            if msgcontains(msg, 'sim') or msgcontains(msg, 'yes') then
                local playerId = player:getGuid()
                local query = db.storeQuery(string.format([[
                    SELECT gm.guild_id 
                    FROM guild_membership gm 
                    WHERE gm.player_id = %d
                ]], playerId))
                
                if query then
                    local guildId = result.getNumber(query, "guild_id")
                    result.free(query)
                    
                    if deleteGuild(guildId) then
                        npcHandler:say('Sua guilda foi completamente deletada.', cid)
                    else
                        npcHandler:say('Houve um erro ao deletar a guilda.', cid)
                    end
                else
                    npcHandler:say('Houve um erro ao encontrar sua guilda.', cid)
                end
                talkState[cid] = 0
            else
                npcHandler:say('O que mais posso fazer por você?', cid)
                talkState[cid] = 0
            end
        end
    end
    
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Olá |PLAYERNAME|! Como posso ajudar você? Diga {ajuda} ou {help} para ver os comandos disponíveis.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Até logo, |PLAYERNAME|!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Até logo então.")
npcHandler:setMessage(MESSAGE_DECLINE, "Desculpe, |PLAYERNAME|! Falo com você em um minuto.")
npcHandler:addModule(FocusModule:new())
