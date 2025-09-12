local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end
function onThink()                          npcHandler:onThink()                        end

local shopItems = {
    -- Swords
    ['dagger'] = {id = 3205, price = 5, name = 'Dagger'},
    ['combat knife'] = {id = 3230, price = 7, name = 'Combat Knife'},
    ['silver dagger'] = {id = 3228, price = 10, name = 'Silver Dagger'},
    ['short sword'] = {id = 3232, price = 15, name = 'Short Sword'},
    ['sabre'] = {id = 3211, price = 17, name = 'Sabre'},
    ['bone sword'] = {id = 3276, price = 20, name = 'Bone Sword'},
    ['carlin sword'] = {id = 3221, price = 22, name = 'Carlin Sword'},
    ['heavy machete'] = {id = 3268, price = 35, name = 'Heavy Machete'},
    ['katana'] = {id = 3238, price = 40, name = 'Katana'},
    ['longsword'] = {id = 3223, price = 50, name = 'Longsword'},
    ['poison dagger'] = {id = 3237, price = 60, name = 'Poison Dagger'},
    ['scimitar'] = {id = 3245, price = 75, name = 'Scimitar'},
    ['broad sword'] = {id = 3239, price = 150, name = 'Broad Sword'},
    ['templar scytheblade'] = {id = 3283, price = 250, name = 'Templar Scytheblade'},
    ['serpent sword'] = {id = 3235, price = 300, name = 'Serpent Sword'},
    ['two-handed sword'] = {id = 3203, price = 400, name = 'Two-handed Sword'},
    ['ice rapier'] = {id = 3222, price = 1500, name = 'Ice Rapier'},
    ['fire sword'] = {id = 3218, price = 2500, name = 'Fire Sword'},
    ['bright sword'] = {id = 3233, price = 7500, name = 'Bright Sword'},
    ['giant sword'] = {id = 3219, price = 10000, name = 'Giant Sword'},
    ['magic sword'] = {id = 3226, price = 75000, name = 'Magic Sword'},
    ['warlord sword'] = {id = 3234, price = 125000, name = 'Warlord Sword'},
    ['magic long sword'] = {id = 3216, price = 200000, name = 'Magic Long Sword'},
    
    -- Clubs
    ['club'] = {id = 3208, price = 2, name = 'Club'},
    ['scythe'] = {id = 3391, price = 5, name = 'Scythe'},
    ['studded club'] = {id = 3274, price = 7, name = 'Studded Club'},
    ['bone club'] = {id = 3275, price = 12, name = 'Bone Club'},
    ['mace'] = {id = 3224, price = 15, name = 'Mace'},
    ['iron hammer'] = {id = 3248, price = 40, name = 'Iron Hammer'},
    ['daramanian mace'] = {id = 3265, price = 50, name = 'Daramanian Mace'},
    ['crowbar'] = {id = 3242, price = 50, name = 'Crowbar'},
    ['battle hammer'] = {id = 3146, price = 60, name = 'Battle Hammer'},
    ['morning star'] = {id = 3220, price = 75, name = 'Morning Star'},
    ['clerical mace'] = {id = 3249, price = 200, name = 'Clerical Mace'},
    ['banana staff'] = {id = 3286, price = 250, name = 'Banana Staff'},
    ['dragon hammer'] = {id = 3260, price = 1500, name = 'Dragon Hammer'},
    ['war hammer'] = {id = 3217, price = 2500, name = 'War Hammer'},
    ['skull staff'] = {id = 3262, price = 5000, name = 'Skull Staff'},
    ['magic staff'] = {id = 3259, price = 7500, name = 'Magic Staff'},
    ['crystal mace'] = {id = 3271, price = 20000, name = 'Crystal Mace'},
    ['silver mace'] = {id = 3250, price = 40000, name = 'Silver Mace'},
    ['hammer of wrath'] = {id = 3270, price = 50000, name = 'Hammer of Wrath'},
    ['thunder hammer'] = {id = 3247, price = 75000, name = 'Thunder Hammer'},
    
    -- Axes
    ['hand axe'] = {id = 3206, price = 5, name = 'Hand Axe'},
    ['hatchet'] = {id = 3214, price = 15, name = 'Hatchet'},
    ['orcish axe'] = {id = 3254, price = 200, name = 'Orcish Axe'},
    ['hunting spear'] = {id = 3285, price = 250, name = 'Hunting Spear'},
    ['battle axe'] = {id = 3204, price = 300, name = 'Battle Axe'},
    ['obsidian lance'] = {id = 3251, price = 300, name = 'Obsidian Lance'},
    ['barbarian axe'] = {id = 3255, price = 400, name = 'Barbarian Axe'},
    ['double axe'] = {id = 3213, price = 400, name = 'Double Axe'},
    ['golden sickle'] = {id = 3244, price = 500, name = 'Golden Sickle'},
    ['ripper lance'] = {id = 3284, price = 1000, name = 'Ripper Lance'},
    ['knight axe'] = {id = 3256, price = 1500, name = 'Knight Axe'},
    ['naginata'] = {id = 3252, price = 5000, name = 'Naginata'},
    ['fire axe'] = {id = 3258, price = 6000, name = 'Fire Axe'}
}

