local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local talkState = {}
local guildName = {}
local targetPlayer = {}
local rankName = {}
local nickName = {}

-- Guild Settings
local GUILD_CREATION_PRICE = 0 -- Free guild creation (original behavior)
local GUILD_NAME_MIN_LENGTH = 3
local GUILD_NAME_MAX_LENGTH = 30
local GUILD_INVITATION_EXPIRE_TIME = 86400 -- 24 hours in seconds
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
    
    -- Check if player has pending invitation
    local query = db.storeQuery(string.format("SELECT guild_id FROM guild_invitations WHERE player_id = %d AND expiration > %d", playerId, os.time()))
    if query then
        result.free(query)
        return INVITED
    end
    
    -- Check guild membership
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
    -- Check if guild already exists
    local query = db.storeQuery("SELECT id FROM guilds WHERE name = " .. db.escapeString(name))
    if query then
        result.free(query)
        return 0 -- Guild already exists
    end
    return 1 -- Guild name available
end

local function createGuildForPlayer(cid, name, leaderRank)
    local player = Player(cid)
    local playerId = player:getGuid()
    
    -- Create guild in database
    db.query(string.format("INSERT INTO guilds (name, ownerid, creationdata, points, level, residence, description) VALUES (%s, %d, %d, %d, %d, %d, %s)",
        db.escapeString(name), playerId, os.time(), 0, GUILD_DEFAULT_LEVEL, 0, db.escapeString("")))
    
    -- Get newly created guild ID
    local guildId = 0
    local query = db.storeQuery("SELECT id FROM guilds WHERE name = " .. db.escapeString(name))
    if query then
        guildId = result.getNumber(query, "id")
        result.free(query)
    else
        return false
    end
    
    -- Create custom leader rank
    db.query(string.format("INSERT INTO guild_ranks (guild_id, name, level) VALUES (%d, %s, %d)",
        guildId, db.escapeString(leaderRank), 3))
    db.query(string.format("INSERT INTO guild_ranks (guild_id, name, level) VALUES (%d, %s, %d)",
        guildId, db.escapeString("Vice-Leader"), 2))
    db.query(string.format("INSERT INTO guild_ranks (guild_id, name, level) VALUES (%d, %s, %d)",
        guildId, db.escapeString("Member"), 1))
    
    -- Get leader rank ID
    local leaderRankId = 0
    query = db.storeQuery("SELECT id FROM guild_ranks WHERE guild_id = " .. guildId .. " AND level = 3")
    if query then
        leaderRankId = result.getNumber(query, "id")
        result.free(query)
    else
        return false
    end
    
    -- Add player as guild leader
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
        -- Accept invitation
        local query = db.storeQuery(string.format("SELECT guild_id FROM guild_invitations WHERE player_id = %d AND expiration > %d", playerId, os.time()))
        if not query then
            return false
        end
        
        local guildId = result.getNumber(query, "guild_id")
        result.free(query)
        
        -- Get member rank ID
        local rankId = 0
        query = db.storeQuery("SELECT id FROM guild_ranks WHERE guild_id = " .. guildId .. " AND level = 1")
        if query then
            rankId = result.getNumber(query, "id")
            result.free(query)
        end
        
        -- Add to guild
        db.query(string.format("INSERT INTO guild_membership (player_id, guild_id, rank_id) VALUES (%d, %d, %d)",
            playerId, guildId, rankId))
        
        -- Remove invitation
        db.query(string.format("DELETE FROM guild_invitations WHERE player_id = %d", playerId))
        
    elseif status == VICE then
        -- Promote to vice-leader
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
        
        -- Get vice-leader rank ID
        local rankId = 0
        query = db.storeQuery("SELECT id FROM guild_ranks WHERE guild_id = " .. guildId .. " AND level = 2")
        if query then
            rankId = result.getNumber(query, "id")
            result.free(query)
        end
        
        -- Update rank
        db.query("UPDATE guild_membership SET rank_id = " .. rankId .. " WHERE player_id = " .. playerId)
        
    elseif status == LEADER then
        -- Transfer leadership
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
        
        -- Get leader rank ID
        local leaderRankId = 0
        query = db.storeQuery("SELECT id FROM guild_ranks WHERE guild_id = " .. guildId .. " AND level = 3")
        if query then
            leaderRankId = result.getNumber(query, "id")
            result.free(query)
        end
        
        -- Update rank and guild owner
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
        -- Get guild ID
        local query = db.storeQuery("SELECT id FROM guilds WHERE name = " .. db.escapeString(guildName))
        if not query then
            return false
        end
        
        local guildId = result.getNumber(query, "id")
        result.free(query)
        
        -- Create invitation
        local expirationTime = os.time() + GUILD_INVITATION_EXPIRE_TIME
        db.query(string.format("INSERT INTO guild_invitations (player_id, guild_id, expiration, rank_name) VALUES (%d, %d, %d, %s)",
            playerId, guildId, expirationTime, db.escapeString(rank)))
        
        -- Notify player if online
        local targetPlayer = Player(playerName)
        if targetPlayer then
            targetPlayer:sendTextMessage(MESSAGE_INFO_DESCR,
                string.format("You have been invited to join guild '%s' with rank '%s'. Visit the Guild Manager to accept or decline.", guildName, rank))
        end
    end
    
    return true
