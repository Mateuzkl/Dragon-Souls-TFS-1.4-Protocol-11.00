local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

-- Helmets
shopModule:addSellableItem({'demon helmet'}, 2498, 80000, 'demon helmet')
shopModule:addSellableItem({'royal helmet'}, 2498, 40000, 'royal helmet')
shopModule:addSellableItem({'warrior helmet'}, 2475, 6000, 'warrior helmet')
shopModule:addSellableItem({'crusader helmet'}, 2497, 9000, 'crusader helmet')
shopModule:addSellableItem({'crown helmet'}, 2491, 5000, 'crown helmet')
shopModule:addSellableItem({'devil helmet'}, 2462, 4000, 'devil helmet')
shopModule:addSellableItem({'mystic turban'}, 2663, 500, 'mystic turban')
shopModule:addSellableItem({'chain helmet'}, 2458, 35, 'chain helmet')
shopModule:addSellableItem({'iron helmet'}, 2459, 30, 'iron helmet')

-- Boots
shopModule:addSellableItem({'golden boots'}, 2646, 100000, 'golden boots')
shopModule:addSellableItem({'steel boots'}, 2645, 40000, 'steel boots')
shopModule:addSellableItem({'boots of haste', 'boh'}, 2195, 40000, 'boots of haste')

-- Armors
shopModule:addSellableItem({'magic plate armor', 'mpa'}, 2472, 100000, 'magic plate armor')
shopModule:addSellableItem({'dragon scale mail', 'dsm'}, 2492, 60000, 'dragon scale mail')
shopModule:addSellableItem({'demon armor'}, 2494, 90000, 'demon armor')
shopModule:addSellableItem({'golden armor'}, 2466, 30000, 'golden armor')
shopModule:addSellableItem({'crown armor'}, 2487, 20000, 'crown armor')
shopModule:addSellableItem({'knight armor'}, 2476, 5000, 'knight armor')
shopModule:addSellableItem({'blue robe'}, 2656, 15000, 'blue robe')
shopModule:addSellableItem({'lady armor'}, 2500, 7500, 'lady armor')
shopModule:addSellableItem({'plate armor'}, 2463, 400, 'plate armor')
shopModule:addSellableItem({'brass armor'}, 2465, 200, 'brass armor')
shopModule:addSellableItem({'chain armor'}, 2464, 100, 'chain armor')

-- Legs
shopModule:addSellableItem({'golden legs'}, 2470, 80000, 'golden legs')
shopModule:addSellableItem({'crown legs'}, 2488, 15000, 'crown legs')
shopModule:addSellableItem({'knight legs'}, 2477, 6000, 'knight legs')
shopModule:addSellableItem({'plate legs'}, 2647, 500, 'plate legs')
shopModule:addSellableItem({'brass legs'}, 2478, 100, 'brass legs')
shopModule:addSellableItem({'chain legs'}, 2648, 50, 'chain legs')

-- Shields
shopModule:addSellableItem({'blessed shield'}, 2523, 150000, 'blessed shield')
shopModule:addSellableItem({'great shield'}, 2522, 100000, 'great shield')
shopModule:addSellableItem({'shield of the mastermind', 'mms'}, 2514, 80000, 'shield of the mastermind')
shopModule:addSellableItem({'demon shield'}, 2520, 40000, 'demon shield')
shopModule:addSellableItem({'vampire shield'}, 2534, 25000, 'vampire shield')
shopModule:addSellableItem({'medusa shield'}, 2536, 8000, 'medusa shield')
shopModule:addSellableItem({'crown shield'}, 2519, 5000, 'crown shield')
shopModule:addSellableItem({'amazon shield'}, 2537, 4000, 'amazon shield')
shopModule:addSellableItem({'tower shield'}, 2528, 4000, 'tower shield')
shopModule:addSellableItem({'dragon shield'}, 2516, 3000, 'dragon shield')
shopModule:addSellableItem({'guardian shield'}, 2515, 2000, 'guardian shield')
shopModule:addSellableItem({'beholder shield'}, 2518, 1500, 'beholder shield')
shopModule:addSellableItem({'dwarven shield'}, 2525, 100, 'dwarven shield')

-- Swords
shopModule:addSellableItem({'magic longsword'}, 2390, 150000, 'magic longsword')
shopModule:addSellableItem({'warlord sword'}, 2408, 100000, 'warlord sword')
shopModule:addSellableItem({'magic sword'}, 2400, 90000, 'magic sword')
shopModule:addSellableItem({'giant sword'}, 2393, 10000, 'giant sword')
shopModule:addSellableItem({'bright sword'}, 2407, 6000, 'bright sword')
shopModule:addSellableItem({'ice rapier'}, 2396, 4000, 'ice rapier')
shopModule:addSellableItem({'fire sword'}, 2392, 3000, 'fire sword')
shopModule:addSellableItem({'serpent sword'}, 2409, 1500, 'serpent sword')
shopModule:addSellableItem({'spike sword'}, 2383, 800, 'spike sword')
shopModule:addSellableItem({'two handed sword'}, 2377, 400, 'two handed sword')
shopModule:addSellableItem({'broad sword'}, 2413, 70, 'broad sword')
shopModule:addSellableItem({'short sword'}, 2406, 30, 'short sword')
shopModule:addSellableItem({'sabre'}, 2385, 25, 'sabre')
shopModule:addSellableItem({'sword'}, 2376, 25, 'sword')

