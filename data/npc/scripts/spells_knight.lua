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

    -- Knight Spells
    if msgcontains(msg, 'light healing') then
        learnSpell(cid, 'exura', 170)
    elseif msgcontains(msg, 'haste') then
        learnSpell(cid, 'utani hur', 600)
    elseif msgcontains(msg, 'berserk') then
        learnSpell(cid, 'exori', 2500)
    elseif msgcontains(msg, 'challenge') then
        learnSpell(cid, 'exeta res', 2000)

    -- Light Spells
    elseif msgcontains(msg, 'greater light') then
        learnSpell(cid, 'utevo gran lux', 500)
    elseif msgcontains(msg, 'light') and not msgcontains(msg, 'greater') then
        learnSpell(cid, 'utevo lux', 100)

    -- Utility Spells
    elseif msgcontains(msg, 'find person') then
        learnSpell(cid, 'exiva', 80)
    elseif msgcontains(msg, 'magic rope') then
        learnSpell(cid, 'exani tera', 200)
    elseif msgcontains(msg, 'levitate') then
        learnSpell(cid, 'exani hur', 500)
    elseif msgcontains(msg, 'antidote') then
        learnSpell(cid, 'exana pox', 150)

    elseif msgcontains(msg, 'spells') or msgcontains(msg, 'offer') then
        selfSay('I teach spells for knights: light healing, haste, berserk, challenge, light spells, and utility spells. Just tell me which spell you want to learn!', cid)
    elseif msgcontains(msg, 'job') then
        selfSay('I am a spell teacher for knights. I can teach you combat and utility spells!', cid)
    elseif msgcontains(msg, 'help') then
        selfSay('I teach spells to knights only. Say the name of a spell to learn it, or say "spells" to hear about what I teach.', cid)
    end

    return true
end

function onGreet(cid)
    local player = Player(cid)
    if not player then
        return false
    end

    local vocation = player:getVocation():getId()
    
    -- Check if player is knight (vocation 4 or promoted 8)
    if vocation == 4 or vocation == 8 then
        selfSay('Hello ' .. player:getName() .. '! What spell do you want to learn?', cid)
        return true
    else
        selfSay('Sorry, I sell spells for knights only.', cid)
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
keywordHandler:addKeyword({'combat'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I teach light healing, haste, berserk, and challenge spells for knights.'})
keywordHandler:addKeyword({'utility'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I teach find person, magic rope, levitate, antidote, and light spells.'})
keywordHandler:addKeyword({'knight'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I only teach spells to noble knights and elite knights.'})

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
