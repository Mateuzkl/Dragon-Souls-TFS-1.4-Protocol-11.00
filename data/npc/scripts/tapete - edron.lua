local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local talkState = {}

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local itemPosition = {x=539, y=456, z=5}

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    local state = talkState[cid] or 0
    
    if msgcontains(msg, 'hills') or msgcontains(msg, 'femur') then
        npcHandler:say('Do you wish to travel to Femur hills for 400 gold coins?', cid)
        talkState[cid] = 1
        
    elseif state == 1 then
        if msgcontains(msg, 'yes') then
            if player:removeTotalMoney(400) then
                player:teleportTo(Position(307, 378, 4))
                Position(307, 378, 4):sendMagicEffect(CONST_ME_TELEPORT)
                Game.createItem(2152, 4, Position(itemPosition))
                npcHandler:say('Have a safe trip!', cid)
                talkState[cid] = 0
            else
                npcHandler:say('Sorry, you don\'t have enough money.', cid)
                talkState[cid] = 0
            end
        elseif msgcontains(msg, 'no') then
            npcHandler:say('I wouldn\'t go there either.', cid)
            talkState[cid] = 0
        end
    end
    
    return true
end

local function onAddFocus(cid)
    talkState[cid] = 0
end

local function onReleaseFocus(cid)
    talkState[cid] = nil
end

npcHandler:setCallback(CALLBACK_ONADDFOCUS, onAddFocus)
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, onReleaseFocus)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

keywordHandler:addKeyword({'destination'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I can take you to Femur Hills for just a small fee.'})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am the Carpet Man!'})
keywordHandler:addKeyword({'mission'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I never get involved in quests.'})
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I never get involved in quests.'})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I can take you to Femur Hills for just a small fee.'})
