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
    
    if msgcontains(msg, 'bramun') then
        if player:getLevel() >= 8 and player:getLevel() <= 99 then
            npcHandler:say('Do you wish to travel to Bramun for 500 gold coins?', cid)
            talkState[cid] = 2
        else
            npcHandler:say('I only can travel to there on level 8 to 99.', cid)
        end
        
    elseif msgcontains(msg, 'canudis') then
        if player:getLevel() >= 100 and player:getLevel() <= 199 then
            npcHandler:say('Do you wish to travel to Canudis for 1000 gold coins?', cid)
            talkState[cid] = 3
        else
            npcHandler:say('I only can travel to there on level 100 to 199.', cid)
        end
        
    elseif msgcontains(msg, 'morgun') then
        if player:getLevel() >= 200 and player:getLevel() <= 299 then
            npcHandler:say('Do you wish to travel to Morgun for 2000 gold coins?', cid)
            talkState[cid] = 4
        else
            npcHandler:say('I only can travel to there on level 200 to 299.', cid)
        end
        
    elseif msgcontains(msg, 'mordor') then
        if player:getVocation():getId() > 8 then
            npcHandler:say('Do you wish to travel to Mordor for 5000 gold coins?', cid)
            talkState[cid] = 5
        else
            npcHandler:say('Only Valans can travel to there.', cid)
        end
        
    elseif msgcontains(msg, 'tanoris') then
        if player:getVocation():getId() > 12 then
            npcHandler:say('Do you wish to travel to Tanoris for 100 DSPs?', cid)
            talkState[cid] = 6
        else
            npcHandler:say('Only gods can travel to there.', cid)
        end
        
    elseif state == 2 and msgcontains(msg, 'yes') then
        if player:isPremium() then
            if player:getLevel() >= 8 and player:getLevel() <= 99 then
                if player:removeTotalMoney(500) then
                    player:teleportTo(Position(794, 2058, 6))
                    Position(794, 2058, 6):sendMagicEffect(CONST_ME_TELEPORT)
                    npcHandler:say('Have a safe trip!', cid)
                else
                    npcHandler:say('Sorry, you don\'t have enough money.', cid)
                end
            else
                npcHandler:say('I only can travel to there on level 8 to 99.', cid)
            end
        else
            npcHandler:say('Sorry, only premium players can travel with me.', cid)
        end
        talkState[cid] = 0
        
    elseif state == 3 and msgcontains(msg, 'yes') then
        if player:isPremium() then
            if player:getLevel() >= 100 and player:getLevel() <= 199 then
                if player:removeTotalMoney(1000) then
                    player:teleportTo(Position(753, 1932, 6))
                    Position(753, 1932, 6):sendMagicEffect(CONST_ME_TELEPORT)
                    npcHandler:say('Have a safe trip!', cid)
                else
                    npcHandler:say('Sorry, you don\'t have enough money.', cid)
                end
            else
                npcHandler:say('I only can travel to there on level 100 to 199.', cid)
            end
        else
            npcHandler:say('Sorry, only premium players can travel with me.', cid)
        end
        talkState[cid] = 0
        
    elseif state == 4 and msgcontains(msg, 'yes') then
        if player:isPremium() then
            if player:getLevel() >= 200 and player:getLevel() <= 299 then
                if player:removeTotalMoney(2000) then
                    player:teleportTo(Position(880, 1879, 6))
                    Position(880, 1879, 6):sendMagicEffect(CONST_ME_TELEPORT)
                    npcHandler:say('Have a safe trip!', cid)
                else
                    npcHandler:say('Sorry, you don\'t have enough money.', cid)
                end
            else
                npcHandler:say('I only can travel to there on level 200 to 299.', cid)
            end
        else
            npcHandler:say('Sorry, only premium players can travel with me.', cid)
        end
        talkState[cid] = 0
        
    elseif state == 5 and msgcontains(msg, 'yes') then
        if player:isPremium() then
            if player:getVocation():getId() > 8 then
                if player:removeTotalMoney(5000) then
                    player:teleportTo(Position(1024, 1858, 6))
                    Position(1024, 1858, 6):sendMagicEffect(CONST_ME_TELEPORT)
                    npcHandler:say('Have a safe trip!', cid)
                else
                    npcHandler:say('Sorry, you don\'t have enough money.', cid)
                end
            else
                npcHandler:say('Only Valans can travel to Mordor.', cid)
            end
        else
            npcHandler:say('Sorry, only premium players can travel with me.', cid)
        end
        talkState[cid] = 0
        
    elseif state == 6 and msgcontains(msg, 'yes') then
        if player:isPremium() then
            if player:getVocation():getId() > 12 then
                if player:getItemCount(6527) >= 100 then
                    player:removeItem(6527, 100)
                    player:teleportTo(Position(1093, 1883, 6))
                    Position(1093, 1883, 6):sendMagicEffect(CONST_ME_TELEPORT)
                    npcHandler:say('Have a safe trip!', cid)
                else
                    npcHandler:say('Sorry, you don\'t have enough DSPs.', cid)
                end
            else
                npcHandler:say('Only gods can travel to Tanoris.', cid)
            end
        else
            npcHandler:say('Sorry, only premium players can travel with me.', cid)
        end
        talkState[cid] = 0
        
    elseif msgcontains(msg, 'no') and state >= 2 and state <= 6 then
        npcHandler:say('Ok then.', cid)
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

keywordHandler:addKeyword({'destination'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I can take you to Bramun on level 8 to 99, Canudis on level 100 to 199, Morgun on level 200 to 299 and to Mordor only for Valans and Tanoris for gods.'})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am the Carpet Man!'})
keywordHandler:addKeyword({'mission'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I never get involved in quests.'})
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I never get involved in quests.'})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I can take you to Bramun on level 8 to 99, Canudis on level 100 to 199, Morgun on level 200 to 299 and to Mordor only for Valans and Tanoris for gods.'})
