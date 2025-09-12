local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end
function onThink()                          npcHandler:onThink()                        end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

-- Chairs
shopModule:addSellableItem({'wooden chair'}, 3901, 500, 'wooden chair')
shopModule:addSellableItem({'sofa chair'}, 3902, 500, 'sofa chair')
shopModule:addSellableItem({'red cushioned chair'}, 3903, 500, 'red cushioned chair')
shopModule:addSellableItem({'green cushioned chair'}, 3904, 500, 'green cushioned chair')
shopModule:addSellableItem({'tusk chair'}, 3905, 500, 'tusk chair')
shopModule:addSellableItem({'ivory chair'}, 3906, 500, 'ivory chair')

-- Tables
shopModule:addSellableItem({'big table'}, 3909, 500, 'big table')
shopModule:addSellableItem({'square table'}, 3910, 500, 'square table')
shopModule:addSellableItem({'round table'}, 3911, 500, 'round table')
shopModule:addSellableItem({'small table'}, 3912, 500, 'small table')
shopModule:addSellableItem({'stone table'}, 3913, 500, 'stone table')
shopModule:addSellableItem({'tusk table'}, 3914, 500, 'tusk table')
shopModule:addSellableItem({'bamboo table'}, 3919, 500, 'bamboo table')

-- Plants
shopModule:addSellableItem({'pink flower'}, 3928, 500, 'pink flower')
shopModule:addSellableItem({'green flower'}, 3929, 500, 'green flower')
shopModule:addSellableItem({'christmas tree'}, 3931, 500, 'christmas tree')

-- Containers
shopModule:addSellableItem({'large trunk'}, 3938, 500, 'large trunk')
shopModule:addSellableItem({'drawer'}, 3921, 500, 'drawer')
shopModule:addSellableItem({'dresser'}, 3932, 500, 'dresser')
shopModule:addSellableItem({'locker'}, 3934, 500, 'locker')
shopModule:addSellableItem({'trough'}, 3935, 500, 'trough')
shopModule:addSellableItem({'box'}, 3915, 500, 'box')

-- More items
shopModule:addSellableItem({'coal basin'}, 3908, 500, 'coal basin')
shopModule:addSellableItem({'birdcage'}, 3918, 500, 'birdcage')
shopModule:addSellableItem({'harp'}, 3917, 500, 'harp')
shopModule:addSellableItem({'piano'}, 3926, 500, 'piano')
shopModule:addSellableItem({'globe'}, 3927, 500, 'globe')
shopModule:addSellableItem({'clock'}, 3933, 500, 'clock')
shopModule:addSellableItem({'lamp'}, 3937, 500, 'lamp')

-- Tapestries
shopModule:addSellableItem({'blue tapestry'}, 1872, 500, 'blue tapestry')
shopModule:addSellableItem({'green tapestry'}, 1860, 500, 'green tapestry')
shopModule:addSellableItem({'orange tapestry'}, 1866, 500, 'orange tapestry')
shopModule:addSellableItem({'pink tapestry'}, 1857, 500, 'pink tapestry')
shopModule:addSellableItem({'red tapestry'}, 1869, 500, 'red tapestry')
shopModule:addSellableItem({'white tapestry'}, 1880, 500, 'white tapestry')
shopModule:addSellableItem({'yellow tapestry'}, 1863, 500, 'yellow tapestry')

-- Pillows
shopModule:addSellableItem({'small purple pillow'}, 1678, 500, 'small purple pillow')
shopModule:addSellableItem({'small green pillow'}, 1679, 500, 'small green pillow')
shopModule:addSellableItem({'small red pillow'}, 1680, 500, 'small red pillow')
shopModule:addSellableItem({'small blue pillow'}, 1681, 500, 'small blue pillow')
shopModule:addSellableItem({'small orange pillow'}, 1682, 500, 'small orange pillow')
shopModule:addSellableItem({'small turquoise pillow'}, 1683, 500, 'small turquoise pillow')
shopModule:addSellableItem({'small white pillow'}, 1684, 500, 'small white pillow')
shopModule:addSellableItem({'heart pillow'}, 1685, 500, 'heart pillow')
shopModule:addSellableItem({'blue pillow'}, 1686, 500, 'blue pillow')
shopModule:addSellableItem({'red pillow'}, 1687, 500, 'red pillow')
shopModule:addSellableItem({'green pillow'}, 1688, 500, 'green pillow')
shopModule:addSellableItem({'yellow pillow'}, 1689, 500, 'yellow pillow')
shopModule:addSellableItem({'round blue pillow'}, 1690, 500, 'round blue pillow')
shopModule:addSellableItem({'round red pillow'}, 1691, 500, 'round red pillow')
shopModule:addSellableItem({'round purple pillow'}, 1692, 500, 'round purple pillow')
shopModule:addSellableItem({'round turquoise pillow'}, 1693, 500, 'round turquoise pillow')

-- Keywords for categories
keywordHandler:addKeyword({'chairs'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I sell wooden, sofa, red cushioned, green cushioned, tusk and ivory chairs.'
})

keywordHandler:addKeyword({'tables'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I sell big, square, round, small, stone, tusk, bamboo tables.'
})

keywordHandler:addKeyword({'plants'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I sell pink and green flowers, also christmas trees.'
})

keywordHandler:addKeyword({'containers'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I sell large trunks, boxes, drawers, dressers, lockers and troughs.'
})

keywordHandler:addKeyword({'more'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I sell coal basins, birdcages, harps, pianos, globes, clocks and lamps.'
})

keywordHandler:addKeyword({'tapestry', 'tapestries'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I sell blue, green, orange, pink, red, white and yellow tapestry.'
})

keywordHandler:addKeyword({'small'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I sell small purple, small green, small red, small blue, small orange, small turquoise and small white pillows.'
})

keywordHandler:addKeyword({'round'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I sell round blue, round red, round purple and round turquoise pillows.'
})

keywordHandler:addKeyword({'square'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I sell blue, red, green and yellow pillows.'
})

keywordHandler:addKeyword({'pillows'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I sell heart, small, square and round pillows.'
})

npcHandler:setMessage(MESSAGE_GREET, 'Hello |PLAYERNAME|! I sell chairs, tables, plants, containers, pillows, tapestries and more. Everything for 500gp.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye then.')
npcHandler:setMessage(MESSAGE_DECLINE, 'Sorry, |PLAYERNAME|! I talk to you in a minute.')

npcHandler:addModule(FocusModule:new())