local topicList = {
    NONE = 0,
    SELL_ITEM = 1
}

local currentItem = {}
local currentPrice = {}

local function greetCallback(cid)
    local player = Player(cid)
    npcHandler:say('Hiho ' .. player:getName() .. '! I buy ALL equipments: Shields, Helmets, Legs, Armors, Weapons, Amulets and Rings. Also I\'m buying Pearls, etc. Say the name of the item what you want and I will buy from you!', cid)
    return true
end

local function farewellCallback(cid)
    npcHandler:say('Good Bye.', cid)
    return true
end

local function creatureSayCallback(cid, msgType, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    
    if msgcontains(msg, 'swords list') then
        npcHandler:say('I buy Combat Knife, Silver Dagger, Short Sword, Sabre, Bone Sword, Carlin Sword, Heavy Machete, Katana, Long Sword, Poison Dagger, Scimitar, Templar Scytheblade, Broad Sword, Serpent Sword, Two-Handed Sword, Fire Sword, Bright Sword, Giant Sword, Magic Sword, Warlord Sword, Magic Long Sword, Ice Rapier.', cid)
        npcHandler.topic[cid] = topicList.NONE
    elseif msgcontains(msg, 'clubs list') then
        npcHandler:say('I buy Crowbar, Scythe, Studded Club, Bone Club, Iron Hammer, Daramanian Mace, Battle Hammer, Morning Star, Banana Staff, Clerical Mace, Dragon Hammer, Skull Staff, Crystal Mace, Silver Mace, War Hammer, Hammer of Wrath, Thunder Hammer and Magic Staff.', cid)
        npcHandler.topic[cid] = topicList.NONE
    elseif msgcontains(msg, 'axes list') then
        npcHandler:say('I buy Hand Axe, Golden Sickle, Hatchet, Hunting Spear, Orcish Axe, Battle Axe, Ripper Lance, Barbarian Axe, Knight Axe, Obsidian Lance, Double Axe, Halberd, Fire Axe, Naginata, Daramanian Waraxe, Guardian Halberd, Dragon Lance, Stonecutter Axe and Great Axe.', cid)
        npcHandler.topic[cid] = topicList.NONE
    else
        -- Check if player mentioned any item
        for keyword, itemData in pairs(shopItems) do
            if msgcontains(msg, keyword) then
                currentItem[cid] = itemData.id
                currentPrice[cid] = itemData.price
                npcHandler:say('Do you want to sell a ' .. itemData.name .. ' for ' .. itemData.price .. ' Gold Coins?', cid)
                npcHandler.topic[cid] = topicList.SELL_ITEM
                return true
            end
        end
        
        if npcHandler.topic[cid] == topicList.SELL_ITEM and msgcontains(msg, 'yes') then
            if player:getItemCount(currentItem[cid]) >= 1 then
                player:removeItem(currentItem[cid], 1)
                player:addMoney(currentPrice[cid])
                npcHandler:say('Thank you! Here is your money.', cid)
            else
                npcHandler:say('You don\'t have this item.', cid)
            end
            npcHandler.topic[cid] = topicList.NONE
            currentItem[cid] = nil
            currentPrice[cid] = nil
        elseif npcHandler.topic[cid] == topicList.SELL_ITEM and msgcontains(msg, 'no') then
            npcHandler:say('Maybe another time.', cid)
            npcHandler.topic[cid] = topicList.NONE
            currentItem[cid] = nil
            currentPrice[cid] = nil
        end
    end
    
    return true
end

npcHandler:setMessage(MESSAGE_GREET, 'Hiho |PLAYERNAME|! I buy ALL equipments: Shields, Helmets, Legs, Armors, Weapons, Amulets and Rings. Also I\'m buying Pearls, etc. Say the name of the item what you want and I will buy from you!')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good Bye.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good Bye.')
npcHandler:setMessage(MESSAGE_DECLINE, 'Wait Please.')

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_FAREWELL, farewellCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
