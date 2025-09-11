local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local ADDON_CONFIG = {
    firstAddonPrice = 5000,
    secondAddonPrice = 10000,
    maleOutfitId = 128,
    femaleOutfitId = 136
}

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    if msgcontains(msg, 'first addon') then
        selfSay('Do you want to buy the first addon for 5k?', cid)
        npcHandler.topic[cid] = 1
        
    elseif msgcontains(msg, 'second addon') then
        selfSay('Do you want to buy the second addon for 10k?', cid)
        npcHandler.topic[cid] = 2
        
    elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 1 then
        if player:removeMoney(ADDON_CONFIG.firstAddonPrice) then
            player:addOutfitAddon(ADDON_CONFIG.maleOutfitId, 1)
            player:addOutfitAddon(ADDON_CONFIG.femaleOutfitId, 1)
            selfSay('Here is your first addon!', cid)
        else
            selfSay('Sorry, you don\'t have enough money.', cid)
        end
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 2 then
        if player:removeMoney(ADDON_CONFIG.secondAddonPrice) then
            player:addOutfitAddon(ADDON_CONFIG.maleOutfitId, 2)
            player:addOutfitAddon(ADDON_CONFIG.femaleOutfitId, 2)
            selfSay('Here is your second addon!', cid)
        else
            selfSay('Sorry, you don\'t have enough money.', cid)
        end
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'no') then
        selfSay('Ok then.', cid)
        npcHandler.topic[cid] = 0
    end
    
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

keywordHandler:addKeyword({'addon'}, StdModule.say, {npcHandler = npcHandler, text = 'I sell the first addon for 5k and the second addon for 10k.'})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, text = 'I sell the first addon for 5k and the second addon for 10k.'})
