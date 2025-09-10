local internalCustomerQueue = {}
local keywordHandler = KeywordHandler:new({root = {}})
local npcHandler = ShopNpcHandler:new({})
local customerQueue = CustomerQueue:new({customers = internalCustomerQueue, handler = npcHandler})
npcHandler:init(customerQueue, keywordHandler)
npcHandler.walkDistance = 0
local voc = 0

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
function sayMessage(cid, message, keywords, parameters)     return npcHandler:defaultMessageHandler(cid, message, keywords, parameters) end

function greet(cid, message, keywords, parameters)
    -- We do not want to use the default "Welcome to my shop" thingie for this npc, so we'll just make this ourselves!
    if npcHandler.focus == cid then
        selfSay('I am already talking to you.')
        npcHandler.talkStart = os.clock()
    elseif npcHandler.focus > 0 or not(npcHandler.queue:isEmpty()) then
        selfSay('Please, ' .. creatureGetName(cid) .. '. Wait for your turn!.')
        if(not npcHandler.queue:isInQueue(cid)) then
            npcHandler.queue:pushBack(cid)
        end
    elseif(npcHandler.focus == 0) and (npcHandler.queue:isEmpty()) then
        selfSay(creatureGetName(cid) .. '! Are you prepared you face your destiny?')
        npcHandler.focus = cid
        voc = 0
        npcHandler.talkStart = os.clock()
    end
    
    return true
end

function farewell(cid, message, keywords, parameters)         return npcHandler:defaultFarewellHandler(cid, message, keywords, parameters) end
-- Keyword handling functions end


function confirmAction(cid, message, keywords, parameters)
    if(cid ~= npcHandler.focus) then
        return false
    end
    
    if(keywords[1] == 'yes') then
        
        if(getPlayerLevel(cid) < 8) then
            selfSay('You are not yet worthy. Come back when you are ready!')
            npcHandler:resetNpc()
            voc = 0
            return true
        end
        
        if(voc == 0) then
            selfSay('Allright then. What vocation do you wish to become? A sorcerer, druid, paladin or knight?')
        else
            doPlayerSetVocation(npcHandler.focus,voc)
            local pos = { x=438, y=504, z=8 }
            doPlayerSetMasterPos(npcHandler.focus,pos)
            doTeleportThing(npcHandler.focus,pos)
            voc = 0
        end
        
    elseif(keywords[1] == 'no') then
        
        if(voc == 0) then
            selfSay('Then come back when you are ready!')
            npcHandler.focus = 0
              voc = 0
              if not(queue[1] == nil) then
                  greetNextCostumer(queue)
              end
        else
            selfSay('Allright then. What vocation do you wish to become? A sorcerer, druid, paladin or knight?')
            voc = 0
        end
        
    end
    
    return true
end

function selectVocation(cid, message, keywords, parameters)
    if(cid ~= npcHandler.focus) then
        return false
    end
    
    selfSay('Are you sure that you wish to become a ' .. keywords[1] .. '? This decition is irreversible!')
    voc = parameters.voc
    
    return true
    
end


keywordHandler:addKeyword({'sorcerer'}, selectVocation, {voc = 1})
keywordHandler:addKeyword({'druid'}, selectVocation, {voc = 2})
keywordHandler:addKeyword({'paladin'}, selectVocation, {voc = 3})
keywordHandler:addKeyword({'knight'}, selectVocation, {voc = 4})

-- Confirm sell/buy keywords
keywordHandler:addKeyword({'yes'}, confirmAction)
keywordHandler:addKeyword({'no'}, confirmAction)

keywordHandler:addKeyword({'hi'}, greet, nil)
keywordHandler:addKeyword({'hello'}, greet, nil)
keywordHandler:addKeyword({'hey'}, greet, nil)
keywordHandler:addKeyword({'bye'}, farewell, nil)
keywordHandler:addKeyword({'farewell'}, farewell, nil)