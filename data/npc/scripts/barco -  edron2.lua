local internalCustomerQueue = {}
local keywordHandler = KeywordHandler:new({root = {}})
local npcHandler = ShopNpcHandler:new({})
local customerQueue = CustomerQueue:new({customers = internalCustomerQueue, handler = npcHandler})
npcHandler:init(customerQueue, keywordHandler)
npcHandler.walkDistance = 0
local cost = 0
local destination = {}

-- OTServ event handling functions start
function onThingMove(creature, thing, oldpos, oldstackpos) 				npcHandler:onThingMove(creature, thing, oldpos, oldstackpos) end
function onCreatureAppear(creature) 							npcHandler:onCreatureAppear(creature) end
function onCreatureDisappear(id) 							npcHandler:onCreatureDisappear(id) end
function onCreatureTurn(creature) 							npcHandler:onCreatureTurn(creature) end
function onCreatureSay(cid, type, msg) 						npcHandler:onCreatureSay(cid, type, msg) end
function onCreatureChangeOutfit(creature) 						npcHandler:onCreatureChangeOutfit(creature) end
function onThink() 									npcHandler:onThink() end
-- OTServ event handling functions end


-- Keyword handling functions start
function tradeItem(cid, message, keywords, parameters) 			return npcHandler:defaultTradeHandler(cid, message, keywords, parameters) end
function confirmAction(cid, message, keywords, parameters) 		return npcHandler:defaultConfirmHandler(cid, message, keywords, parameters) end
function sayMessage(cid, message, keywords, parameters) 			return npcHandler:defaultMessageHandler(cid, message, keywords, parameters) end
function farwell(cid, message, keywords, parameters) 			return npcHandler:defaultFarwellHandler(cid, message, keywords, parameters) end


function greet(cid, message, keywords, parameters)
    if npcHandler.focus == cid then
        selfSay('I am already talking to you.')
        npcHandler.talkStart = os.clock()
    elseif npcHandler.focus > 0 or not(npcHandler.queue:isEmpty()) then
        selfSay('Please, ' .. creatureGetName(cid) .. '. Wait in the line!.')
        if(not npcHandler.queue:isInQueue(cid)) then
            npcHandler.queue:pushBack(cid)
        end
    elseif(npcHandler.focus == 0) and (npcHandler.queue:isEmpty()) then
        selfSay(' Hello ' .. creatureGetName(cid) .. '! Welcome to my five stars Ship!')
        npcHandler.focus = cid
        voc = 0
        npcHandler.talkStart = os.clock()
    end
    
    return true
end



-- Keyword handling functions end




-- Systema de viajem

function travel(cid, message, keywords, parameters)
   if(cid ~= npcHandler.focus) then
      return false
   end
if (parameters.premium and getPlayerPremium(cid) <= 0) then                                  -- MUDAR PRA GET PREMIUN FUNCIONANDO
   selfSay('Only players with premium accounts may travel there.')
   return true
end
   selfSay('Do you wish to travel to ' .. keywords[1] .. ' for ' .. parameters.cost .. ' gold coins?')
   destination = parameters.pos
   cost = parameters.cost
   npcHandler.talkstate = 1
   return true
end

function confirmAction(cid, message, keywords, parameters)
    if(cid ~= npcHandler.focus) then
        return false
    end
    
    if(keywords[1] == 'yes') then
        if(npcHandler.talkstate == 1) then
            if(doPlayerRemoveMoney(cid, cost) == TRUE) then
                selfSay('Set the sails!')
                doTeleportThing(cid, destination)
	     doSendMagicEffect(destination,10)
                npcHandler.talkstate = 0
            else
                selfSay('You do not have enough money!')
                npcHandler.talkstate = 0
            end
        end

    elseif(keywords[1] == 'no') then
        if(npcHandler.talkstate == 1) then
            selfSay('Where do you wish to go then?')
            npcHandler.talkstate = 0
        end
    end
    
    return true
end

-- Systema de viajem Fim





-- General message keywords

keywordHandler:addKeyword({'tombstone'},       travel, {cost = 80,  premium = false, pos = {x = 173, y = 65, z = 7} })
keywordHandler:addKeyword({'carlin'},         	travel, {cost = 80,  premium = false, pos = {x = 151, y = 356, z = 6} })
keywordHandler:addKeyword({'yes'}, 		confirmAction, nil)
keywordHandler:addKeyword({'no'}, 		confirmAction, nil)


keywordHandler:addKeyword({'offer'},		sayMessage, {text = 'I can take you from here to tombstone and carlin.'})
keywordHandler:addKeyword({'travel'}, 	sayMessage, {text = 'I can take you from here to tombstone and carlin.'})
keywordHandler:addKeyword({'sell'}, 		sayMessage, {text = 'I am not buing anything.'})
keywordHandler:addKeyword({'buy'}, 		sayMessage, {text = 'I am just selling passages for carlin and tombstone.'})
keywordHandler:addKeyword({'job'}, 		sayMessage, {text = 'I am the Capitan of this Ship!'})
keywordHandler:addKeyword({'quest'}, 		sayMessage, {text = 'Since i get busted by pirates in my quests, i never get out of route again!'})
keywordHandler:addKeyword({'mission'}, 	sayMessage, {text = 'Since i get busted by pirates in my quests, i never get out of route again!'})

-- General end



-- Hi and Bye
keywordHandler:addKeyword({'hi'}, greet, nil)
keywordHandler:addKeyword({'hello'}, greet, nil)
keywordHandler:addKeyword({'hey'}, greet, nil)
keywordHandler:addKeyword({'bye'}, farwell, nil)