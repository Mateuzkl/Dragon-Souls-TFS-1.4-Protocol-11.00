local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                          npcHandler:onThink() end

-- Voice messages for random talking
local voices = {
    {text = "Hmmhmm..."},
    {text = "Hoho..."}
}
npcHandler:addModule(VoiceModule:new(voices))

-- Christmas presents items
local christmasItems = {2969, 2973, 3363, 3520, 2930, 3524}

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local player = Player(cid)
    if not player then
        return false
    end

    if msgcontains(msg, 'present') then
        local present = player:getStorageValue(1210)
        if present == -1 then
            -- Select random Christmas item
            local itemId = christmasItems[math.random(1, #christmasItems)]
            player:addItem(itemId, 1)
            player:setStorageValue(1210, 1)
            player:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
            selfSay('Merry Christmas! Here is your present!', cid)
        else
            selfSay('Sorry, I dont have more presents for you.', cid)
        end

    elseif msgcontains(msg, 'christmas') then
        selfSay('I love Christmas! Do you want a present?', cid)

    elseif msgcontains(msg, 'help') then
        selfSay('I can give you a Christmas present! Just say "present"!', cid)
    end

    return true
end

function onGreet(cid)
    local player = Player(cid)
    if not player then
        return false
    end
    
    selfSay('Merry Christmas ' .. player:getName() .. '!', cid)
    return true
end

function onFarewell(cid)
    local player = Player(cid)
    if not player then
        return false
    end
    
    selfSay('Good bye, ' .. player:getName() .. '!', cid)
    return true
end

-- Custom onThink for random movement
function onThink()
    npcHandler:onThink()
    
    -- Random movement when not focused on any player
    if not npcHandler:isFocused() then
        local position = Npc():getPosition()
        local randmove = math.random(1, 25)
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
end

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)  
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
