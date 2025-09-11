local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addBuyableItem({'amulet of loss', 'aol'}, 2173, 10000, 'amulet of loss')
shopModule:addBuyableItem({'ancient amulet'}, 2142, 1600, 'ancient amulet')
shopModule:addBuyableItem({'broken amulet'}, 2196, 20000, 'broken amulet')
shopModule:addBuyableItem({'bronze amulet'}, 2172, 100, 'bronze amulet')
shopModule:addBuyableItem({'bronzen necklace'}, 2126, 300, 'bronzen necklace')
shopModule:addBuyableItem({'crystal necklace'}, 2125, 250, 'crystal necklace')
shopModule:addBuyableItem({'dragon necklace'}, 2201, 400, 'dragon necklace')
shopModule:addBuyableItem({'garlic necklace'}, 2199, 450, 'garlic necklace')
shopModule:addBuyableItem({'golden amulet'}, 2130, 3000, 'golden amulet')
shopModule:addBuyableItem({'platinum amulet'}, 2171, 3500, 'platinum amulet')
shopModule:addBuyableItem({'protection amulet'}, 2200, 300, 'protection amulet')
shopModule:addBuyableItem({'elven amulet'}, 2198, 500, 'elven amulet')
shopModule:addBuyableItem({'ruby necklace'}, 2133, 2000, 'ruby necklace')
shopModule:addBuyableItem({'scarab amulet'}, 2135, 1300, 'scarab amulet')
shopModule:addBuyableItem({'scarf'}, 2661, 500, 'scarf')
shopModule:addBuyableItem({'silver amulet'}, 2170, 300, 'silver amulet')
shopModule:addBuyableItem({'silver necklace'}, 2132, 1000, 'silver necklace')
shopModule:addBuyableItem({'star amulet'}, 2131, 1200, 'star amulet')
shopModule:addBuyableItem({'stone skin amulet'}, 2197, 3000, 'stone skin amulet')
shopModule:addBuyableItem({'strange symbol'}, 2319, 200, 'strange symbol')
shopModule:addBuyableItem({'strange talisman'}, 2161, 350, 'strange talisman')
shopModule:addBuyableItem({'wolves teeth chain'}, 2129, 50, 'wolves teeth chain')

keywordHandler:addKeyword({'amulets'}, StdModule.say, {npcHandler = npcHandler, text = 'I sell aol (10k), ancient amulet (1.6k), broken amulet (20k), bronze amulet (100gps), bronzen necklace (300gps), crystal necklace (250gps), dragon necklace (400gps), garlic necklace (450gps), golden amulet (3k), platinum amulet (3.5k), protection amulet (300gps), elven amulet (500gps), ruby necklace (2k), scarab amulet (1.3k), scarf (500gps), silver amulet (300gps), silver necklace (1k), star amulet (1.2k), stone skin amulet (3k), strange symbol (200gps), strange talisman (350gps) and wolves teeth chain (50gps).'})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, text = 'I sell all amulets.'})

npcHandler:addModule(FocusModule:new())
