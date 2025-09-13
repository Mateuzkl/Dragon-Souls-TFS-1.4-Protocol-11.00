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
    -- Lista completa de outfits masculinos do servidor
    local maleOutfits = {
        962, 964, 966, 968, 970, 972, 974, -- Retro outfits
        128, 129, 130, 131, 132, 133, 134, -- Basic outfits
        143, 144, 145, 146, 151, 152, 153, 154, -- Extended basic
        251, 268, 273, 278, 289, 325, 328, 335, 367, -- Special outfits
        430, 432, 463, 465, 472, 512, 516, 541, 574, 577, -- Premium outfits
        610, 619, 633, 634, 637, 665, 667, 684, 695, 697, 699, -- More premium
        725, 733, 746, 750, 760, 846, 853, 873, 884, 899, 908, -- Advanced outfits
        931, 955, 957, 1021, 1023, 1042, 1051, 1056, 1069, 1094, -- Modern outfits
        1102, 1127, 1146, 1161, 1173, 1186, 1202, 1204, 1206, 1210, -- VIP outfits
        1243, 1245, 1251, 1270, 1279, 1282, 1288, 1292, 1331, 1322, -- Latest outfits
        1338, 1371, 1382, 1384, 1415, 1387, 1437, 1444, 1449, 1457, -- Newest additions
        1460, 1489, 1501, 1568, 1576, 1581, 1597, 1612, 1680, 1618, -- Final additions
        1675, 1662
    }
    
    -- Lista completa de outfits femininos do servidor
    local femaleOutfits = {
        963, 965, 967, 969, 971, 973, 975, -- Retro outfits
        136, 137, 138, 139, 140, 141, 142, -- Basic outfits
        147, 148, 149, 150, 155, 156, 157, 158, -- Extended basic
        252, 269, 270, 279, 288, 324, 329, 336, 366, -- Special outfits
        431, 433, 464, 466, 471, 513, 514, 542, 575, 578, -- Premium outfits
        618, 620, 632, 635, 636, 664, 666, 683, 694, 696, 698, -- More premium
        724, 732, 745, 749, 759, 845, 852, 874, 885, 900, 909, -- Advanced outfits
        929, 956, 958, 1020, 1024, 1043, 1050, 1057, 1070, 1095, -- Modern outfits
        1103, 1128, 1147, 1162, 1174, 1187, 1203, 1205, 1207, 1211, -- VIP outfits
        1244, 1246, 1252, 1271, 1280, 1283, 1289, 1293, 1332, 1323, -- Latest outfits
        1339, 1372, 1383, 1385, 1416, 1386, 1436, 1445, 1450, 1456, -- Newest additions
        1461, 1490, 1500, 1569, 1575, 1582, 1598, 1613, 1681, 1619, -- Final additions
        1676, 1663
    }
    
    -- Adicionar addon para todos os outfits masculinos
    for _, outfitId in ipairs(maleOutfits) do
        player:addOutfitAddon(outfitId, addon)
    end
    
    -- Adicionar addon para todos os outfits femininos
    for _, outfitId in ipairs(femaleOutfits) do
        player:addOutfitAddon(outfitId, addon)
    end
end

function playerHasAnyAddon(player, addon)
    -- Lista completa de outfits masculinos do servidor
    local maleOutfits = {
        962, 964, 966, 968, 970, 972, 974, -- Retro outfits
        128, 129, 130, 131, 132, 133, 134, -- Basic outfits
        143, 144, 145, 146, 151, 152, 153, 154, -- Extended basic
        251, 268, 273, 278, 289, 325, 328, 335, 367, -- Special outfits
        430, 432, 463, 465, 472, 512, 516, 541, 574, 577, -- Premium outfits
        610, 619, 633, 634, 637, 665, 667, 684, 695, 697, 699, -- More premium
        725, 733, 746, 750, 760, 846, 853, 873, 884, 899, 908, -- Advanced outfits
        931, 955, 957, 1021, 1023, 1042, 1051, 1056, 1069, 1094, -- Modern outfits
        1102, 1127, 1146, 1161, 1173, 1186, 1202, 1204, 1206, 1210, -- VIP outfits
        1243, 1245, 1251, 1270, 1279, 1282, 1288, 1292, 1331, 1322, -- Latest outfits
        1338, 1371, 1382, 1384, 1415, 1387, 1437, 1444, 1449, 1457, -- Newest additions
        1460, 1489, 1501, 1568, 1576, 1581, 1597, 1612, 1680, 1618, -- Final additions
        1675, 1662
    }
    
    -- Lista completa de outfits femininos do servidor
    local femaleOutfits = {
        963, 965, 967, 969, 971, 973, 975, -- Retro outfits
        136, 137, 138, 139, 140, 141, 142, -- Basic outfits
        147, 148, 149, 150, 155, 156, 157, 158, -- Extended basic
        252, 269, 270, 279, 288, 324, 329, 336, 366, -- Special outfits
        431, 433, 464, 466, 471, 513, 514, 542, 575, 578, -- Premium outfits
        618, 620, 632, 635, 636, 664, 666, 683, 694, 696, 698, -- More premium
        724, 732, 745, 749, 759, 845, 852, 874, 885, 900, 909, -- Advanced outfits
        929, 956, 958, 1020, 1024, 1043, 1050, 1057, 1070, 1095, -- Modern outfits
        1103, 1128, 1147, 1162, 1174, 1187, 1203, 1205, 1207, 1211, -- VIP outfits
        1244, 1246, 1252, 1271, 1280, 1283, 1289, 1293, 1332, 1323, -- Latest outfits
        1339, 1372, 1383, 1385, 1416, 1386, 1436, 1445, 1450, 1456, -- Newest additions
        1461, 1490, 1500, 1569, 1575, 1582, 1598, 1613, 1681, 1619, -- Final additions
        1676, 1663
    }
    
    -- Verificar outfits masculinos
    for _, outfitId in ipairs(maleOutfits) do
        if player:hasOutfit(outfitId, addon) then
            return true
        end
    end
    
    -- Verificar outfits femininos
    for _, outfitId in ipairs(femaleOutfits) do
        if player:hasOutfit(outfitId, addon) then
            return true
        end
    end
    
    return false
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
        if playerHasAnyAddon(player, 1) then
            selfSay('You already have the first addon! You cannot buy it again.', cid)
            npcHandler.topic[cid] = 0
        else
            selfSay('Do you want to buy the first addon for 5000 gold coins?', cid)
            npcHandler.topic[cid] = 1
        end
        
    elseif msgcontains(msg, 'second addon') then
        if playerHasAnyAddon(player, 2) then
            selfSay('You already have the second addon! You cannot buy it again.', cid)
            npcHandler.topic[cid] = 0
        else
            selfSay('Do you want to buy the second addon for 10000 gold coins?', cid)
            npcHandler.topic[cid] = 2
        end
        
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