end

local function clearPlayerGuild(playerName)
    local playerId = getPlayerGUIDByName(playerName)
    if not playerId then
        return false
    end
    
    -- Remove from guild
    db.query("DELETE FROM guild_membership WHERE player_id = " .. playerId)
    -- Remove any pending invitations
    db.query("DELETE FROM guild_invitations WHERE player_id = " .. playerId)
    
    return true
end

local function setPlayerGuildNick(playerName, nick)
    local playerId = getPlayerGUIDByName(playerName)
    if not playerId then
        return false
    end
    
    -- Update nickname
    db.query("UPDATE guild_membership SET nick = " .. db.escapeString(nick) .. " WHERE player_id = " .. playerId)
    
    -- Notify player if online
    local targetPlayer = Player(playerName)
    if targetPlayer then
        if nick == "" then
            targetPlayer:sendTextMessage(MESSAGE_INFO_DESCR, "Your guild nickname has been cleared.")
        else
            targetPlayer:sendTextMessage(MESSAGE_INFO_DESCR, 
                string.format("Your guild nickname has been set to '%s'.", nick))
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
    
    if talkState[cid] == 0 then
        if msgcontains(msg, 'found') then -- found a new guild
            local level = player:getLevel()
            if level >= leaderlevel then
                local gstat = getPlayerGuildStatus(cname)
                if gstat == NONE or gstat == INVITED then
                    npcHandler:say('What name your guild should have?', cid)
                    talkState[cid] = 1
                elseif gstat == MEMBER or gstat == VICE or gstat == LEADER then
                    npcHandler:say('Sorry, you are member of a guild.', cid)
                    talkState[cid] = 0
                end
            else
                npcHandler:say('Sorry, you need level ' .. leaderlevel .. ' to found a guild.', cid)
            end
            
        elseif msgcontains(msg, 'join') then -- join a guild when invited
            local gstat = getPlayerGuildStatus(cname)
            if gstat == NONE then
                npcHandler:say('Sorry, you are not invited to any guild.', cid)
                talkState[cid] = 0
            elseif gstat == INVITED then
                local gname = getInvitedGuildName(cname)
                if gname then
                    npcHandler:say('Do you want to join {' .. gname .. '}?', cid)
                    talkState[cid] = 3
                else
                    npcHandler:say('Sorry, there was an error finding your guild invitation.', cid)
                    talkState[cid] = 0
                end
            elseif gstat == MEMBER or gstat == VICE or gstat == LEADER then
                npcHandler:say('Sorry, you are a member of a guild.', cid)
                talkState[cid] = 0
            end
            
        elseif msgcontains(msg, 'exclude') or msgcontains(msg, 'kick') then -- kick player from a guild
            local gstat = getPlayerGuildStatus(cname)
            if gstat == VICE or gstat == LEADER then
                npcHandler:say('Who do you want to kick today?', cid)
                talkState[cid] = 4
            else
                npcHandler:say('Sorry, only leader and vice-leaders can kick players from a guild.', cid)
                talkState[cid] = 0
            end
            
        elseif msgcontains(msg, 'invite') then -- invite player to a guild
            local gstat = getPlayerGuildStatus(cname)
            if gstat == VICE or gstat == LEADER then
                npcHandler:say('Who do you want to invite to your guild?', cid)
                talkState[cid] = 5
            else
                npcHandler:say('Sorry, only leader and vice-leaders can invite players to a guild.', cid)
                talkState[cid] = 0
            end
            
        elseif msgcontains(msg, 'leave') then -- leave a guild
            local gstat = getPlayerGuildStatus(cname)
            if gstat == NONE or gstat == INVITED then
                npcHandler:say('You are not in a guild.', cid)
                talkState[cid] = 0
            elseif gstat == MEMBER or gstat == VICE then
                local gname = getPlayerGuildName(cname)
                npcHandler:say('Do you want to leave ' .. gname .. '?', cid)
                talkState[cid] = 7
            elseif gstat == LEADER then
                npcHandler:say('You are a leader of a guild. If you leave, no one can invite new players. Are you sure?', cid)
                talkState[cid] = 7
            end
            
        elseif msgcontains(msg, 'pass') then -- pass leadership
            local gstat = getPlayerGuildStatus(cname)
            if gstat == LEADER then
                npcHandler:say('Who do you want to be a new leader?', cid)
                talkState[cid] = 8
            else
                npcHandler:say('Sorry, only leader can resign from his position.', cid)
                talkState[cid] = 0
            end
            
        elseif msgcontains(msg, 'vice') then -- set vice leader
            local gstat = getPlayerGuildStatus(cname)
            if gstat == LEADER then
                npcHandler:say('Which member do you want to promote to vice-leader?', cid)
                talkState[cid] = 9
            else
                npcHandler:say('Sorry, only leader can promote member to vice-leader.', cid)
                talkState[cid] = 0
            end
            
        elseif msgcontains(msg, 'member') then -- remove vice-leader
            local gstat = getPlayerGuildStatus(cname)
            if gstat == LEADER then
                npcHandler:say('Which vice-leader do you want to demote to regular member?', cid)
                talkState[cid] = 10
            else
                npcHandler:say('Sorry, only leader can demote vice-leaders to members.', cid)
                talkState[cid] = 0
            end
            
        elseif msgcontains(msg, 'nick') or msgcontains(msg, 'title') then -- set nick
            local gstat = getPlayerGuildStatus(cname)
            if gstat == LEADER then
                npcHandler:say('Whom player do you want to change nick?', cid)
                talkState[cid] = 11
            else
                npcHandler:say('Sorry, only leader can change nicks.', cid)
                talkState[cid] = 0
            end
        end
        
    else -- talk_state != 0
        if talkState[cid] == 1 then -- get name of new guild
            local gname = msg
            if string.len(gname) <= maxnamelen then
                if string.find(gname, allow_pattern) then
                    if foundNewGuild(gname) == 0 then
                        npcHandler:say('Sorry, there is already a guild with that name.', cid)
                        talkState[cid] = 0
                    else
                        guildName[cid] = gname
                        npcHandler:say('And what rank do you wish to have?', cid)
                        talkState[cid] = 2
                    end
                else
                    npcHandler:say('Sorry, guild name contains illegal characters.', cid)
                    talkState[cid] = 0
                end
            else
                npcHandler:say('Sorry, guild name cannot be longer than ' .. maxnamelen .. ' characters.', cid)
                talkState[cid] = 0
            end
            
        elseif talkState[cid] == 2 then -- get rank of leader
            local grank = msg
            if string.len(grank) <= maxranklen then
                if string.find(grank, allow_pattern) then
                    if createGuildForPlayer(cid, guildName[cid], grank) then
                        npcHandler:say('You are now leader of your new guild.', cid)
                    else
                        npcHandler:say('There was an error creating your guild.', cid)
                    end
                    talkState[cid] = 0
                else
                    npcHandler:say('Sorry, rank name contains illegal characters.', cid)
                    talkState[cid] = 0
                end
            else
                npcHandler:say('Sorry, rank name cannot be longer than ' .. maxranklen .. ' characters.', cid)
                talkState[cid] = 0
            end
            
        elseif talkState[cid] == 3 then -- join a guild
            if msgcontains(msg, 'yes') then
                if setPlayerGuildStatus(cname, MEMBER) then
                    npcHandler:say('You are now member of a guild.', cid)
                else
                    npcHandler:say('There was an error joining the guild.', cid)
                end
                talkState[cid] = 0
            else
                npcHandler:say('What else can I do for you?', cid)
                talkState[cid] = 0
            end
            
        elseif talkState[cid] == 4 then -- kick player
            local pname = msg
            local gname = getPlayerGuildName(cname)
            local gname2 = getPlayerGuildName(pname)
            if cname == pname then
                npcHandler:say('To kick yourself say leave.', cid)
                talkState[cid] = 0
            elseif gname == gname2 then
                local gstat = getPlayerGuildStatus(cname)
                local gstat2 = getPlayerGuildStatus(pname)
                if gstat > gstat2 then
                    if clearPlayerGuild(pname) then
                        npcHandler:say('You kicked ' .. pname .. ' from your guild.', cid)
                    else
                        npcHandler:say('There was an error kicking the player.', cid)
                    end
                    talkState[cid] = 0
                else
                    npcHandler:say('Sorry, vice-leaders can kick only regular members.', cid)
                    talkState[cid] = 0
                end
            else
                npcHandler:say('Sorry, ' .. pname .. ' is not in your guild.', cid)
                talkState[cid] = 0
            end
            
        elseif talkState[cid] == 5 then -- get invited name
            local pname = msg
            local gstat = getPlayerGuildStatus(pname)
            if gstat == MEMBER or gstat == VICE or gstat == LEADER then
                npcHandler:say('Sorry, ' .. pname .. ' is in another guild.', cid)
                talkState[cid] = 0
            else
                targetPlayer[cid] = pname
                npcHandler:say('And what rank do you wish to give him/her?', cid)
                talkState[cid] = 6
            end
            
        elseif talkState[cid] == 6 then -- get invited rank
            local grank = msg
            if string.len(grank) <= maxranklen then
                if string.find(grank, allow_pattern) then
                    local gname = getPlayerGuildName(cname)
                    if setPlayerGuild(targetPlayer[cid], INVITED, grank, gname) then
                        npcHandler:say('You have invited ' .. targetPlayer[cid] .. ' to your guild.', cid)
                    else
                        npcHandler:say('There was an error sending the invitation.', cid)
                    end
                    talkState[cid] = 0
                else
                    npcHandler:say('Sorry, rank name contains illegal characters.', cid)
                    talkState[cid] = 0
                end
            else
                npcHandler:say('Sorry, rank name cannot be longer than ' .. maxranklen .. ' characters.', cid)
                talkState[cid] = 0
            end
            
        elseif talkState[cid] == 7 then -- leave a guild
            if msgcontains(msg, 'yes') then
                if clearPlayerGuild(cname) then
                    npcHandler:say('You have left your guild.', cid)
                else
                    npcHandler:say('There was an error leaving the guild.', cid)
                end
                talkState[cid] = 0
            else
                npcHandler:say('What else can I do for you?', cid)
                talkState[cid] = 0
            end
            
        elseif talkState[cid] == 8 then -- pass leadership
            local pname = msg
            local targetPlayer = Player(pname)
            if targetPlayer and targetPlayer:getLevel() >= leaderlevel then
                local gname = getPlayerGuildName(cname)
                local gname2 = getPlayerGuildName(pname)
                if gname == gname2 then
                    -- Demote current leader to member
                    setPlayerGuildStatus(cname, MEMBER)
                    -- Promote target to leader
                    setPlayerGuildStatus(pname, LEADER)
                    npcHandler:say(pname .. ' is a new leader of ' .. gname .. '.', cid)
                    talkState[cid] = 0
                else
                    npcHandler:say('Sorry, ' .. pname .. ' is not in your guild.', cid)
                    talkState[cid] = 0
                end
            else
                npcHandler:say('Sorry, ' .. pname .. ' is not online.', cid)
                talkState[cid] = 0
            end
            
        elseif talkState[cid] == 9 then -- set vice-leader
            local pname = msg
            local gname = getPlayerGuildName(cname)
            local gname2 = getPlayerGuildName(pname)
            if cname == pname then
                npcHandler:say('To resign from leadership say pass.', cid)
                talkState[cid] = 0
            elseif gname == gname2 then
                local gstat = getPlayerGuildStatus(pname)
                if gstat == INVITED then
                    npcHandler:say('Sorry, ' .. pname .. ' hasn\'t joined your guild yet.', cid)
                    talkState[cid] = 0
                elseif gstat == VICE then
                    npcHandler:say(pname .. ' is already a vice-leader.', cid)
                    talkState[cid] = 0
                elseif gstat == MEMBER then
                    if setPlayerGuildStatus(pname, VICE) then
                        npcHandler:say(pname .. ' is now a vice-leader of your guild.', cid)
                    else
                        npcHandler:say('There was an error promoting the player.', cid)
                    end
                    talkState[cid] = 0
                end
            else
                npcHandler:say('Sorry, ' .. pname .. ' is not in your guild.', cid)
                talkState[cid] = 0
            end
            
        elseif talkState[cid] == 10 then -- set member
            local pname = msg
            local gname = getPlayerGuildName(cname)
            local gname2 = getPlayerGuildName(pname)
            if cname == pname then
                npcHandler:say('To resign from leadership say pass.', cid)
                talkState[cid] = 0
            elseif gname == gname2 then
                local gstat = getPlayerGuildStatus(pname)
                if gstat == INVITED then
                    npcHandler:say('Sorry, ' .. pname .. ' hasn\'t joined your guild yet.', cid)
                    talkState[cid] = 0
                elseif gstat == VICE then
                    if setPlayerGuildStatus(pname, MEMBER) then
                        npcHandler:say(pname .. ' is now a regular member of your guild.', cid)
                    else
                        npcHandler:say('There was an error demoting the player.', cid)
                    end
                    talkState[cid] = 0
                elseif gstat == MEMBER then
                    npcHandler:say(pname .. ' is already a regular member.', cid)
                    talkState[cid] = 0
                end
            else
                npcHandler:say('Sorry, ' .. pname .. ' is not in your guild.', cid)
                talkState[cid] = 0
            end
            
        elseif talkState[cid] == 11 then -- get name of player to change nick
            local pname = msg
            local gname = getPlayerGuildName(cname)
            local gname2 = getPlayerGuildName(pname)
            if gname == gname2 then
                targetPlayer[cid] = pname
                npcHandler:say('And what nick do you want him to have (say none to clear)?', cid)
                talkState[cid] = 12
            else
                npcHandler:say('Sorry, ' .. pname .. ' is not in your guild.', cid)
                talkState[cid] = 0
            end
            
        elseif talkState[cid] == 12 then -- get nick
            if msgcontains(msg, 'none') then
                if setPlayerGuildNick(targetPlayer[cid], '') then
                    npcHandler:say(targetPlayer[cid] .. ' now has no nick.', cid)
                else
                    npcHandler:say('There was an error clearing the nickname.', cid)
                end
                talkState[cid] = 0
            else
                if string.len(msg) <= maxnicklen then
                    if string.find(msg, allow_pattern) then
                        if setPlayerGuildNick(targetPlayer[cid], msg) then
                            npcHandler:say('You have changed ' .. targetPlayer[cid] .. '\'s nick.', cid)
                        else
                            npcHandler:say('There was an error setting the nickname.', cid)
                        end
                        talkState[cid] = 0
                    else
                        npcHandler:say('Sorry, nick contains illegal characters.', cid)
                        talkState[cid] = 0
                    end
                else
                    npcHandler:say('Sorry, nick cannot be longer than ' .. maxnicklen .. ' characters.', cid)
                    talkState[cid] = 0
                end
            end
        end
    end
    
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME|! How can I help you?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye, |PLAYERNAME|!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye then.")
npcHandler:setMessage(MESSAGE_DECLINE, "Sorry, |PLAYERNAME|! I talk to you in a minute.")
npcHandler:addModule(FocusModule:new())
