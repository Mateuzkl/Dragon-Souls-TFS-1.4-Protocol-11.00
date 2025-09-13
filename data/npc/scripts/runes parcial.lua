local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                          npcHandler:onThink() end

-- Shop Module for regular items
local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

-- Regular runes
shopModule:addBuyableItem({'ultimate healing', 'uh'}, 2273, 175, 1, 'ultimate healing rune')
shopModule:addBuyableItem({'sudden death', 'sd'}, 2268, 325, 1, 'sudden death rune')
shopModule:addBuyableItem({'great fireball', 'gfb'}, 2304, 90, 3, 'great fireball rune')
shopModule:addBuyableItem({'explosion', 'xpl', 'explo'}, 2313, 85, 3, 'explosion rune')
shopModule:addBuyableItem({'heavy magic missile', 'hmm'}, 2311, 25, 5, 'heavy magic missile rune')

-- Other items
shopModule:addBuyableItem({'light wand', 'lightwand'}, 2163, 500, 1, 'magic light wand')
shopModule:addBuyableItem({'mana fluid', 'manafluid'}, 2006, 100, 7, 'mana fluid')
shopModule:addBuyableItem({'life fluid', 'lifefluid'}, 2006, 80, 10, 'life fluid')
shopModule:addBuyableItem({'blank', 'rune'}, 2260, 10, 1, 'blank rune')

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local player = Player(cid)
    if not player then
        return false
    end

    local talk_state = npcHandler.topic[cid] or 0

    -- Special backpack deals
    if msgcontains(msg, 'bp of hmms') then
        selfSay('Do you want to buy a backpack of heavy magic missiles for 25 gold coins?', cid)
        npcHandler.topic[cid] = 1

    elseif msgcontains(msg, 'bp of explosions') then
        selfSay('Do you want to buy a backpack of explosions for 25 gold coins?', cid)
        npcHandler.topic[cid] = 2

    elseif msgcontains(msg, 'yes') and talk_state == 1 then
        if player:removeMoney(25) then
            local backpack = player:addItem(1988, 1) -- backpack
            if backpack then
                -- Add 20 heavy magic missile runes with 5 charges each
                for i = 1, 20 do
                    local rune = backpack:addItem(2311, 5)
                    if not rune then
                        player:addItem(2311, 5) -- Add to player if backpack is full
                    end
                end
                selfSay('Here you go.', cid)
                player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
            end
        else
            selfSay('You do not have enough money.', cid)
        end
        npcHandler.topic[cid] = 0

    elseif msgcontains(msg, 'yes') and talk_state == 2 then
        if player:removeMoney(25) then
            local backpack = player:addItem(2001, 1) -- bag
            if backpack then
                -- Add 20 explosion runes with 3 charges each
                for i = 1, 20 do
                    local rune = backpack:addItem(2313, 3)
                    if not rune then
                        player:addItem(2313, 3) -- Add to player if bag is full
                    end
                end
                selfSay('Here you go.', cid)
                player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
            end
        else
            selfSay('You do not have enough money.', cid)
        end
        npcHandler.topic[cid] = 0

    elseif msgcontains(msg, 'no') and (talk_state == 1 or talk_state == 2) then
        selfSay('Too expensive you think?', cid)
        npcHandler.topic[cid] = 0

    elseif msgcontains(msg, 'job') then
        selfSay('I am the shopkeeper of this magic shop.', cid)

    elseif msgcontains(msg, 'offer') then
        selfSay('I offer several kinds of magical runes and other magical items.', cid)

    elseif msgcontains(msg, 'sell') then
        selfSay('I am not buying anything.', cid)

    elseif msgcontains(msg, 'quest') then
        selfSay('A quest is nothing I want to be involved in.', cid)

    elseif msgcontains(msg, 'mission') then
        selfSay('I cannot help you in that area, son.', cid)

    elseif msgcontains(msg, 'help') then
        selfSay('I sell runes and magical items. Say "offer" to see what I have, or try abbreviations like "sd", "uh", "gfb".', cid)
    end

    return true
end

function onGreet(cid)
    local player = Player(cid)
    if not player then
        return false
    end
    
    selfSay('Hello ' .. player:getName() .. '! Welcome to my rune shop!', cid)
    npcHandler.topic[cid] = 0
    return true
end

function onFarewell(cid)
    local player = Player(cid)
    if not player then
        return false
    end
    
    selfSay('Good bye, ' .. player:getName() .. '!', cid)
    npcHandler.topic[cid] = 0
    return true
end

-- Keywords for additional functionality
keywordHandler:addKeyword({'backpack'}, StdModule.say, {npcHandler = npcHandler, text = 'I sell special backpacks with runes! Ask about "bp of hmms" or "bp of explosions".'})
keywordHandler:addKeyword({'special'}, StdModule.say, {npcHandler = npcHandler, text = 'I have special deals on backpacks filled with runes!'})

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
