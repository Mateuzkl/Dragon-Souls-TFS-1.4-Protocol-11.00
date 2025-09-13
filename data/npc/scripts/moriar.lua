--------------------------------------------------------------------------------------------
------------------------------------ Advanced Addon NPC ------------------------------------
-------------------------------- Script made by teh_pwnage ---------------------------------
--------------- Special thanks to: mokerhamer, Xidaozu and Jiddo, deaths'life --------------
------------------------------- Thanks also to everyone else -------------------------------
------------------------------ NPC converted for TFS 1.x ------------------------------
--------------------------------------------------------------------------------------------

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                          npcHandler:onThink() end

function creatureSayCallback(cid, type, msg)
    if(npcHandler.focus ~= cid) then
        return false
    end

    local player = Player(cid)
    if not player then
        return false
    end

    local talk_state = npcHandler.topic[cid] or 0
    local post = player:getStorageValue(2078)

    if msgcontains(msg, 'delivery') and post == 0 then
        selfSay('What tha hec... It\'s empty! I will talk about your work with your boss!', cid)
        player:removeItem(1993, 1)
        talk_state = 0

    elseif msgcontains(msg, 'job') then
        selfSay('I fish something in our ice rivers!', cid)

    elseif msgcontains(msg, 'offer') then
        selfSay('I am not selling or buying nothing!', cid)

    elseif msgcontains(msg, 'sell') then
        selfSay('Haha, sorry, not today!', cid)

    elseif msgcontains(msg, 'buy') then
        selfSay('No, no merchant', cid)

    elseif msgcontains(msg, 'quest') then
        selfSay('Not involved.. you know!', cid)

    elseif msgcontains(msg, 'mission') then
        selfSay('Not involved.. you know!', cid)

    -- postman
    elseif msgcontains(msg, 'delivery') and post == 9 then
        if player:getItemCount(2330) >= 1 then
            selfSay('Oh, thanks god, i will really need this, talk with your boss about promotion, you deserve it, here is something for you.', cid)
            player:addItem(2152, 4)
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
            player:setStorageValue(2078, 10)
            player:removeItem(2330, 1)
            talk_state = 0
        else
            selfSay('So where is my delivery?', cid)
        end

    ------------------------------------------------ confirm no ------------------------------------------------
    elseif msgcontains(msg, 'no') and (talk_state >= 1 and talk_state <= 34) then
        selfSay('Ok then.', cid)
        talk_state = 0
    end

    npcHandler.topic[cid] = talk_state
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
