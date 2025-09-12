local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end
function onThink()                          npcHandler:onThink()                        end

local topicList = {
    NONE = 0,
    CARLIN = 1,
    TIRITH = 2,
    EDRON = 3,
    BREE = 4
}

local function creatureSayCallback(cid, msgType, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    local pos = Position(540, 456, 5)
    
    if msgcontains(msg, 'carlin') then
        npcHandler:say('Do you wish to travel to Carlin for 200 gold coins?', cid)
        npcHandler.topic[cid] = topicList.CARLIN
    elseif msgcontains(msg, 'tirith') then
        npcHandler:say('Do you wish to travel to Minas Tirith for 400 gold coins?', cid)
        npcHandler.topic[cid] = topicList.TIRITH
    elseif msgcontains(msg, 'edron') then
        npcHandler:say('Do you wish to travel to Edron for 400 gold coins?', cid)
        npcHandler.topic[cid] = topicList.EDRON
    elseif msgcontains(msg, 'bree') then
        npcHandler:say('Do you wish to travel to Bree for 500 gold coins?', cid)
        npcHandler.topic[cid] = topicList.BREE
    elseif npcHandler.topic[cid] == topicList.CARLIN and msgcontains(msg, 'yes') then
        if player:isPremium() then
            if player:removeMoney(200) then
                player:teleportTo(Position(151, 356, 6))
                Game.createItem(2152, 2, pos)
                npcHandler.topic[cid] = topicList.NONE
            else
                npcHandler:say('Sorry, you don\'t have this money.', cid)
                npcHandler.topic[cid] = topicList.NONE
            end
        else
            npcHandler:say('Sorry, only premium players can travel with me.', cid)
            npcHandler.topic[cid] = topicList.NONE
        end
    elseif npcHandler.topic[cid] == topicList.TIRITH and msgcontains(msg, 'yes') then
        if player:isPremium() then
            if player:removeMoney(400) then
                player:teleportTo(Position(476, 293, 6))
                npcHandler.topic[cid] = topicList.NONE
            else
                npcHandler:say('Sorry, you don\'t have this money.', cid)
                npcHandler.topic[cid] = topicList.NONE
            end
        else
            npcHandler:say('Sorry, only premium players can travel with me.', cid)
            npcHandler.topic[cid] = topicList.NONE
        end
    elseif npcHandler.topic[cid] == topicList.EDRON and msgcontains(msg, 'yes') then
        if player:isPremium() then
            if player:removeMoney(400) then
                player:teleportTo(Position(736, 795, 6))
                npcHandler.topic[cid] = topicList.NONE
            else
                npcHandler:say('Sorry, you don\'t have this money.', cid)
                npcHandler.topic[cid] = topicList.NONE
            end
        else
            npcHandler:say('Sorry, only premium players can travel with me.', cid)
            npcHandler.topic[cid] = topicList.NONE
        end
    elseif npcHandler.topic[cid] == topicList.BREE and msgcontains(msg, 'yes') then
        if player:isPremium() then
            if player:removeMoney(500) then
                player:teleportTo(Position(818, 2030, 6))
                npcHandler.topic[cid] = topicList.NONE
            else
                npcHandler:say('Sorry, you don\'t have this money.', cid)
                npcHandler.topic[cid] = topicList.NONE
            end
        else
            npcHandler:say('Sorry, only premium players can travel with me.', cid)
            npcHandler.topic[cid] = topicList.NONE
        end
    elseif msgcontains(msg, 'no') and npcHandler.topic[cid] > topicList.NONE then
        npcHandler:say('I wouldn\'t go there either.', cid)
        npcHandler.topic[cid] = topicList.NONE
    end
    
    return true
end

-- Keywords
keywordHandler:addKeyword({'destination'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I can take you to Edron, Carlin and Minas Tirith for just a small fee.'
})

keywordHandler:addKeyword({'job'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I am the Captain of this ship.'
})

keywordHandler:addKeyword({'mission'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'Since i get busted by pirates, i never get involved in quests again.'
})

keywordHandler:addKeyword({'quest'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'Since i get busted by pirates, i never get involved in quests again.'
})

keywordHandler:addKeyword({'offer'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I can take you to Edron, Carlin, Minas Tirith and Bree for just a small fee.'
})

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