-- Axes
shopModule:addSellableItem({'stonecutters axe'}, 2431, 90000, 'stonecutters axe')
shopModule:addSellableItem({'dragon lance'}, 2414, 10000, 'dragon lance')
shopModule:addSellableItem({'fire axe'}, 2432, 10000, 'fire axe')
shopModule:addSellableItem({'guardian halberd'}, 2427, 7500, 'guardian halberd')
shopModule:addSellableItem({'knight axe'}, 2430, 2000, 'knight axe')
shopModule:addSellableItem({'double axe'}, 2387, 200, 'double axe')
shopModule:addSellableItem({'halberd'}, 2381, 200, 'halberd')
shopModule:addSellableItem({'battle axe'}, 2378, 100, 'battle axe')
shopModule:addSellableItem({'hatchet'}, 2388, 20, 'hatchet')

-- Clubs
shopModule:addSellableItem({'thunder hammer'}, 2421, 90000, 'thunder hammer')
shopModule:addSellableItem({'skull staff'}, 2436, 10000, 'skull staff')
shopModule:addSellableItem({'war hammer'}, 2391, 6000, 'war hammer')
shopModule:addSellableItem({'dragon hammer'}, 2434, 2000, 'dragon hammer')
shopModule:addSellableItem({'clerical mace'}, 2423, 200, 'clerical mace')
shopModule:addSellableItem({'battle hammer'}, 2417, 60, 'battle hammer')
shopModule:addSellableItem({'mace'}, 2398, 30, 'mace')

-- Amulets
shopModule:addSellableItem({'platinum amulet'}, 2171, 5000, 'platinum amulet')
shopModule:addSellableItem({'scarf'}, 2661, 1000, 'scarf')

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    if msgcontains(msg, 'helmets') then
        selfSay('I buy demon (80k), royal (40k), warrior (6k), crusader (9k), crown (5k), devil (4k), chain (35gp) and iron helmets (30gp), also mystic turbans (500gp).', cid)
        
    elseif msgcontains(msg, 'boots') then
        selfSay('I buy golden boots (100k), steel boots (40k) and boots of haste (40k).', cid)
        
    elseif msgcontains(msg, 'armors') then
        selfSay('I buy golden (30k), crown (20k), knight (5k), lady (7.5k), plate (400gp), brass (200gp) and chain armors (100gp), also mpa (100k), dsm (60k) and blue robes (15k).', cid)
        
    elseif msgcontains(msg, 'legs') then
        selfSay('I buy golden (80k), crown (15k), knight (6k), plate (500gp), brass (100gp) and chain legs (50gp).', cid)
        
    elseif msgcontains(msg, 'shields') then
        selfSay('I buy blessed (150k), great (100k), demon (40k), vampire (25k), medusa (8k), amazon (4k), crown (5k), tower (4k), dragon (3k), guardian (2k), beholder (1.5k), and dwarven shields (100gp), also mms (80k)', cid)
        
    elseif msgcontains(msg, 'swords') then
        selfSay('I buy giant (10k), bright (6k), fire (3k) serpent (1.5k), spike (800gp) and two handed swords (400gp), also ice rapiers (4k), magic longswords (150k), magic swords (90k), warlord swords (100k) broad swords (70gp), short swords (30gp), sabres (25gp) and swords (25gp).', cid)
        
    elseif msgcontains(msg, 'axes') then
        selfSay('I buy fire (10k), guardian halberds (7.5k) knight (2k), double (200gp) and battle axes (100gp), also dragon lances (10k), stonecutters axes (90k), halberds (200gp) and hatchets (20gp).', cid)
        
    elseif msgcontains(msg, 'clubs') then
        selfSay('I buy thunder hammers (90k), war (6k), dragon (2k) and battle hammers (60gp), also skull staffs (10k) and clerical maces (200gp).', cid)
        
    elseif msgcontains(msg, 'amulets') then
        selfSay('I buy platinum amulets (5k) and scarfs (1k).', cid)
        
    elseif msgcontains(msg, 'offer') or msgcontains(msg, 'trade') then
        selfSay('I buy swords, clubs, axes, helmets, boots, legs, shields and armors. Ask me about any category for details!', cid)
    end
    
    return true
end

function onGreet(cid)
    local player = Player(cid)
    if player then
        selfSay('Hello ' .. player:getName() .. '! I buy swords, clubs, axes, helmets, boots, legs, shields and armors.', cid)
    end
    return true
end

function onFarewell(cid)
    local player = Player(cid)
    if player then
        selfSay('Good bye, ' .. player:getName() .. '!', cid)
    end
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)
npcHandler:addModule(FocusModule:new())
