local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                          npcHandler:onThink() end

local attack = 0
local following = false
local target = 0

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local player = Player(cid)
    if not player then
        return false
    end

    local playerPos = player:getPosition()
    local tile = Tile(playerPos)
    local isProtectionZone = tile and tile:hasFlag(TILESTATE_PROTECTIONZONE)

    if msgcontains(msg, 'fuck you') and isProtectionZone then
        selfSay('You are safe here, but watch your mouth!', cid)

    elseif msgcontains(msg, 'fuck you') or msgcontains(msg, 'curse') then
        selfSay('How dare you! Now you will pay!', cid)
        attack = 1
        following = true
        target = cid
        -- Note: Attack() function may not work in modern TFS without special NPC configuration

    elseif msgcontains(msg, 'stop') then
        selfSay('Fine! You learned your lesson!', cid)
        attack = 0
        following = false
        target = 0

    elseif msgcontains(msg, 'sorry') or msgcontains(msg, 'apologize') then
        selfSay('Apology accepted. Watch your language next time!', cid)
        attack = 0
        following = false
        target = 0

    elseif msgcontains(msg, 'help') then
        selfSay('Be respectful and I will be respectful to you!', cid)
    end

    return true
end

function onGreet(cid)
    local player = Player(cid)
    if not player then
        return false
    end
    
    selfSay('Watch your language around me, ' .. player:getName() .. '!', cid)
    return true
end

function onFarewell(cid)
    local player = Player(cid)
    if not player then
        return false
    end
    
    selfSay('Take care, ' .. player:getName() .. '!', cid)
    attack = 0
    following = false
    target = 0
    return true
end

-- Custom onThink for following behavior
function onThink()
    npcHandler:onThink()
    
    if following and target > 0 then
        local player = Player(target)
        if player then
            local playerPos = player:getPosition()
            local tile = Tile(playerPos)
            local isProtectionZone = tile and tile:hasFlag(TILESTATE_PROTECTIONZONE)
            
            if isProtectionZone then
                selfSay('You are safe there, but I will be watching!', target)
                attack = 0
                following = false
                target = 0
                npcHandler:releaseFocus()
            else
                -- Move towards player (if moveToCreature exists)
                -- Note: This function may not exist in modern TFS
                local npcPos = Npc():getPosition()
                local direction = npcPos:getDirectionTo(playerPos)
                if direction < 8 then
                    Npc():move(direction)
                end
            end
        else
            -- Player logged out or doesn't exist
            following = false
            target = 0
            attack = 0
        end
    end
end

-- Handle player disconnection
function onCreatureDisappear(cid, pos)
    if target == cid then
        selfSay('Running away? Smart choice!')
        attack = 0
        following = false
        target = 0
    end
    npcHandler:onCreatureDisappear(cid, pos)
end

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
