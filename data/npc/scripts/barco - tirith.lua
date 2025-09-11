local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local TRAVEL_CONFIG = {
    destinations = {
        carlin = {x = 151, y = 356, z = 6, cost = 200, premium = true},
        raccoon = {x = 209, y = 74, z = 6, cost = 300, premium = true},
        edron = {x = 736, y = 795, z = 6, cost = 400, premium = true},
        bree = {x = 818, y = 2030, z = 6, cost = 500, premium = true}
    },
    rewardPos = {x = 540, y = 456, z = 5}
}

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    if msgcontains(msg, 'carlin') then
        selfSay('Do you wish to travel to Carlin for 200 gold coins?', cid)
        npcHandler.topic[cid] = 1
        
    elseif msgcontains(msg, 'raccoon') then
        selfSay('Do you wish to travel to Raccoon for 300 gold coins?', cid)
        npcHandler.topic[cid] = 2
        
    elseif msgcontains(msg, 'edron') then
        selfSay('Do you wish to travel to Edron for 400 gold coins?', cid)
        npcHandler.topic[cid] = 3
        
    elseif msgcontains(msg, 'bree') then
        selfSay('Do you wish to travel to Bree for 500 gold coins?', cid)
        npcHandler.topic[cid] = 4
        
    elseif msgcontains(msg, 'yes') then
        local topic = npcHandler.topic[cid]
        if topic >= 1 and topic <= 4 then
            local destinations = {'carlin', 'raccoon', 'edron', 'bree'}
            local destName = destinations[topic]
            local dest = TRAVEL_CONFIG.destinations[destName]
            
            if dest.premium and not player:isPremium() then
                selfSay('Sorry, only premiums can travel with me.', cid)
            elseif player:removeMoney(dest.cost) then
                player:teleportTo(Position(dest))
                Position(dest):sendMagicEffect(CONST_ME_TELEPORT)
                if destName == 'carlin' then
                    Game.createItem(2152, 2, Position(TRAVEL_CONFIG.rewardPos))
                end
                selfSay('Set the sails!', cid)
            else
                selfSay('Sorry, you don\'t have enough money.', cid)
            end
            npcHandler.topic[cid] = 0
        end
        
    elseif msgcontains(msg, 'no') and npcHandler.topic[cid] >= 1 then
        selfSay('I wouldn\'t go there either.', cid)
        npcHandler.topic[cid] = 0
    end
    
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

keywordHandler:addKeyword({'destination'}, StdModule.say, {npcHandler = npcHandler, text = 'I can take you to Carlin, Raccoon and Edron for just a small fee.'})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = 'I am the Captain of this ship.'})
keywordHandler:addKeyword({'mission', 'quest'}, StdModule.say, {npcHandler = npcHandler, text = 'Since I got busted by pirates, I never get involved in quests again.'})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, text = 'I can take you to Carlin, Raccoon, Edron and Bree for just a small fee.'})
