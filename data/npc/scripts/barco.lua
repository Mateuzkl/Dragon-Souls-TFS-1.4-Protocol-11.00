local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local cost = {}
local destination = {}

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end
function onThink()                          npcHandler:onThink()                        end

local topicList = {
    NONE = 0,
    TRAVEL_CONFIRM = 1
}

local function creatureSayCallback(cid, msgType, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    
    if msgcontains(msg, 'tombstone') then
        if player:isPremium() then
            npcHandler:say('Do you wish to travel to tombstone for 80 gold coins?', cid)
            destination[cid] = Position(993, 972, 7)
            cost[cid] = 80
            npcHandler.topic[cid] = topicList.TRAVEL_CONFIRM
        else
            npcHandler:say('Only players with premium accounts may travel there.', cid)
            npcHandler.topic[cid] = topicList.NONE
        end
    elseif msgcontains(msg, 'carlin') then
        if player:isPremium() then
            npcHandler:say('Do you wish to travel to carlin for 80 gold coins?', cid)
            destination[cid] = Position(998, 968, 7)
            cost[cid] = 80
            npcHandler.topic[cid] = topicList.TRAVEL_CONFIRM
        else
            npcHandler:say('Only players with premium accounts may travel there.', cid)
            npcHandler.topic[cid] = topicList.NONE
        end
    elseif npcHandler.topic[cid] == topicList.TRAVEL_CONFIRM then
        if msgcontains(msg, 'yes') then
            if player:removeMoney(cost[cid]) then
                npcHandler:say('Set the sails!', cid)
                player:teleportTo(destination[cid])
                destination[cid]:sendMagicEffect(CONST_ME_TELEPORT)
                npcHandler.topic[cid] = topicList.NONE
                cost[cid] = nil
                destination[cid] = nil
            else
                npcHandler:say('You do not have enough money!', cid)
                npcHandler.topic[cid] = topicList.NONE
                cost[cid] = nil
                destination[cid] = nil
            end
        elseif msgcontains(msg, 'no') then
            npcHandler:say('Where do you wish to go then?', cid)
            npcHandler.topic[cid] = topicList.NONE
            cost[cid] = nil
            destination[cid] = nil
        end
    end
    
    return true
end

-- Keywords
keywordHandler:addKeyword({'offer'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I can take you from here to tombstone and carlin.'
})

keywordHandler:addKeyword({'travel'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I can take you from here to tombstone and carlin.'
})

keywordHandler:addKeyword({'sell'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I am not buying anything.'
})

keywordHandler:addKeyword({'buy'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I am just selling passages for carlin and tombstone.'
})

keywordHandler:addKeyword({'job'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I am the Captain of this Ship!'
})

keywordHandler:addKeyword({'quest'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'Since i get busted by pirates in my quests, i never get out of route again!'
})

keywordHandler:addKeyword({'mission'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'Since i get busted by pirates in my quests, i never get out of route again!'
})

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
