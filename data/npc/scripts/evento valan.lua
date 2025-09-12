local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end
function onThink()                          npcHandler:onThink()                        end

local topicList = {
    NONE = 0,
    VOCATION_SELECT = 1
}

local function greetCallback(cid)
    local player = Player(cid)
    npcHandler:say('Hello ' .. player:getName() .. '! I can change you on "valan", What you want here?', cid)
    return true
end

local function farewellCallback(cid)
    local player = Player(cid)
    npcHandler:say('Good bye, back here when you ready ' .. player:getName() .. '!', cid)
    return true
end

local function creatureSayCallback(cid, msgType, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    local level = player:getLevel()
    
    if msgcontains(msg, 'valan') then
        if player:isPremium() then
            if level == 8 then
                if player:getMagicLevel() == 0 then
                    npcHandler:say('Se voce tem certeza disso tudo bem, qual vocacao voce deseja? "Wyzard", "Cleric", "Ranger" ou "Slayer"?', cid)
                    npcHandler.topic[cid] = topicList.VOCATION_SELECT
                else
                    npcHandler:say('Sorry, you need magic level 0 to turn a valan!', cid)
                    npcHandler:releaseFocus(cid)
                end
            else
                npcHandler:say('Sorry, you need level 8 to turn a valan!', cid)
                npcHandler:releaseFocus(cid)
            end
        else
            npcHandler:say('Sorry, only premium accounts can turn a valan!', cid)
            npcHandler:releaseFocus(cid)
        end
    elseif npcHandler.topic[cid] == topicList.VOCATION_SELECT then
        if msgcontains(msg, 'wyzard') then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You are now a wyzard!")
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
            player:setVocation(Vocation(9))
            npcHandler:releaseFocus(cid)
        elseif msgcontains(msg, 'cleric') then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You are now a cleric!")
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
            player:setVocation(Vocation(10))
            npcHandler:releaseFocus(cid)
        elseif msgcontains(msg, 'ranger') then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You are now a ranger!")
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
            player:setVocation(Vocation(11))
            npcHandler:releaseFocus(cid)
        elseif msgcontains(msg, 'slayer') then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You are now a slayer!")
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
            player:setVocation(Vocation(12))
            npcHandler:releaseFocus(cid)
        end
        npcHandler.topic[cid] = topicList.NONE
    end
    
    return true
end

npcHandler:setMessage(MESSAGE_GREET, 'Hello |PLAYERNAME|! I can change you on "valan", What you want here?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, back here when you ready |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye then.')
npcHandler:setMessage(MESSAGE_DECLINE, 'Sorry, |PLAYERNAME|! I talk to you in a minute.')

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_FAREWELL, farewellCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
