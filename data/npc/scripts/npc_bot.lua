local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                          npcHandler:onThink() end

-- Voice messages for random broadcasts and raids
local voices = {
    {text = "/bc white They are Welcome! This server is running with Neverland 7.6 - Version 1.2"},
    {text = "/raid mino"},
    {text = "/raid undead"},
    {text = "/raid orsha"},
    {text = "/bc white Download your Neverland version in OTFans!"},
    {text = "/raid trolls"}
}
npcHandler:addModule(VoiceModule:new(voices))

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local player = Player(cid)
    if not player then
        return false
    end

    -- Bot doesn't have specific conversation logic
    -- Just responds to basic greetings
    if msgcontains(msg, 'help') then
        selfSay('I am a bot made by Gamemasters to help manage the server!', cid)
    elseif msgcontains(msg, 'job') then
        selfSay('I manage server broadcasts and raids!', cid)
    end

    return true
end

function onGreet(cid)
    local player = Player(cid)
    if not player then
        return false
    end
    
    selfSay('Hello young adventurer! I\'m a bot made by Gamemasters.', cid)
    return true
end

function onFarewell(cid)
    local player = Player(cid)
    if not player then
        return false
    end
    
    selfSay('Goodbye adventurer!', cid)
    return true
end

-- Custom onThink for random movement and messages
function onThink()
    npcHandler:onThink()
    
    -- Random movement when not focused on any player
    if not npcHandler:isFocused() then
        local position = Npc():getPosition()
        local randmove = math.random(1, 15)
        local newPos = Position(position.x, position.y, position.z)
        
        if randmove == 1 then
            newPos.x = newPos.x + 1
        elseif randmove == 2 then
            newPos.x = newPos.x - 1
        elseif randmove == 3 then
            newPos.y = newPos.y + 1
        elseif randmove == 4 then
            newPos.y = newPos.y - 1
        end
        
        -- Only move if it's a different position and valid
        if randmove <= 4 then
            local tile = Tile(newPos)
            if tile and not tile:hasFlag(TILESTATE_BLOCKSOLID) then
                Npc():moveTo(newPos)
            end
        end
    end
    
    -- Random server messages/commands (much less frequent to avoid spam)
    local randsay = math.random(1, 50000)
    if randsay == 5 then
        selfSay('/bc white They are Welcome! This server is running with Neverland 7.6 - Version 1.2')
    elseif randsay == 10 then
        selfSay('/raid mino')
    elseif randsay == 15 then
        selfSay('/raid undead')
    elseif randsay == 20 then
        selfSay('/raid orsha')
    elseif randsay == 25 then
        selfSay('/bc white Download your Neverland version in OTFans!')
    elseif randsay == 30 then
        selfSay('/raid trolls')
    end
end

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
