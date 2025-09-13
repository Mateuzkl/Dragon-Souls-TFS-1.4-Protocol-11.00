--------------------------------------------------------------------------------------------
------------------------------------ Advanced Addon NPC ------------------------------------
-------------------------------- Script made by teh_pwnage ---------------------------------
--------------- Special thanks to: mokerhamer, Xidaozu and Jiddo, deaths'life --------------
------------------------------- Thanks also to everyone else -------------------------------
------------------------------ Converted for TFS 1.x ------------------------------
--------------------------------------------------------------------------------------------

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
    local petStorage = player:getStorageValue(60000)
    local petLevel = player:getStorageValue(60010)
    
    -- Calculate pet revival price
    local preco = 0
    if petStorage >= 1 and petLevel >= 1 then
        preco = petStorage * 500 * petStorage * petLevel
    end

    if msgcontains(msg, 'job') then
        selfSay('I am the owner of this PetShop.', cid)

    elseif msgcontains(msg, 'offer') then
        selfSay('I can revive your pet.', cid)

    elseif msgcontains(msg, 'sell') then
        selfSay('Sell What?', cid)

    elseif msgcontains(msg, 'buy') then
        selfSay('Sorry but I do not sell those.', cid)

    elseif msgcontains(msg, 'quest') then
        selfSay('I am not getting involved in quests anymore!', cid)

    elseif msgcontains(msg, 'mission') then
        selfSay('I am not getting involved in missions anymore!', cid)

    elseif msgcontains(msg, 'revive') then
        if petStorage >= 1 then
            selfSay('Want revive your pet for ' .. preco .. ' gps?', cid)
            npcHandler.topic[cid] = 500
        else
            selfSay('You dont have any pet.', cid)
            npcHandler.topic[cid] = 0
        end

    elseif talk_state == 500 then
        if msgcontains(msg, 'yes') then
            if petStorage >= 1 then
                if player:getStorageValue(60011) == 2 then
                    if player:isPremium() then
                        if player:removeTotalMoney(preco) then
                            selfSay('Live again!', cid)
                            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce reviveu seu pet.")
                            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
                            player:setStorageValue(60005, 1)
                            player:setStorageValue(60003, 0)
                            player:setStorageValue(60011, 1)
                            npcHandler.topic[cid] = 0
                        else
                            selfSay('Sorry, but you dont have this money!', cid)
                            npcHandler.topic[cid] = 0
                        end
                    else
                        selfSay('Sorry, but only can revive pets of premium accounts.', cid)
                        npcHandler.topic[cid] = 0
                    end
                else
                    selfSay('Sorry, but your pet is alive!', cid)
                    npcHandler.topic[cid] = 0
                end
            else
                selfSay('Sorry, but you dont have a pet!', cid)
                npcHandler.topic[cid] = 0
            end

        elseif msgcontains(msg, 'no') then
            selfSay('Ok then.', cid)
            npcHandler.topic[cid] = 0
        end

    elseif msgcontains(msg, 'no') and (talk_state >= 1 and talk_state <= 34) then
        selfSay('Ok then.', cid)
        npcHandler.topic[cid] = 0
    end

    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
