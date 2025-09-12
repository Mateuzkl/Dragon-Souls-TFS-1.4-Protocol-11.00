local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end
function onThink()                          npcHandler:onThink()                        end

local function creatureSayCallback(cid, msgType, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    local novice = player:getStorageValue(1002)
    local voc = player:getVocation():getId()
    
    if msgcontains(msg, 'novice') then
        if novice == 2 then
            if voc == 1 then
                npcHandler:say('Hello novice! I got a thing to help you, get!', cid)
                npcHandler:say('But now i need work! Next please...', cid)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You receive a wand of vortex.")
                player:addItem(2190, 1)
                player:setStorageValue(1002, 3)
                npcHandler:releaseFocus(cid)
            elseif voc == 2 then
                npcHandler:say('Hello novice! I got a thing to help you, get!', cid)
                npcHandler:say('But now i need work! Next please...', cid)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You receive a snakebite rod.")
                player:addItem(2182, 1)
                player:setStorageValue(1002, 3)
                npcHandler:releaseFocus(cid)
            elseif voc == 3 then
                npcHandler:say('Hello novice! I got a thing to help you, get!', cid)
                npcHandler:say('But now i need work! Next please...', cid)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You receive a Dark helmet.")
                player:addItem(2490, 1)
                player:setStorageValue(1002, 3)
                npcHandler:releaseFocus(cid)
            elseif voc == 4 then
                npcHandler:say('Hello novice! I got a thing to help you, get!', cid)
                npcHandler:say('But now i need work! Next please...', cid)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You receive a morning star and a steel shield.")
                player:addItem(2394, 1)
                player:addItem(2509, 1)
                player:setStorageValue(1002, 3)
                npcHandler:releaseFocus(cid)
            else
                npcHandler:say('Hmm... You dont look like a novice... Sorry!', cid)
                npcHandler:releaseFocus(cid)
            end
        else
            npcHandler:say('Hmm... You dont look like a novice... Sorry!', cid)
            npcHandler:releaseFocus(cid)
        end
    end
    
    return true
end

keywordHandler:addKeyword({'helmets'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I buy royal (30k), warrior (4k), crusader (5k), crown (3k), devil (900gps), chain (100gps), iron (300gps), strange (1k), soldier (50gps), viking (140gps), brass (60gps), dark (200gps) also mystic turbans (1k).'
})

keywordHandler:addKeyword({'boots'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I buy steel boots (100k) and boots of haste (40k).'
})

keywordHandler:addKeyword({'armors'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I buy golden (30k), crown (20k), knight (5k), lady (6k), plate (500gps), brass (300gps), dark (1k), scale (150gps) and chain armors (140gps) also dragon scale mail (50k), magic plate armor (100k) and blue robes (10k).'
})

keywordHandler:addKeyword({'legs'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I buy golden (70k), crown (30k), knight (10k), plate (1k), chain (50gps) and brass legs (100gps).'
})

keywordHandler:addKeyword({'shields'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I buy demon (40k), vampire (20k), medusa (10k), amazon (5k), crown (8k), tower (8k), dragon (8k), guardian (3k), beholder (2k), battle (200gps), plate (100gps), steel (160gps), scarab (2k), castle (1k) and dwarven shields (200gps), also mastermind shield (70k).'
})

keywordHandler:addKeyword({'swords'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I buy giant (30k), bright (20k), fire (7k) serpent (1k), spike (500gps) and two-handed swords (900gps), also ice rapiers (2k), broad swords (500gps), longsword (100gps), short swords (60gps), sabres (50gps), katana (30gps) and swords (50gps).'
})

keywordHandler:addKeyword({'axes'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I buy fire (8k), guardian halberds (10k) knight (3k), barbarian (300gps), obsidian lances (1k), double (520gps) and battle axes (160gps), also dragon lances (25k) and golden sickles (600gps), halberds (800gps) and hatchets (50gps).'
})

keywordHandler:addKeyword({'clubs'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I buy dragon (3k), war hammers (2k) and battle hammers (240gps), mace (60gps), morning stars (200gps) also skull staffs (10k) and clerical maces (400gps).'
})

keywordHandler:addKeyword({'job'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I am the owner of this weapon shop.'
})

keywordHandler:addKeyword({'mission'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I have no ones for you now.'
})

keywordHandler:addKeyword({'quest'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I have no ones for you now.'
})

keywordHandler:addKeyword({'offer'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I am buying swords, axes, clubs, helmets, armors, legs, shields and boots.'
})

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
