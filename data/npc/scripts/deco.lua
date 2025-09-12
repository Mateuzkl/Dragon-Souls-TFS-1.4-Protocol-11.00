local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end
function onThink()                          npcHandler:onThink()                        end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

-- Big Gems
shopModule:addSellableItem({'violet gem', 'violet'}, 2153, 1000, 'violet gem')
shopModule:addSellableItem({'yellow gem', 'yellow'}, 2154, 1000, 'yellow gem')
shopModule:addSellableItem({'green gem', 'green'}, 2155, 1000, 'green gem')
shopModule:addSellableItem({'red gem', 'red'}, 2156, 1000, 'red gem')
shopModule:addSellableItem({'blue gem', 'blue'}, 2158, 1000, 'blue gem')

-- Small Gems (100 pieces)
shopModule:addSellableItem({'talons'}, 2151, 5000, 100, 'talon')
shopModule:addSellableItem({'small rubies'}, 2147, 5000, 100, 'small ruby')
shopModule:addSellableItem({'small emeralds'}, 2149, 5000, 100, 'small emerald')
shopModule:addSellableItem({'small diamonds'}, 2145, 5000, 100, 'small diamond')
shopModule:addSellableItem({'small amethysts'}, 2150, 5000, 100, 'small amethyst')
shopModule:addSellableItem({'small sapphires'}, 2146, 5000, 100, 'small sapphire')
shopModule:addSellableItem({'black pearls'}, 2144, 5000, 100, 'black pearl')
shopModule:addSellableItem({'white pearls'}, 2143, 5000, 100, 'white pearl')

-- Misc Decoration
shopModule:addSellableItem({'blood herb'}, 2798, 1000, 'blood herb')
shopModule:addSellableItem({'coconuts'}, 2678, 5000, 100, 'coconut')
shopModule:addSellableItem({'snowballs'}, 2111, 10000, 100, 'snowball')
shopModule:addSellableItem({'teddy bear'}, 2326, 10000, 'teddy bear')
shopModule:addSellableItem({'nuggets', 'gold nuggets'}, 2157, 10000, 100, 'gold nugget')

local function creatureSayCallback(cid, msgType, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    
    if msgcontains(msg, 'big gems') then
        npcHandler:say('I sell Violet (1k), Yellow (1k), Green (1k), Red (1k) and Blue Gems (1k).', cid)
    elseif msgcontains(msg, 'misc') then
        npcHandler:say('I sell Blood Herbs (1k), 100 Coconuts (5k), 100 Snowballs (10k), 100 Gold Nuggets (10k), and Teddy Bears (10k).', cid)
    elseif msgcontains(msg, 'gems') then
        npcHandler:say('I sell 100 Talons (5k), 100 Small Rubies (5k), 100 Small Emeralds (5k), 100 Small Diamonds (5k), 100 Small Amethysts (5k), 100 Small Sapphires (5k), 100 Black Pearls (5k) and 100 White Pearls (5k).', cid)
    end
    
    return true
end

keywordHandler:addKeyword({'offer'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I sell Gems, Big Gems and Misc Decoration!'
})

npcHandler:setMessage(MESSAGE_GREET, 'Hello |PLAYERNAME|! I sell Gems, Big Gems and Misc Decoration!')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye then.')
npcHandler:setMessage(MESSAGE_DECLINE, 'Sorry, |PLAYERNAME|! I talk to you in a minute.')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
