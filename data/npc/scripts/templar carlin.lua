local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local ADDON_CONFIG = {
    firstAddonCost = 5000,
    secondAddonCost = 10000
}

function doPlayerGiveAddons(player, addon)
    -- Male outfits
    for outfitId = 128, 134 do
        player:addOutfitAddon(outfitId, addon)
    end
    for outfitId = 143, 146 do
        player:addOutfitAddon(outfitId, addon)
    end
    for outfitId = 151, 154 do
        player:addOutfitAddon(outfitId, addon)
    end
    player:addOutfitAddon(251, addon)
    
    -- Female outfits
    for outfitId = 136, 142 do
        player:addOutfitAddon(outfitId, addon)
    end
    for outfitId = 147, 150 do
        player:addOutfitAddon(outfitId, addon)
    end
    for outfitId = 155, 158 do
        player:addOutfitAddon(outfitId, addon)
    end
    player:addOutfitAddon(252, addon)
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    if msgcontains(msg, 'first addon') then
        selfSay('Do you want to buy the first addon for 5000 gold coins?', cid)
        npcHandler.topic[cid] = 1
        
    elseif msgcontains(msg, 'second addon') then
        selfSay('Do you want to buy the second addon for 10000 gold coins?', cid)
        npcHandler.topic[cid] = 2
        
    elseif msgcontains(msg, 'yes') then
        if npcHandler.topic[cid] == 1 then
            if player:removeMoney(ADDON_CONFIG.firstAddonCost) then
                doPlayerGiveAddons(player, 1)
                selfSay('Here you go! Enjoy your first addons.', cid)
            else
                selfSay('Sorry, you don\'t have enough money.', cid)
            end
            npcHandler.topic[cid] = 0
            
        elseif npcHandler.topic[cid] == 2 then
            if player:removeMoney(ADDON_CONFIG.secondAddonCost) then
                doPlayerGiveAddons(player, 2)
                selfSay('Here you go! Enjoy your second addons.', cid)
            else
                selfSay('Sorry, you don\'t have enough money.', cid)
            end
            npcHandler.topic[cid] = 0
        end
        
    elseif msgcontains(msg, 'no') and npcHandler.topic[cid] >= 1 then
        selfSay('Too expensive, eh?', cid)
        npcHandler.topic[cid] = 0
    end
    
    return true
end

function onGreet(cid)
    selfSay('Hello ' .. Player(cid):getName() .. '! I sell the first addon for 5k and the second addon for 10k.', cid)
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:addModule(FocusModule:new())
