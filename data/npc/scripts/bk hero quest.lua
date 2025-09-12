local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end
function onThink()                          npcHandler:onThink()                        end

local topicList = {
    NONE = 0,
    SAVAR_CONFIRM = 1,
    WATCH_HELMET = 2
}

local function randomSay()
    local rand = math.random(1, 100)
    if rand == 1 then
        npcHandler:say('GRR!')
    elseif rand == 50 then
        npcHandler:say('MINE!')
    end
end

local function greetCallback(cid)
    local player = Player(cid)
    npcHandler:say('SPY, OUT OF OUR CAVE!', cid)
    return true
end

local function farewellCallback(cid)
    npcHandler:say('Finally!', cid)
    return true
end

local function creatureSayCallback(cid, msgType, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    local quest = player:getStorageValue(5059)
    
    if msgcontains(msg, 'offer') then
        npcHandler:say('NO TALK SPY!', cid)
        npcHandler.topic[cid] = topicList.NONE
    elseif msgcontains(msg, 'mission') then
        npcHandler:say('GRR, YOU ARE PISSING ME OFF!', cid)
        npcHandler.topic[cid] = topicList.NONE
    elseif msgcontains(msg, 'savar') and quest == 1 then
        npcHandler:say('Hmm, savar sent you?', cid)
        npcHandler:say('Oh, he forgot his Watch here, he want it back?', cid)
        npcHandler.topic[cid] = topicList.SAVAR_CONFIRM
    elseif npcHandler.topic[cid] == topicList.SAVAR_CONFIRM and msgcontains(msg, 'yes') then
        npcHandler:say('Ok but first do me something to prove you are not a spy!', cid)
        npcHandler:say('Hmm... bring me an warrior helmet and we have a deal!', cid)
        npcHandler:say('When you get it, ask me about the watch.', cid)
        player:setStorageValue(5059, 2)
        npcHandler.topic[cid] = topicList.NONE
    elseif msgcontains(msg, 'watch') and quest == 2 then
        npcHandler:say('Did you bring me the Warrior Helmet?', cid)
        npcHandler.topic[cid] = topicList.WATCH_HELMET
    elseif npcHandler.topic[cid] == topicList.WATCH_HELMET and msgcontains(msg, 'yes') then
        if player:getItemCount(2475) >= 1 then
            player:removeItem(2475, 1)
            npcHandler:say('Ok, you proved to be loyal, now take this!', cid)
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
            local watch = player:addItem(6092, 1)
            if watch then
                watch:setSpecialDescription("Its Savar Hero Watch")
            end
            player:setStorageValue(5059, 3)
            npcHandler.topic[cid] = topicList.NONE
        else
            npcHandler:say('You dont have it, Find it with other Black Knights.', cid)
            npcHandler.topic[cid] = topicList.NONE
        end
    elseif msgcontains(msg, 'no') and npcHandler.topic[cid] > topicList.NONE then
        npcHandler:say('Bah...', cid)
        npcHandler.topic[cid] = topicList.NONE
    end
    
    return true
end

local function onThinkCallback()
    if not npcHandler:isFocused() then
        randomSay()
    end
    return true
end

npcHandler:setMessage(MESSAGE_GREET, 'SPY, OUT OF OUR CAVE!')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Finally!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'GRRRRRRRR!')
npcHandler:setMessage(MESSAGE_DECLINE, 'GO AWAY!')

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_FAREWELL, farewellCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_ONTHINK, onThinkCallback)

npcHandler:addModule(FocusModule:new())
