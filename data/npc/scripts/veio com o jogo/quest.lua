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
function greet(cid, message, keywords, parameters)         return npcHandler:defaultGreetHandler(cid, message, keywords, parameters) end
function farewell(cid, message, keywords, parameters)         return npcHandler:defaultFarewellHandler(cid, message, keywords, parameters) end
-- Keyword handling functions end


-- funcoes extras

function processQuest(cid, message, keywords, parameters)
    if(cid ~= npcHandler.focus) then
        return false
    end
    
    if(keywords[1] == 'quest') then
        local storageValue = getPlayerStorageValue(npcHandler.focus, parameters.questid)
	if(storageValue == -1) then
            selfSay('If you an excencial item for addon , please bring me 15 chiken feathers.')
	setPlayerStorageValue(npcHandler.focus, parameters.questid, 1)
            return true
        end
        
	if(storageValue == 1) then
		if(getPlayerItemCount(npcHandler.focus, 5890) >= 15) then
	selfSay('I see that you have found the feathers, take this.')
	  doPlayerRemoveItem(npcHandler.focus, 5890, 15)
	  doPlayerAddItem(npcHandler.focus, 2366, 1)
	setPlayerStorageValue(npcHandler.focus, parameters.questid, 2)
        else
	selfSay('I guess you are too busy to find what i need...')
        end
        
   		elseif(storageValue == 2) then
	selfSay('You already have done my mission.')
        
    end
    
   	 return true
          end
end

function itemForItem(cid, message, keywords, parameters)
if(cid ~= npcHandler.focus) then
return false
end
if(getPlayerItemCount(cid, parameters.itemtrade) >= parameters.counti) then
doPlayerRemoveItem(cid, parameters.itemtrade, parameters.counti)
doPlayerAddItem(cid, parameters.itemtrade2, parameters.counti2)
selfSay('Thanks, take this.')
else
selfSay('You dont have such item.')
end
end


-- funcoes extras end


-- Keyword structure generation start
keywordHandler:addKeyword({'rope'},     tradeItem, {itemid = 2120, cost = 50})
keywordHandler:addKeyword({'shovel'},     tradeItem, {itemid = 2554, cost = 10})
keywordHandler:addKeyword({'torch'},     tradeItem, {itemid = 2050, cost = 2})
keywordHandler:addKeyword({'machete'},     tradeItem, {itemid = 2420, cost = 30})
keywordHandler:addKeyword({'scythe'},     tradeItem, {itemid = 2550, cost = 30})

keywordHandler:addKeyword({'yes'}, confirmAction, nil)
keywordHandler:addKeyword({'no'}, confirmAction, nil)


keywordHandler:addKeyword({'offer'},     sayMessage, {text = 'I sell ropes, shovels, torches, picks, machetes and scythes.', onlyfocus = true})
keywordHandler:addKeyword({'sell'},     sayMessage, {text = 'Why would I need that rubbish?', onlyfocus = true})
keywordHandler:addKeyword({'job'},     sayMessage, {text = 'I seel all kinds of tools.', onlyfocus = true})
keywordHandler:addKeyword({'mission'},sayMessage, {text = 'I cannot help you in that area, son.', onlyfocus = true})
keywordHandler:addKeyword({'buy'},        sayMessage, {text = 'Sorry but I do not sell those.', onlyfocus = true})

keywordHandler:addKeyword({'quest'}, processQuest, {questid = 1000})

keywordHandler:addKeyword({'trade pick'}, itemForItem, {itemtrade = 2553, counti = 1, itemtrade2 = 5890, counti2 = 15})

keywordHandler:addKeyword({'hi'}, greet, nil)
keywordHandler:addKeyword({'hello'}, greet, nil)
keywordHandler:addKeyword({'hey'}, greet, nil)
keywordHandler:addKeyword({'bye'}, farewell, nil)
keywordHandler:addKeyword({'farewell'}, farewell, nil)
-- Keyword structure generation end