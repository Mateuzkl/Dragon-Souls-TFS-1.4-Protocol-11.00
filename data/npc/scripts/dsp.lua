local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end
function onThink()                          npcHandler:onThink()                        end

-- Trade system
local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

-- Items for sale (DSP exchange items)
shopModule:addBuyableItem({'uh', 'ultimate healing'}, 2273, 10, 20, 'ultimate healing rune')
shopModule:addBuyableItem({'explosion'}, 2313, 15, 60, 'explosion rune')
shopModule:addBuyableItem({'sd', 'sudden death'}, 2268, 20, 20, 'sudden death rune')
shopModule:addBuyableItem({'gfb', 'great fireball'}, 2304, 10, 40, 'great fireball rune')
shopModule:addBuyableItem({'hmm', 'heavy magic missile'}, 2311, 5, 100, 'heavy magic missile rune')
shopModule:addBuyableItem({'destroy field'}, 2261, 5, 60, 'destroy field rune')
shopModule:addBuyableItem({'life ring'}, 2168, 10, 1, 'life ring')
shopModule:addBuyableItem({'ring of healing'}, 2214, 20, 1, 'ring of healing')
shopModule:addBuyableItem({'mana fluid'}, 38898, 15, 100, 'large mana fluid')
shopModule:addBuyableItem({'blessed ring'}, 6301, 40, 1, 'blessed ring')
shopModule:addBuyableItem({'teleport'}, 2260, 25, 10, 'teleport rune')
shopModule:addBuyableItem({'small elixir', 'small elixir of experience'}, 38896, 30, 50, 'small elixir of experience')
shopModule:addBuyableItem({'normal elixir', 'normal elixir of experience'}, 38895, 50, 50, 'normal elixir of experience')
shopModule:addBuyableItem({'fighting spirit'}, 5884, 50, 1, 'fighting spirit')
shopModule:addBuyableItem({'energetico'}, 7439, 20, 1, 'energetico')
shopModule:addBuyableItem({'blood', 'blood of gods'}, 38943, 50, 20, 'blood of gods')

-- Items that can be sold (DSP as currency)
shopModule:addSellableItem({'dragon soul', 'dsp', 'dragon souls'}, 6527, 1, 'dragon soul points')

-- Configure shop to use DSP as currency
shopModule:addBuyableItemContainer({'uh backpack', 'uh bp'}, 2002, 6527, 10, 2273, 20, 20)
shopModule:addBuyableItemContainer({'explosion backpack', 'explosion bp'}, 2001, 6527, 15, 2313, 20, 60)
shopModule:addBuyableItemContainer({'sd backpack', 'sd bp'}, 2002, 6527, 20, 2268, 20, 20)
shopModule:addBuyableItemContainer({'gfb backpack', 'gfb bp'}, 2002, 6527, 10, 2304, 20, 40)
shopModule:addBuyableItemContainer({'hmm backpack', 'hmm bp'}, 2002, 6527, 5, 2311, 20, 100)
shopModule:addBuyableItemContainer({'destroy field backpack', 'destroy field bp'}, 2002, 6527, 5, 2261, 20, 60)
shopModule:addBuyableItemContainer({'life ring backpack', 'life ring bp'}, 2002, 6527, 10, 2168, 20, 1)
shopModule:addBuyableItemContainer({'ring of healing backpack', 'ring of healing bp'}, 2002, 6527, 20, 2214, 20, 1)
shopModule:addBuyableItemContainer({'blessed ring backpack', 'blessed ring bp'}, 2002, 6527, 40, 6301, 20, 1)

-- Premium service function
local function grantPremiumDays(cid, days, cost)
    local player = Player(cid)
    if player:getItemCount(6527) >= cost then
        player:removeItem(6527, cost)
        player:addPremiumDays(days)
        return true
    end
    return false
end

local function creatureSayCallback(cid, msgType, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    local dsp = player:getItemCount(6527)
    
    if msgcontains(msg, 'job') then
        npcHandler:say('I am a merchant, lost in the wonders of this world!', cid)
    elseif msgcontains(msg, 'offer') then
        npcHandler:say('I have runes, rings, potions and premium days! Just say {trade} to see my offers or ask for specific items!', cid)
    elseif msgcontains(msg, 'trade') then
        npcHandler:say('Here are my wares! I accept Dragon Soul Points as payment.', cid)
        shopModule:sendOfferWindow(cid)
    elseif msgcontains(msg, 'quest') or msgcontains(msg, 'mission') then
        npcHandler:say('I am not getting involved in quests anymore!', cid)
    elseif msgcontains(msg, 'knowledge') then
        npcHandler:say('I have been in long trips and quests! One more dangerous than the other, now i am just traveling and wondering the world beauties!', cid)
    elseif msgcontains(msg, 'addon') or msgcontains(msg, 'backpack') then
        npcHandler:say('Ahh, this backpack? It\'s a present from Brian.', cid)
    elseif msgcontains(msg, 'premium') then
        npcHandler:say('I can give you 30 premium days for 100 DSP. Do you want it?', cid)
        npcHandler.topic[cid] = 1
    elseif msgcontains(msg, 'cirurgia') or msgcontains(msg, 'surgery') then
        npcHandler:say('I can perform a sex change surgery for 10 gold pieces. Do you want it?', cid)
        npcHandler.topic[cid] = 2
    elseif msgcontains(msg, 'free premmy') or msgcontains(msg, 'free premium') then
        if not player:isPremium() then
            npcHandler:say('You will get 15 days of premium for free, but only this time! Do you accept?', cid)
            npcHandler.topic[cid] = 3
        else
            npcHandler:say('Sorry, but you already have premium account.', cid)
        end
    elseif npcHandler.topic[cid] == 1 and msgcontains(msg, 'yes') then
        if grantPremiumDays(cid, 30, 100) then
            npcHandler:say('Here you go! 30 premium days added to your account. Please relog.', cid)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You received 30 premium days.')
        else
            npcHandler:say('Sorry, you don\'t have enough Dragon Soul Points.', cid)
        end
        npcHandler.topic[cid] = 0
    elseif npcHandler.topic[cid] == 2 and msgcontains(msg, 'yes') then
        if player:removeMoney(10) then
            local newSex = player:getSex() == PLAYERSEX_MALE and PLAYERSEX_FEMALE or PLAYERSEX_MALE
            player:setSex(newSex)
            npcHandler:say('Surgery completed! You are now ' .. (newSex == PLAYERSEX_MALE and 'male' or 'female') .. '.', cid)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Your sex has been changed.')
        else
            npcHandler:say('Sorry, you don\'t have enough gold.', cid)
        end
        npcHandler.topic[cid] = 0
    elseif npcHandler.topic[cid] == 3 and msgcontains(msg, 'yes') then
        player:addPremiumDays(15)
        npcHandler:say('Here you go! 15 free premium days. Please relog your account.', cid)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You received 15 free premium days.')
        npcHandler.topic[cid] = 0
    elseif msgcontains(msg, 'no') and npcHandler.topic[cid] > 0 then
        npcHandler:say('Ok then.', cid)
        npcHandler.topic[cid] = 0
    
    elseif msgcontains(msg, 'no') and npcHandler.topic[cid] > 0 then
        npcHandler:say('Ok then.', cid)
        npcHandler.topic[cid] = 0
    end
    
    return true
end

npcHandler:setMessage(MESSAGE_GREET, 'Hello |PLAYERNAME|! I am a merchant, lost in the wonders of this world!')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye then.')
npcHandler:setMessage(MESSAGE_DECLINE, 'Sorry, |PLAYERNAME|! I talk to you in a minute.')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
