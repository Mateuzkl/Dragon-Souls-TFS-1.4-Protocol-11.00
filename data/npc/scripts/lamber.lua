local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    if msgcontains(msg, 'wood') then
        selfSay('I cut woods to sell. Hard work, but honest work!', cid)
        
    elseif msgcontains(msg, 'job') then
        selfSay('I am a lumberjack! I spend my days cutting trees in the forest.', cid)
        
    elseif msgcontains(msg, 'offer') then
        selfSay('I am not selling or buying anything right now!', cid)
        
    elseif msgcontains(msg, 'sell') then
        selfSay('I am not a merchant! Try the market.', cid)
        
    elseif msgcontains(msg, 'buy') then
        selfSay('I am not a merchant! I just cut wood.', cid)
        
    elseif msgcontains(msg, 'quest') or msgcontains(msg, 'mission') then
        selfSay('I don\'t share my business with anyone!', cid)
        
    elseif msgcontains(msg, 'forest') then
        selfSay('The forest is dangerous these days. Many creatures lurk between the trees.', cid)
        
    elseif msgcontains(msg, 'tree') or msgcontains(msg, 'trees') then
        selfSay('I know every tree in this forest. Oak, pine, birch... each has its purpose.', cid)
        
    elseif msgcontains(msg, 'axe') then
        selfSay('A good axe is a lumberjack\'s best friend. Sharp and reliable!', cid)
        
    elseif msgcontains(msg, 'danger') then
        selfSay('The forest holds many dangers. Wolves, bears, and worse things roam at night.', cid)
        
    elseif msgcontains(msg, 'time') then
        selfSay('It\'s ' .. os.date('%H:%M') .. ' right now. I work from dawn to dusk.', cid)
    end
    
    return true
end

function onGreet(cid)
    local player = Player(cid)
    if player then
        selfSay('Greetings, ' .. player:getName() .. '! Welcome to my humble camp.', cid)
    end
    return true
end

function onFarewell(cid)
    local player = Player(cid)
    if player then
        selfSay('Safe travels, ' .. player:getName() .. '. Watch out for the forest creatures!', cid)
    end
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)
npcHandler:addModule(FocusModule:new())
