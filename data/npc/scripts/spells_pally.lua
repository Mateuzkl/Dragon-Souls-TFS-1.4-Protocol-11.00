local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                          npcHandler:onThink() end

-- Modern spell learning function
function learnSpell(cid, spellName, price)
    local player = Player(cid)
    if not player then
        return false
    end

    if player:hasLearnedSpell(spellName) then
        selfSay('You already know this spell.', cid)
        return false
    end

    if player:removeTotalMoney(price) then
        player:learnSpell(spellName)
        selfSay('You have learned a new spell!', cid)
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        return true
    else
        selfSay('You do not have enough money.', cid)
        return false
    end
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local player = Player(cid)
    if not player then
        return false
    end

    -- Healing Spells
    if msgcontains(msg, 'light healing') then
        learnSpell(cid, 'exura', 170)
    elseif msgcontains(msg, 'intense healing') then
        learnSpell(cid, 'exura gran', 350)
    elseif msgcontains(msg, 'ultimate healing') then
        learnSpell(cid, 'exura vita', 1000)

    -- Conjure Spells (Paladin specialty)
    elseif msgcontains(msg, 'conjure arrow') then
        learnSpell(cid, 'exevo con', 450)
    elseif msgcontains(msg, 'conjure bolt') then
        learnSpell(cid, 'exevo con mort', 750)
    elseif msgcontains(msg, 'conjure burst arrow') then
        learnSpell(cid, 'exevo con flam', 1000)
    elseif msgcontains(msg, 'conjure power bolt') then
        learnSpell(cid, 'exevo con vis', 2000)

    -- Attack Spells
    elseif msgcontains(msg, 'heavy magic missile') then
        learnSpell(cid, 'adori gran', 600)

    -- Utility Spells
    elseif msgcontains(msg, 'create food') then
        learnSpell(cid, 'exevo pan', 150)
    elseif msgcontains(msg, 'haste') then
        learnSpell(cid, 'utani hur', 600)
    elseif msgcontains(msg, 'magic shield') then
        learnSpell(cid, 'utamo vita', 450)
    elseif msgcontains(msg, 'invisible') then
        learnSpell(cid, 'utana vid', 1000)

    -- Light Spells
    elseif msgcontains(msg, 'greater light') then
        learnSpell(cid, 'utevo gran lux', 500)
    elseif msgcontains(msg, 'light') and not msgcontains(msg, 'greater') then
        learnSpell(cid, 'utevo lux', 100)

    -- Support Spells
    elseif msgcontains(msg, 'find person') then
        learnSpell(cid, 'exiva', 80)
    elseif msgcontains(msg, 'magic rope') then
        learnSpell(cid, 'exani tera', 200)
    elseif msgcontains(msg, 'levitate') then
        learnSpell(cid, 'exani hur', 500)
    elseif msgcontains(msg, 'antidote') then
        learnSpell(cid, 'exana pox', 150)

    elseif msgcontains(msg, 'spells') or msgcontains(msg, 'offer') then
        selfSay('I teach healing spells, conjure spells, attack spells, and utility spells for paladins. Just tell me which spell you want to learn!', cid)
    elseif msgcontains(msg, 'conjure') then
        selfSay('I teach conjure arrow (450gp), conjure bolt (750gp), conjure burst arrow (1000gp), and conjure power bolt (2000gp).', cid)
    elseif msgcontains(msg, 'job') then
        selfSay('I am a spell teacher for paladins. I specialize in conjure spells and ranged combat magic!', cid)
    elseif msgcontains(msg, 'help') then
        selfSay('I teach spells to paladins only. Say the name of a spell to learn it, or say "spells" to hear about what I teach.', cid)
    end

    return true
end

function onGreet(cid)
    local player = Player(cid)
    if not player then
        return false
    end

    local vocation = player:getVocation():getId()
    
    -- Check if player is paladin (vocation 3 or promoted 7)
    if vocation == 3 or vocation == 7 then
        selfSay('Hello ' .. player:getName() .. '! What spell do you want to learn?', cid)
        return true
    else
        selfSay('Sorry, I sell spells for paladins only.', cid)
        return false
    end
end

function onFarewell(cid)
    local player = Player(cid)
    if not player then
        return false
    end
    
    selfSay('Goodbye, ' .. player:getName() .. '!', cid)
    return true
end

-- Keywords for spell categories
keywordHandler:addKeyword({'healing'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I teach light healing, intense healing, and ultimate healing spells.'})
keywordHandler:addKeyword({'ammunition'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I teach conjure spells to create arrows and bolts for paladins.'})
keywordHandler:addKeyword({'utility'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I teach many utility spells like haste, light, invisible, find person, magic rope, levitate, and antidote.'})
keywordHandler:addKeyword({'arrows'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I can teach you to conjure arrows and burst arrows.'})
keywordHandler:addKeyword({'bolts'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I can teach you to conjure bolts and power bolts.'})

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
