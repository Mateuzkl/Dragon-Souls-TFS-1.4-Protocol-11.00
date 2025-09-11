local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local ADDON_CONFIG = {
    beggarStorage = 51003,
    beggarStaff = 6107
}

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    local addon = player:getStorageValue(ADDON_CONFIG.beggarStorage)
    local needPremium = 'Sorry, you need a premium account to get addons.'
    local alreadyHave = 'Sorry, you already have this addon, now get out of here!'
    
    if msgcontains(msg, 'job') then
        selfSay('I am the leader of this place, but I aint got jobs for you, human!', cid)
        
    elseif msgcontains(msg, 'offer') then
        selfSay('Hmm... Now I don\'t have nothing ready!', cid)
        
    elseif msgcontains(msg, 'sell') then
        selfSay('I don\'t have nothing already done!', cid)
        
    elseif msgcontains(msg, 'buy') then
        selfSay('Nah...', cid)
        
    elseif msgcontains(msg, 'quest') then
        selfSay('I am not getting involved in quests anymore, too old for that!', cid)
        
    elseif msgcontains(msg, 'mission') then
        selfSay('I am not getting involved in missions anymore!', cid)
        
    elseif msgcontains(msg, 'knowledge') then
        selfSay('I have been on long trips and quests! One more dangerous than the other, now I am just takin care of here!', cid)
        
    elseif msgcontains(msg, 'addon') then
        selfSay('Huh, I am the leader here! Thats why I am using it! Its called Beggar staff!', cid)
        
    elseif msgcontains(msg, 'beggar staff') and addon == 2 then
        selfSay('It seems that you already got one! Leave me ALONE!!', cid)
        
    elseif msgcontains(msg, 'beggar staff') and addon == -1 then
        if player:isPremium() then
            selfSay('A really new and innovative look would be - the poor man\'s look! I can already see it in front of me... yes... a little ragged... but not too shabby!...', cid)
            selfSay('Let me see... I can do one staff for you... but before, you gotta look for my staff!! Can you bring it to me?', cid)
            npcHandler.topic[cid] = 1
        else
            selfSay(needPremium, cid)
            npcHandler.topic[cid] = 0
        end
        
    elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 1 then
        selfSay('Terrific! What are you waiting for?!! Start right away to gather your staff and get your outfit!!', cid)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "New quest added '(Addon) Beggar staff.'")
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
        player:setStorageValue(ADDON_CONFIG.beggarStorage, 1)
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'beggar staff') and addon == 1 then
        if player:isPremium() then
            selfSay('Ah! Have found the staff? Incredible! I will immediately start to work on this outfit! What about that?', cid)
            npcHandler.topic[cid] = 2
        else
            selfSay(needPremium, cid)
            npcHandler.topic[cid] = 0
        end
        
    elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 2 then
        if player:getItemCount(ADDON_CONFIG.beggarStaff) >= 1 then
            player:removeItem(ADDON_CONFIG.beggarStaff, 1)
            player:addOutfitAddon(153, 2)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Quest '(Addon) Beggar Staff.' completed.")
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
            player:setStorageValue(ADDON_CONFIG.beggarStorage, 2)
            selfSay('This is it! Alas, the poor man\'s outfit is finished, but... to be honest... it turned out much less appealing than I expected. However, you can use it if you want, okay?', cid)
            npcHandler.topic[cid] = 0
        else
            selfSay('I knew that it was a lie! Where is it?', cid)
            npcHandler.topic[cid] = 0
        end
        
    elseif msgcontains(msg, 'no') and npcHandler.topic[cid] >= 1 then
        selfSay('Ok then.', cid)
        npcHandler.topic[cid] = 0
    end
    
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
