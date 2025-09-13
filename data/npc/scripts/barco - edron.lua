local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local talkState = {}

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    local state = talkState[cid] or 0
    local pos = Position(540, 456, 5)
    
    if msgcontains(msg, 'carlin') then
        npcHandler:say('Do you wish to travel to Carlin for 200 gold coins?', cid)
        talkState[cid] = 1
        
    elseif msgcontains(msg, 'raccoon') then
        npcHandler:say('Do you wish to travel to Raccoon for 300 gold coins?', cid)
        talkState[cid] = 2
        
    elseif msgcontains(msg, 'tirith') then
        npcHandler:say('Do you wish to travel to Minas Tirith for 400 gold coins?', cid)
        talkState[cid] = 3
        
    elseif msgcontains(msg, 'bree') then
        npcHandler:say('Do you wish to travel to Bree for 500 gold coins?', cid)
        talkState[cid] = 4
        
    elseif state == 1 and msgcontains(msg, 'yes') then
        if player:isPremium() then
            if player:removeMoney(200) then
                player:teleportTo(Position(151, 356, 6))
                Position(151, 356, 6):sendMagicEffect(CONST_ME_TELEPORT)
                Game.createItem(2152, 2, pos)
                npcHandler:say('Have a safe trip!', cid)
            else
                npcHandler:say('Sorry, you don\'t have enough money.', cid)
            end
        else
            npcHandler:say('Sorry, only premium players can travel with me.', cid)
        end
        talkState[cid] = 0
        
    elseif state == 2 and msgcontains(msg, 'yes') then
        if player:isPremium() then
            if player:removeMoney(300) then
                player:teleportTo(Position(209, 74, 6))
                Position(209, 74, 6):sendMagicEffect(CONST_ME_TELEPORT)
                npcHandler:say('Have a safe trip!', cid)
            else
                npcHandler:say('Sorry, you don\'t have enough money.', cid)
            end
        else
            npcHandler:say('Sorry, only premium players can travel with me.', cid)
        end
        talkState[cid] = 0
        
    elseif state == 3 and msgcontains(msg, 'yes') then
        if player:isPremium() then
            if player:removeMoney(400) then
                player:teleportTo(Position(476, 293, 6))
                Position(476, 293, 6):sendMagicEffect(CONST_ME_TELEPORT)
                npcHandler:say('Have a safe trip!', cid)
            else
                npcHandler:say('Sorry, you don\'t have enough money.', cid)
            end
        else
            npcHandler:say('Sorry, only premium players can travel with me.', cid)
        end
        talkState[cid] = 0
        
    elseif state == 4 and msgcontains(msg, 'yes') then
        if player:isPremium() then
            if player:removeMoney(500) then
                player:teleportTo(Position(818, 2030, 6))
                Position(818, 2030, 6):sendMagicEffect(CONST_ME_TELEPORT)
                npcHandler:say('Have a safe trip!', cid)
            else
                npcHandler:say('Sorry, you don\'t have enough money.', cid)
            end
        else
            npcHandler:say('Sorry, only premium players can travel with me.', cid)
        end
        talkState[cid] = 0
        
    elseif msgcontains(msg, 'no') and state > 0 then
        npcHandler:say('I wouldn\'t go there either.', cid)
        talkState[cid] = 0
    end
    
    return true
end

local function onAddFocus(cid)
    talkState[cid] = 0
end

local function onReleaseFocus(cid)
    talkState[cid] = nil
end

npcHandler:setCallback(CALLBACK_ONADDFOCUS, onAddFocus)
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, onReleaseFocus)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

keywordHandler:addKeyword({'destination'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I can take you to Carlin, Raccoon, Minas Tirith and Bree for just a small fee.'})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am the Captain of this ship.'})
keywordHandler:addKeyword({'mission'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Since I got busted by pirates, I never get involved in quests again.'})
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Since I got busted by pirates, I never get involved in quests again.'})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I can take you to Carlin, Raccoon, Minas Tirith and Bree for just a small fee.'})
