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
    elseif msgcontains(msg, 'heal friend') then
        learnSpell(cid, 'exura sio', 800)
    elseif msgcontains(msg, 'mass healing') then
        learnSpell(cid, 'exevo gran mas res', 2200)

    -- Attack Spells
    elseif msgcontains(msg, 'force strike') then
        learnSpell(cid, 'exori mort', 600)
    elseif msgcontains(msg, 'energy strike') then
        learnSpell(cid, 'exori mort', 800)
    elseif msgcontains(msg, 'flame strike') then
        learnSpell(cid, 'exori flam', 800)
    elseif msgcontains(msg, 'heavy magic missile') then
        learnSpell(cid, 'adori gran', 600)
    elseif msgcontains(msg, 'great fireball') then
        learnSpell(cid, 'adori gran flam', 1200)
    elseif msgcontains(msg, 'explosion') then
        learnSpell(cid, 'adevo mas hur', 1800)
    elseif msgcontains(msg, 'poison storm') then
        learnSpell(cid, 'exevo gran mas pox', 3400)

    -- Rune Spells
    elseif msgcontains(msg, 'intense healing rune') then
        learnSpell(cid, 'adura gran', 600)
    elseif msgcontains(msg, 'ultimate healing rune') then
        learnSpell(cid, 'adura vita', 1500)

    -- Utility Spells
    elseif msgcontains(msg, 'create food') then
        learnSpell(cid, 'exevo pan', 150)
    elseif msgcontains(msg, 'magic shield') then
        learnSpell(cid, 'utamo vita', 450)
    elseif msgcontains(msg, 'haste') and not msgcontains(msg, 'strong') then
        learnSpell(cid, 'utani hur', 600)
    elseif msgcontains(msg, 'strong haste') then
        learnSpell(cid, 'utani gran hur', 1300)
    elseif msgcontains(msg, 'light') and not msgcontains(msg, 'greater') and not msgcontains(msg, 'ultimate') then
        learnSpell(cid, 'utevo lux', 100)
    elseif msgcontains(msg, 'greater light') then
        learnSpell(cid, 'utevo gran lux', 500)
    elseif msgcontains(msg, 'ultimate light') then
        learnSpell(cid, 'utevo vis lux', 1600)
    elseif msgcontains(msg, 'invisible') then
        learnSpell(cid, 'utana vid', 1000)
    elseif msgcontains(msg, 'summon') then
        learnSpell(cid, 'utevo res', 2000)
    elseif msgcontains(msg, 'find person') then
        learnSpell(cid, 'exiva', 80)
    elseif msgcontains(msg, 'magic rope') then
        learnSpell(cid, 'exani tera', 200)
    elseif msgcontains(msg, 'levitate') then
        learnSpell(cid, 'exani hur', 500)
    elseif msgcontains(msg, 'antidote') then
        learnSpell(cid, 'exana pox', 150)
    elseif msgcontains(msg, 'wild growth') then
        learnSpell(cid, 'exani tera', 2000)

    elseif msgcontains(msg, 'spells') or msgcontains(msg, 'offer') then
        selfSay('I teach healing spells, attack spells, runes, and utility spells for druids. Just tell me which spell you want to learn!', cid)
    elseif msgcontains(msg, 'job') then
        selfSay('I am a spell teacher for druids. I can teach you many powerful spells!', cid)
    elseif msgcontains(msg, 'help') then
        selfSay('I teach spells to druids only. Say the name of a spell to learn it, or say "spells" to hear about what I teach.', cid)
    end

    return true
end

function onGreet(cid)
    local player = Player(cid)
    if not player then
        return false
    end

    local vocation = player:getVocation():getId()
    
    -- Check if player is druid (vocation 2 or promoted 6)
    if vocation == 2 or vocation == 6 then
        selfSay('Hello ' .. player:getName() .. '! What spell do you want to learn?', cid)
        return true
    else
        selfSay('Sorry, I sell spells for druids only.', cid)
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
keywordHandler:addKeyword({'healing'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I teach light healing, intense healing, ultimate healing, heal friend, and mass healing.'})
keywordHandler:addKeyword({'attack'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I teach force strike, energy strike, flame strike, heavy magic missile, great fireball, explosion, and poison storm.'})
keywordHandler:addKeyword({'rune'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I teach intense healing rune and ultimate healing rune.'})
keywordHandler:addKeyword({'utility'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I teach many utility spells like haste, light, invisible, summon, find person, magic rope, levitate, antidote, and wild growth.'})

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
