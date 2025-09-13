local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                          npcHandler:onThink() end

-- Shop Module for runes and items
local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

-- Items
shopModule:addBuyableItem({'light wand', 'lightwand'}, 2163, 500, 1, 'magic light wand')
shopModule:addBuyableItem({'blank', 'rune'}, 2260, 10, 1, 'blank rune')

-- Regular Runes (lower charges, cheaper)
shopModule:addBuyableItem({'heavy magic missile', 'hmm'}, 2311, 105, 5, 'heavy magic missile rune')
shopModule:addBuyableItem({'great fireball', 'gfb'}, 2304, 180, 2, 'great fireball rune')
shopModule:addBuyableItem({'explosion', 'expl'}, 2313, 270, 3, 'explosion rune')
shopModule:addBuyableItem({'ultimate healing', 'uh'}, 2273, 150, 1, 'ultimate healing rune')
shopModule:addBuyableItem({'sudden death', 'sd'}, 2268, 330, 1, 'sudden death rune')

-- Decorated/Enhanced Runes (higher charges, more expensive)
shopModule:addBuyableItem({'heavy magic missile dec', 'hmm dec'}, 2311, 1200, 50, 'heavy magic missile dec rune')
shopModule:addBuyableItem({'great fireball dec', 'gfb dec'}, 2304, 2100, 20, 'great fireball dec rune')
shopModule:addBuyableItem({'explosion dec', 'expl dec'}, 2313, 3150, 30, 'explosion dec rune')
shopModule:addBuyableItem({'ultimate healing dec', 'uh dec'}, 2273, 1750, 10, 'ultimate healing dec rune')
shopModule:addBuyableItem({'sudden death dec', 'sd dec'}, 2268, 3850, 10, 'sudden death dec rune')

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local player = Player(cid)
    if not player then
        return false
    end

    if msgcontains(msg, 'dec') or msgcontains(msg, 'decorated') then
        selfSay('I sell enhanced runes with more charges! They cost more but last much longer. Try "hmm dec", "gfb dec", "expl dec", "uh dec", or "sd dec".', cid)
    elseif msgcontains(msg, 'regular') then
        selfSay('I sell regular runes with standard charges at normal prices. Try "hmm", "gfb", "expl", "uh", or "sd".', cid)
    elseif msgcontains(msg, 'comparison') or msgcontains(msg, 'difference') then
        selfSay('Regular runes are cheaper but have fewer charges. Decorated runes cost more but have many more charges - better value for heavy users!', cid)
    elseif msgcontains(msg, 'help') then
        selfSay('I sell both regular and decorated runes. Decorated runes have "dec" after the name and have more charges. Say "offer" to see all items.', cid)
    end

    return true
end

-- Enhanced keywords
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am the owner of this runes shop.'})
keywordHandler:addKeyword({'mission'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I have no missions for you now.'})
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I have no quests for you now.'})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I sell magic runes in both regular and decorated versions, plus light wands and blank runes.'})

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
