local internalCustomerQueue = {}
local keywordHandler = KeywordHandler:new({root = {}})
local npcHandler = ShopNpcHandler:new({})
local customerQueue = CustomerQueue:new({customers = internalCustomerQueue, handler = npcHandler})
npcHandler:init(customerQueue, keywordHandler)


-- OTServ event handling functions start
function onThingMove(creature, thing, oldpos, oldstackpos)     npcHandler:onThingMove(creature, thing, oldpos, oldstackpos) end
function onCreatureAppear(creature)                             npcHandler:onCreatureAppear(creature) end
function onCreatureDisappear(id)                                 npcHandler:onCreatureDisappear(id) end
function onCreatureTurn(creature)                                 npcHandler:onCreatureTurn(creature) end
function onCreatureSay(cid, type, msg)                         npcHandler:onCreatureSay(cid, type, msg) end
function onCreatureChangeOutfit(creature)                         npcHandler:onCreatureChangeOutfit(creature) end
function onThink()                                             npcHandler:onThink() end
-- OTServ event handling functions end

-- Keyword handling functions start
function tradeItem(cid, message, keywords, parameters)     return npcHandler:defaultTradeHandler(cid, message, keywords, parameters) end
function confirmAction(cid, message, keywords, parameters) return npcHandler:defaultConfirmHandler(cid, message, keywords, parameters) end
function sayMessage(cid, message, keywords, parameters)     return npcHandler:defaultMessageHandler(cid, message, keywords, parameters) end


-- greet diferente
function greet(cid, message, keywords, parameters)
    if npcHandler.focus == cid then
        selfSay('I am already talking to you.')
        npcHandler.talkStart = os.clock()
    elseif npcHandler.focus > 0 or not(npcHandler.queue:isEmpty()) then
        selfSay('Please, ' .. creatureGetName(cid) .. '. I will talk to you in one minute!.')
        if(not npcHandler.queue:isInQueue(cid)) then
            npcHandler.queue:pushBack(cid)
        end
    elseif(npcHandler.focus == 0) and (npcHandler.queue:isEmpty()) then
        selfSay(' Hello ' .. creatureGetName(cid) .. '! Welcome to my distance weaponry!')
        npcHandler.focus = cid
        voc = 0
        npcHandler.talkStart = os.clock()
    end
    
    return true
end

function farewell(cid, message, keywords, parameters)         return npcHandler:defaultFarewellHandler(cid, message, keywords, parameters) end
-- Keyword handling functions end

-- Buy item keywords

keywordHandler:addKeyword({'crossbow'},    	 tradeItem, {itemid = 2455, cost = 500})
keywordHandler:addKeyword({'bow'},    	 tradeItem, {itemid = 2456, cost = 350})

keywordHandler:addKeyword({'arrow'},    	 tradeItem, {itemid = 2544, cost = 2, charges = 1})
keywordHandler:addKeyword({'bolt'},    	 tradeItem, {itemid = 2543, cost = 10, charges = 1})
keywordHandler:addKeyword({'spear'},    	 tradeItem, {itemid = 2389, cost = 10, charges = 1})



-- Confirm sell/buy keywords
keywordHandler:addKeyword({'yes'}, confirmAction)
keywordHandler:addKeyword({'no'}, confirmAction)

-- General message keywords
keywordHandler:addKeyword({'offer'},     sayMessage, {text = 'I offer you bows, crossbows, arrows, bolts, spears and burst arrows.'})
keywordHandler:addKeyword({'sell'},     sayMessage, {text = 'I am not buing anything.'})
keywordHandler:addKeyword({'job'},     sayMessage, {text = 'I am the shopkeeper of this distance weaponry.'})
keywordHandler:addKeyword({'quest'},     sayMessage, {text = 'A quest is nothing I want to be involved in.'})
keywordHandler:addKeyword({'mission'},    sayMessage, {text = 'I cannot help you in that area, son.'})
keywordHandler:addKeyword({'buy'},        sayMessage, {text = 'I cannot sell that.'})


keywordHandler:addKeyword({'hi'}, greet, nil)
keywordHandler:addKeyword({'hello'}, greet, nil)
keywordHandler:addKeyword({'hey'}, greet, nil)
keywordHandler:addKeyword({'bye'}, farewell, nil)
keywordHandler:addKeyword({'farewell'}, farewell, nil)