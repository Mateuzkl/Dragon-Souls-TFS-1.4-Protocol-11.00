local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local talkState = {}

-- Original position coordinates (if needed)
local ox = 219
local oy = 106 
local oz = 7
local max = 2

function onCreatureAppear(cid)
    npcHandler:onCreatureAppear(cid)
end

function onCreatureDisappear(cid)
    npcHandler:onCreatureDisappear(cid)
end

function onCreatureSay(cid, msgType, msg)
    npcHandler:onCreatureSay(cid, msgType, msg)
end

function onThink()
    npcHandler:onThink()
end

local function greetCallback(cid)
    local player = Player(cid)
    if not player then
        return false
    end
    return true
end

local function farewellCallback(cid)
    local player = Player(cid)
    if not player then
        return false
    end
    return true
end

local function creatureSayCallback(cid, msgType, msg)
    if not npcHandler:isFocused(cid) then
        local player = Player(cid)
        if not player then
            return false
        end
        
        local message = msg:lower()
        
        if msgcontains(message, 'hi') then
            npcHandler:say('Hello ' .. player:getName() .. '! Welcome to information box, I just have information about.: RUNES, WANDS, BLESSINGS, HOUSES AND READABLES. How can I help you?', cid)
            return true
        elseif msgcontains(message, 'oi') then
            npcHandler:say('Ola ' .. player:getName() .. '! Bemvindo a Cabine da Informacao, So posso te informar sobre.: RUNAS, VARINHAS, BLESSINGS, CASAS E READABLES. Como posso te ajudar?', cid)
            return true
        end
        
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    -- Initialize talkState if needed
    if not talkState[cid] then
        talkState[cid] = 0
    end
    
    local message = msg:lower()
    
    -- Information responses
    if msgcontains(message, 'runes') then
        npcHandler:say('You can buy runes next to Carlin Ship', cid)
    elseif msgcontains(message, 'runas') then
        npcHandler:say('Voce pode comprar runas proximo ao Barco de Carlin', cid)
    elseif msgcontains(message, 'wands') then
        npcHandler:say('You can buy wands in the west on carlin on Druid Shop.', cid)
    elseif msgcontains(message, 'varinhas') then
        npcHandler:say('Voce pode comprar varinhas no leste de Carlin na Loja Druida.', cid)
    elseif msgcontains(message, 'blessings') then
        npcHandler:say('We have diferent bless if you free acc and dont help server u can got just 2 bless but need walk so much to find the Lost´s NPCs', cid)
    elseif msgcontains(message, 'houses') then
        npcHandler:say('To buy a house, just need help server with a donation and you will have your house.', cid)
    elseif msgcontains(message, 'casas') then
        npcHandler:say('Para comprar uma casa, basta ajudar o servidor com uma doacao e tera uma.', cid)
    elseif msgcontains(message, 'readables') then
        npcHandler:say('Just give LOOK on every readables on shops or quests , many information on it may save your life', cid)
    elseif msgcontains(message, 'tchau') then
        npcHandler:say('Sempre as ordens, ' .. player:getName() .. '!', cid)
        npcHandler:releaseFocus(cid)
    end
    
    return true
end

-- Keywords for information topics
keywordHandler:addKeyword({'runes'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = true,
    text = 'You can buy runes next to Carlin Ship'
})

keywordHandler:addKeyword({'runas'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = true,
    text = 'Voce pode comprar runas proximo ao Barco de Carlin'
})

keywordHandler:addKeyword({'wands'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = true,
    text = 'You can buy wands in the west on carlin on Druid Shop.'
})

keywordHandler:addKeyword({'varinhas'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = true,
    text = 'Voce pode comprar varinhas no leste de Carlin na Loja Druida.'
})

keywordHandler:addKeyword({'blessings'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = true,
    text = 'We have diferent bless if you free acc and dont help server u can got just 2 bless but need walk so much to find the Lost´s NPCs'
})

keywordHandler:addKeyword({'houses'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = true,
    text = 'To buy a house, just need help server with a donation and you will have your house.'
})

keywordHandler:addKeyword({'casas'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = true,
    text = 'Para comprar uma casa, basta ajudar o servidor com uma doacao e tera uma.'
})

keywordHandler:addKeyword({'readables'}, StdModule.say, {
    npcHandler = npcHandler,
    onlyFocus = true,
    text = 'Just give LOOK on every readables on shops or quests , many information on it may save your life'
})

-- Greet messages
npcHandler:setMessage(MESSAGE_GREET, 'Hello |PLAYERNAME|! Welcome to information box, I just have information about.: RUNES, WANDS, BLESSINGS, HOUSES AND READABLES. How can I help you?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye then.')
npcHandler:setMessage(MESSAGE_DECLINE, 'Sorry, |PLAYERNAME|! I talk to you in a minute.')

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_FAREWELL, farewellCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
