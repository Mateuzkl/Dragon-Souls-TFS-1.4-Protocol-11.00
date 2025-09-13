local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                          npcHandler:onThink() end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local player = Player(cid)
    if not player then
        return false
    end

    local talk_state = npcHandler.topic[cid] or 0

    if msgcontains(msg, 'promotion') or msgcontains(msg, 'promote') then
        if player:getVocation():getId() > 4 then
            selfSay('Sorry, you are already promoted.', cid)
            npcHandler.topic[cid] = 0
        elseif player:getLevel() < 20 then
            selfSay('Sorry, you need level 20 to buy promotion.', cid)
            npcHandler.topic[cid] = 0
        elseif not player:isPremium() then
            selfSay('Sorry, you must be premium to buy promotion.', cid)
            npcHandler.topic[cid] = 0
        else
            selfSay('Do you want to buy promotion for 20k?', cid)
            npcHandler.topic[cid] = 1
        end

    elseif msgcontains(msg, 'premium') or msgcontains(msg, 'premmy') then
        selfSay('Do you want to buy 7 days of premium for 7k?', cid)
        npcHandler.topic[cid] = 2

    elseif msgcontains(msg, 'yes') and talk_state == 1 then
        if player:removeTotalMoney(20000) then
            local currentVocation = player:getVocation():getId()
            player:setVocation(Vocation(currentVocation + 4))
            selfSay('You are now promoted!', cid)
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_BLUE)
        else
            selfSay('Sorry, you do not have enough money.', cid)
        end
        npcHandler.topic[cid] = 0

    elseif msgcontains(msg, 'yes') and talk_state == 2 then
        if player:removeTotalMoney(7000) then
            player:addPremiumDays(7)
            selfSay('You have 7 days of premium more!', cid)
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
        else
            selfSay('Sorry, you do not have enough money.', cid)
        end
        npcHandler.topic[cid] = 0

    elseif msgcontains(msg, 'no') and (talk_state == 1 or talk_state == 2) then
        selfSay('Maybe another time then.', cid)
        npcHandler.topic[cid] = 0

    elseif msgcontains(msg, 'job') then
        selfSay('I sell premium accounts and promotions for adventurers.', cid)

    elseif msgcontains(msg, 'help') then
        selfSay('I can sell you premium time or promote your character if you meet the requirements.', cid)
    end

    return true
end

function onGreet(cid)
    local player = Player(cid)
    if not player then
        return false
    end
    
    selfSay('Hello ' .. player:getName() .. '! I sell premiums and promotions.', cid)
    npcHandler.topic[cid] = 0
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
