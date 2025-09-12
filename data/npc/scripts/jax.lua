local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local talkState = {}

-- Item exchange configuration
local exchanges = {
    ["blue note"] = {
        requiredItem = 2346,
        requiredCount = 1,
        rewardItem = 2349,
        rewardCount = 1
    },
    ["bar of gold"] = {
        requiredItem = 2033,
        requiredCount = 10,
        rewardItem = 15515,
        rewardCount = 1
    }
}

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    local message = msg:lower()
    
    -- Check for exchange commands
    for keyword, exchange in pairs(exchanges) do
        if msgcontains(message, keyword) then
            local requiredItem = ItemType(exchange.requiredItem)
            local rewardItem = ItemType(exchange.rewardItem)
            
            if player:getItemCount(exchange.requiredItem) >= exchange.requiredCount then
                -- Player has enough items, perform exchange
                player:removeItem(exchange.requiredItem, exchange.requiredCount)
                player:addItem(exchange.rewardItem, exchange.rewardCount)
                
                local requiredName = requiredItem:getName()
                local rewardName = rewardItem:getName()
                
                npcHandler:say('You just swapped ' .. exchange.requiredCount .. ' ' .. requiredName .. ' for ' .. exchange.rewardCount .. ' ' .. rewardName .. '.', cid)
                player:sendTextMessage(MESSAGE_INFO_DESCR, "Exchange completed successfully!")
                player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
            else
                local requiredName = requiredItem:getName()
                npcHandler:say('You need ' .. exchange.requiredCount .. ' ' .. requiredName .. '.', cid)
            end
            return true
        end
    end
    
    -- Handle other commands
    if msgcontains(message, 'offer') or msgcontains(message, 'trade') then
        npcHandler:say('I can exchange items for you! I accept {blue note} and {bar of gold}.', cid)
    elseif msgcontains(message, 'help') then
        npcHandler:say('I can help you exchange certain items. Say "blue note" to exchange a blue note for a different item, or "bar of gold" to exchange 10 bars of gold.', cid)
    else
        return false
    end
    
    return true
end

-- Keywords for automatic responses
keywordHandler:addKeyword({'offer', 'trade'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = true,
    text = 'I can exchange items for you! I accept {blue note} and {bar of gold}.'
})

keywordHandler:addKeyword({'help'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = true,
    text = 'I can help you exchange certain items. Say "blue note" to exchange a blue note, or "bar of gold" to exchange 10 bars of gold.'
})

keywordHandler:addKeyword({'job'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = true,
    text = 'I am an item exchanger! I trade specific items for other valuable ones.'
})

npcHandler:setMessage(MESSAGE_GREET, 'Welcome |PLAYERNAME|! I can exchange certain items for you.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Come back when you need to exchange items.')
npcHandler:setMessage(MESSAGE_DECLINE, 'I am busy with another customer right now.')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
