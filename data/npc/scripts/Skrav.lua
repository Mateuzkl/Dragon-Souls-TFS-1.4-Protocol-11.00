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

    if msgcontains(msg, 'bless') then
        if player:hasBlessing(1) and player:hasBlessing(2) and player:hasBlessing(3) and player:hasBlessing(4) and player:hasBlessing(5) then
            selfSay('Sorry, you already have all blessings.', cid)
        else
            selfSay('Do you want to buy all blessings for 350,000 gold pieces?', cid)
            npcHandler.topic[cid] = 1
        end

    elseif msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
        if talk_state == 1 then
            if player:hasBlessing(1) and player:hasBlessing(2) and player:hasBlessing(3) and player:hasBlessing(4) and player:hasBlessing(5) then
                if msgcontains(msg, 'sim') then
                    selfSay('Voce ja tem todas as bencaos...', cid)
                else
                    selfSay('You already have all blessings...', cid)
                end
            else
                if player:removeTotalMoney(350000) then
                    player:addBlessing(1) -- Twist of Fate
                    player:addBlessing(2) -- Wisdom of Solitude  
                    player:addBlessing(3) -- Spark of the Phoenix
                    player:addBlessing(4) -- Fire of the Suns
                    player:addBlessing(5) -- Spiritual Shielding
                    player:getPosition():sendMagicEffect(CONST_ME_HOLYDAMAGE)
                    
                    if msgcontains(msg, 'sim') then
                        selfSay('Skraviosk concedeu suas bencaos!', cid)
                    else
                        selfSay('Skraviosk blessed you...', cid)
                    end
                else
                    if msgcontains(msg, 'sim') then
                        selfSay('Desculpe, dinheiro insuficiente.', cid)
                    else
                        selfSay('Sorry, you do not have enough money.', cid)
                    end
                end
            end
            npcHandler.topic[cid] = 0
        end

    elseif msgcontains(msg, 'no') or msgcontains(msg, 'nao') then
        if talk_state == 1 then
            if msgcontains(msg, 'nao') then
                selfSay('Algo mais?', cid)
            else
                selfSay('Ok. Do you want something more?', cid)
            end
            npcHandler.topic[cid] = 0
        end

    elseif msgcontains(msg, 'status') then
        selfSay('Hmm... Let me see...', cid)
        
        local blessings = {
            {1, 'Twist of Fate', 'Hersthiop'},
            {2, 'Wisdom of Solitude', 'Arquinothep'}, 
            {3, 'Spark of the Phoenix', 'Skraviosk'},
            {4, 'Fire of the Suns', 'UnHolly'},
            {5, 'Spiritual Shielding', 'God'}
        }
        
        for _, blessing in ipairs(blessings) do
            if player:hasBlessing(blessing[1]) then
                selfSay('You already got the ' .. blessing[3] .. ' blessing.', cid)
            else
                selfSay('You didnt get the ' .. blessing[3] .. ' blessing yet.', cid)
            end
        end

    elseif msgcontains(msg, 'job') then
        selfSay('I can grant you powerful blessings to protect your soul.', cid)

    elseif msgcontains(msg, 'help') then
        selfSay('I can give you all 5 blessings for 350,000 gold. Say "bless" to buy them or "status" to check what you have.', cid)
    end

    return true
end

function onGreet(cid)
    local player = Player(cid)
    if not player then
        return false
    end

    -- Check if player has promoted vocation
    if player:getVocation():getId() >= 5 then
        selfSay('I can only talk to regular vocations.', cid)
        return false
    end
    
    selfSay('Hello, ' .. player:getName() .. '!', cid)
    npcHandler.topic[cid] = 0
    return true
end

function onFarewell(cid)
    local player = Player(cid)
    if not player then
        return false
    end

    -- Different farewell based on blessing status
    if player:hasBlessing(1) and player:hasBlessing(2) and player:hasBlessing(3) and player:hasBlessing(4) and player:hasBlessing(5) then
        selfSay('God will save your Soul, ' .. player:getName() .. '!', cid)
    else
        selfSay('Beware ' .. player:getName() .. '...', cid)
    end
    
    npcHandler.topic[cid] = 0
    return true
end

-- Keywords for blessing information
keywordHandler:addKeyword({'blessing'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I can grant you all 5 blessings for 350,000 gold pieces.'})
keywordHandler:addKeyword({'price'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'All blessings cost 350,000 gold pieces total.'})
keywordHandler:addKeyword({'protection'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Blessings protect you from losing items and experience when you die.'})

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
