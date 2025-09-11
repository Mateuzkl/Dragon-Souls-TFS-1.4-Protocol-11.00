local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local TRAVEL_CONFIG = {
    destinations = {
        castle = {x = 543, y = 528, z = 6, cost = 100, premium = false},
        raccoon = {x = 209, y = 74, z = 6, cost = 300, premium = true},
        edron = {x = 736, y = 795, z = 6, cost = 400, premium = true},
        tirith = {x = 476, y = 293, z = 6, cost = 400, premium = true},
        draynor = {x = 250, y = 442, z = 6, cost = 800, premium = true},
        bree = {x = 818, y = 2030, z = 6, cost = 500, premium = true}
    },
    dropPos = {x = 541, y = 456, z = 5}
}

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    if msgcontains(msg, 'castle') then
        selfSay('Do you wish to travel to Castle of Carlin for 100 gold coins?', cid)
        npcHandler.topic[cid] = 1
        
    elseif msgcontains(msg, 'raccoon') then
        selfSay('Do you wish to travel to Raccoon for 300 gold coins?', cid)
        npcHandler.topic[cid] = 2
        
    elseif msgcontains(msg, 'edron') then
        selfSay('Do you wish to travel to Edron for 400 gold coins?', cid)
        npcHandler.topic[cid] = 3
        
    elseif msgcontains(msg, 'tirith') then
        selfSay('Do you wish to travel to Minas Tirith for 400 gold coins?', cid)
        npcHandler.topic[cid] = 4
        
    elseif msgcontains(msg, 'draynor') then
        selfSay('Well... I promised to myself that I would never travel back there, but if you pay me... hmm.. 800 coins we have a deal! Wanna go?', cid)
        npcHandler.topic[cid] = 5
        
    elseif msgcontains(msg, 'bree') then
        selfSay('Do you wish to travel to Bree for 500 gold coins?', cid)
        npcHandler.topic[cid] = 6
        
    elseif msgcontains(msg, 'yes') then
        local topic = npcHandler.topic[cid]
        
        if topic == 1 then
            local dest = TRAVEL_CONFIG.destinations.castle
            if player:removeMoney(dest.cost) then
                player:teleportTo(Position(dest))
                Position(dest):sendMagicEffect(CONST_ME_TELEPORT)
                Game.createItem(2152, 1, Position(TRAVEL_CONFIG.dropPos))
            else
                selfSay('Sorry, you don\'t have enough money.', cid)
            end
            npcHandler.topic[cid] = 0
            
        elseif topic == 5 then
            selfSay('Are you sure you wanna go there? I will not be there to bring you back... You will have to find the way out yourself! Wanna go anyway?', cid)
            npcHandler.topic[cid] = 7
            
        elseif topic == 7 then
            local dest = TRAVEL_CONFIG.destinations.draynor
            if dest.premium and not player:isPremium() then
                selfSay('Sorry, only premiums can travel with me.', cid)
            elseif player:removeMoney(dest.cost) then
                player:teleportTo(Position(dest))
                Position(dest):sendMagicEffect(CONST_ME_TELEPORT)
                selfSay('Good luck!', cid)
            else
                selfSay('Sorry, you don\'t have enough money.', cid)
            end
            npcHandler.topic[cid] = 0
            
        elseif topic >= 2 and topic <= 6 then
            local destinations = {'', 'raccoon', 'edron', 'tirith', '', 'bree'}
            local destName = destinations[topic]
            if destName then
                local dest = TRAVEL_CONFIG.destinations[destName]
                if dest.premium and not player:isPremium() then
                    selfSay('Sorry, only premiums can travel with me.', cid)
                elseif player:removeMoney(dest.cost) then
                    player:teleportTo(Position(dest))
                    Position(dest):sendMagicEffect(CONST_ME_TELEPORT)
                    selfSay('Set the sails!', cid)
                else
                    selfSay('Sorry, you don\'t have enough money.', cid)
                end
            end
            npcHandler.topic[cid] = 0
        end
        
    elseif msgcontains(msg, 'no') then
        if npcHandler.topic[cid] == 7 then
            selfSay('Thank God! I was having a terrible feeling.', cid)
        else
            selfSay('Ok then.', cid)
        end
        npcHandler.topic[cid] = 0
    end
    
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

keywordHandler:addKeyword({'destination'}, StdModule.say, {npcHandler = npcHandler, text = 'I can take you to Edron, Raccoon, Minas Tirith, to the castle of carlin, for just a small fee... And I know the way to Draynor Island'})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = 'I am the Captain of this ship.'})
keywordHandler:addKeyword({'mission', 'quest'}, StdModule.say, {npcHandler = npcHandler, text = 'Since I got busted by pirates in Draynor Island, I never get involved in quests again... You should look around there.'})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, text = 'I can take you to Edron, Raccoon, Minas Tirith, Bree, to the castle of carlin, for just a small fee... And I know the way to Draynor Island.'})
