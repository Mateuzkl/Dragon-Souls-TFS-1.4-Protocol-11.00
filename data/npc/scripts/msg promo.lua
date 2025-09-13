local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                          npcHandler:onThink() end

-- Voice messages
local voices = {
    {text = "Help!"},
    {text = "Here! I need help!"},
    {text = "Help me please!"}
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

    local talk_state = npcHandler.topic[cid] or 0
    local promo = player:getStorageValue(30007)

    if msgcontains(msg, 'key') and talk_state == 0 then
        if promo == 1 then
            selfSay('Oh my hero! You got the key?', cid)
            npcHandler.topic[cid] = 1
        end

    elseif msgcontains(msg, 'no') and npcHandler.topic[cid] == 1 then
        selfSay('Oh too bad! So, i can\'t out... Please do a favor for me.', cid)
        selfSay('Can you take a message from me to the queen?', cid)
        npcHandler.topic[cid] = 2

    elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 1 then
        selfSay('Oh great! You are the best! So open the door for we run out of here!', cid)
        npcHandler.topic[cid] = 0

    elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 2 then
        player:setStorageValue(30007, 2)
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
        local carta = player:addItem(2598, 1)
        if carta then
            carta:setAttribute(ITEM_ATTRIBUTE_TEXT, "My queen, im busted on orc place, need help! By Sarina.")
        end
        selfSay('Say to her that you have a message from Sarina... thanks so much!', cid)
        npcHandler.topic[cid] = 0

    elseif msgcontains(msg, 'no') and (npcHandler.topic[cid] >= 2 and npcHandler.topic[cid] <= 34) then
        selfSay('Ok then.', cid)
        npcHandler.topic[cid] = 0

    elseif msgcontains(msg, 'message') then
        if promo ~= 1 then
            selfSay('What you doing here? Please, i wanna out of here!', cid)
        else
            selfSay('Can you take a message from me to the queen?', cid)
            npcHandler.topic[cid] = 2
        end

    elseif msgcontains(msg, 'help') then
        selfSay('Please help me get out of here!', cid)
    end

    return true
end

function onGreet(cid)
    local player = Player(cid)
    if not player then
        return false
    end

    local promo = player:getStorageValue(30007)
    
    if promo == 1 then
        selfSay('Oh my hero! You got the key?', cid)
        npcHandler.topic[cid] = 1
    else
        selfSay('What you doing here? Please, i wanna out of here!', cid)
        npcHandler.topic[cid] = 0
    end
    
    return true
end

function onFarewell(cid)
    local player = Player(cid)
    if not player then
        return false
    end
    
    selfSay('Good bye, ' .. player:getName() .. '!', cid)
    npcHandler.topic[cid] = 0
    return true
end

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
