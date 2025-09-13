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
    if not player then
        return false
    end
    
    local pos = Position(540, 456, 5)
    local topic = npcHandler.topic[cid] or topicList.NONE
    local msgLower = msg:lower()
    
    if msgcontains(msgLower, 'carlin') then
        npcHandler:say('Do you wish to travel to Carlin for 200 gold coins?', cid)
        npcHandler.topic[cid] = topicList.CARLIN
        
    elseif msgcontains(msgLower, 'tirith') or msgcontains(msgLower, 'minas') then
        npcHandler:say('Do you wish to travel to Minas Tirith for 400 gold coins?', cid)
        npcHandler.topic[cid] = topicList.TIRITH
        
    elseif msgcontains(msgLower, 'edron') then
        npcHandler:say('Do you wish to travel to Edron for 400 gold coins?', cid)
        npcHandler.topic[cid] = topicList.EDRON
        
    elseif msgcontains(msgLower, 'bree') then
        npcHandler:say('Do you wish to travel to Bree for 500 gold coins?', cid)
        npcHandler.topic[cid] = topicList.BREE
        
    elseif msgcontains(msgLower, 'yes') then
        if topic == topicList.CARLIN then
            if player:isPremium() then
                if player:removeTotalMoney(200) then
                    npcHandler:say('Have a safe trip to Carlin!', cid)
                    player:teleportTo(Position(151, 356, 6))
                    Position(151, 356, 6):sendMagicEffect(CONST_ME_TELEPORT)
                    Game.createItem(2152, 2, pos)
                else
                    npcHandler:say('Sorry, you need 200 gold coins.', cid)
                end
            else
                npcHandler:say('Sorry, only premium players can travel.', cid)
            end
            npcHandler.topic[cid] = topicList.NONE
            
        elseif topic == topicList.TIRITH then
            if player:isPremium() and player:removeTotalMoney(400) then
                npcHandler:say('Have a safe trip to Minas Tirith!', cid)
                player:teleportTo(Position(476, 293, 6))
                Position(476, 293, 6):sendMagicEffect(CONST_ME_TELEPORT)
            else
                npcHandler:say('Sorry, you need 400 gold coins and premium account.', cid)
            end
            npcHandler.topic[cid] = topicList.NONE
            
        elseif topic == topicList.EDRON then
            if player:isPremium() and player:removeTotalMoney(400) then
                npcHandler:say('Have a safe trip to Edron!', cid)
                player:teleportTo(Position(736, 795, 6))
                Position(736, 795, 6):sendMagicEffect(CONST_ME_TELEPORT)
            else
                npcHandler:say('Sorry, you need 400 gold coins and premium account.', cid)
            end
            npcHandler.topic[cid] = topicList.NONE
            
        elseif topic == topicList.BREE then
            if player:isPremium() and player:removeTotalMoney(500) then
                npcHandler:say('Have a safe trip to Bree!', cid)
                player:teleportTo(Position(818, 2030, 6))
                Position(818, 2030, 6):sendMagicEffect(CONST_ME_TELEPORT)
            else
                npcHandler:say('Sorry, you need 500 gold coins and premium account.', cid)
            end
            npcHandler.topic[cid] = topicList.NONE
        else
            npcHandler:say('What are you agreeing to?', cid)
        end
        
    elseif msgcontains(msgLower, 'no') and topic > topicList.NONE then
        npcHandler:say('Maybe another time then.', cid)
        npcHandler.topic[cid] = topicList.NONE
    end
    
    return true
end

local function onAddFocus(cid)
    npcHandler.topic[cid] = topicList.NONE
end

local function onReleaseFocus(cid)
    npcHandler.topic[cid] = nil
end

npcHandler:setCallback(CALLBACK_ONADDFOCUS, onAddFocus)
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, onReleaseFocus)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

keywordHandler:addKeyword({'destination'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I can take you to Carlin, Edron, Minas Tirith and Bree.'
})

keywordHandler:addKeyword({'job'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I am the Captain of this ship.'
})

keywordHandler:addKeyword({'offer'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I can take you to Carlin for 200gp, Edron and Minas Tirith for 400gp each, and Bree for 500gp.'
})
