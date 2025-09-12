local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end
function onThink()                          npcHandler:onThink()                        end

local topicList = {
    NONE = 0,
    FAVOR_CONFIRM = 2,
    SKIRT_CHECK = 3,
    DRAGON_SHIELD_CHECK = 4,
    HELP_TUTORIAL_1 = 10,
    HELP_TUTORIAL_2 = 11,
    HELP_TUTORIAL_3 = 12,
    MATERIALS_CONFIRM = 13,
    IRON_NUGGETS_CHECK = 14
}

local function creatureSayCallback(cid, msgType, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    local abs = player:getStorageValue(5908)
    local black = player:getStorageValue(2026)
    
    if msgcontains(msg, 'mission') then
        if abs == -1 then
            npcHandler:say('Oh, I dont have any mission for you, its only a favor, I will dance whit my wife on next tavern event, but she need one bast skirt, do you think you can find one for me?', cid)
            npcHandler.topic[cid] = topicList.FAVOR_CONFIRM
        elseif abs == 1 then
            npcHandler:say('Oh, I said to you, its not a mission, its a favor, so... You bring me a bast skirt?', cid)
            npcHandler.topic[cid] = topicList.SKIRT_CHECK
        elseif abs >= 2 then
            npcHandler:say('Oh, I dont have nothing to you at this moment.', cid)
            npcHandler.topic[cid] = topicList.NONE
        end
    elseif msgcontains(msg, 'skirt') and abs == 1 then
        npcHandler:say('Oh, I really need that! You bring me the bast skirt?', cid)
        npcHandler.topic[cid] = topicList.SKIRT_CHECK
    elseif msgcontains(msg, 'draconian') and abs == 2 then
        npcHandler:say('Oh, I can do one piece for you, only bring me a dragon shield, do you got one?', cid)
        npcHandler.topic[cid] = topicList.DRAGON_SHIELD_CHECK
    elseif msgcontains(msg, 'draconian') and abs == 3 then
        npcHandler:say('Oh, I really did one for you!', cid)
        npcHandler.topic[cid] = topicList.NONE
    elseif msgcontains(msg, 'materials') then
        if black == -1 then
            npcHandler:say('Oh, I need two Iron Nuggets to forge the BlackSmith Hammer, Do you think you can found TWO of this metal?', cid)
            npcHandler.topic[cid] = topicList.MATERIALS_CONFIRM
        elseif black == 1 then
            npcHandler:say('Oh, you again... Did you manage to found the materials I asked?', cid)
            npcHandler.topic[cid] = topicList.IRON_NUGGETS_CHECK
        elseif black == 2 then
            npcHandler:say('Nah.. I dont need anything now.', cid)
            npcHandler.topic[cid] = topicList.NONE
        end
    elseif msgcontains(msg, 'blacksmith') then
        if black == -1 then
            npcHandler:say('I am looking for Materials to create and sell it!', cid)
        elseif black == 2 then
            npcHandler:say('You already have yours!', cid)
        end
        npcHandler.topic[cid] = topicList.NONE
    elseif msgcontains(msg, 'job') then
        npcHandler:say('I am the BlackSmith Master of the town, say HELP for an forging tutorial', cid)
        npcHandler.topic[cid] = topicList.NONE
    elseif msgcontains(msg, 'help') then
        npcHandler:say('First you have to go down to our mines and get some iron, then you place them in the anvil..hmm.. 10 should do it..say Continue', cid)
        npcHandler.topic[cid] = topicList.HELP_TUTORIAL_1
    elseif msgcontains(msg, 'continue') and npcHandler.topic[cid] == topicList.HELP_TUTORIAL_1 then
        npcHandler:say('With the iron placed there, you shoul hit it several times with an BlackSmith Hammer... you should get Iron Solid, Continue hitting it until you get an Weapon Model... say Continue', cid)
        npcHandler.topic[cid] = topicList.HELP_TUTORIAL_2
    elseif msgcontains(msg, 'continue') and npcHandler.topic[cid] == topicList.HELP_TUTORIAL_2 then
        npcHandler:say('When you get the Model , put it on the Fire Field and wait until it get realy hot, then you place it on the anvil and hit it with the hammer, when the smoke stops to come out...say Continue', cid)
        npcHandler.topic[cid] = topicList.HELP_TUTORIAL_3
    elseif msgcontains(msg, 'continue') and npcHandler.topic[cid] == topicList.HELP_TUTORIAL_3 then
        npcHandler:say('...when the smoke stops to come out you throw water on it. Simple!', cid)
        npcHandler.topic[cid] = topicList.NONE
    elseif msgcontains(msg, 'yes') then
        if npcHandler.topic[cid] == topicList.FAVOR_CONFIRM then
            npcHandler:say('OH! Thank you! Im really happy now! Im waiting you!', cid)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Nova quest adicionada 'Mais que um favor!'.")
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
            player:setStorageValue(5908, 1)
            npcHandler.topic[cid] = topicList.NONE
        elseif npcHandler.topic[cid] == topicList.SKIRT_CHECK then
            if player:getItemCount(3983) >= 1 then
                npcHandler:say('OH! You are really a good friend! And by the way, I learnt how to forje a rare metal, the name is Draconian Steel, I can do one for you, only bring me a dragon shield, and ask me about draconian steel! Oh... My little dwarf will love that!', cid)
                player:removeItem(3983, 1)
                player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
                player:setStorageValue(5908, 2)
                npcHandler.topic[cid] = topicList.NONE
            else
                npcHandler:say('OH! But where it are?', cid)
            end
        elseif npcHandler.topic[cid] == topicList.DRAGON_SHIELD_CHECK then
            if player:getItemCount(2516) >= 1 then
                npcHandler:say('OH! Here it is my friend! Willian would be crazy if he see that, hehe. Well, i need back to work! See Ya.', cid)
                player:removeItem(2516, 1)
                player:addItem(5889, 1)
                player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
                player:setStorageValue(5908, 3)
                npcHandler.topic[cid] = topicList.NONE
            else
                npcHandler:say('Oh! But i cant see the dragon shield.', cid)
            end
        elseif npcHandler.topic[cid] == topicList.MATERIALS_CONFIRM then
            npcHandler:say('HAHA! Only the most Ancient Mines have it in their walls, I doubt you can found one , and i need TWO ha! Good Luck, You will need it!', cid)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Nova quest adicionada 'Em busca dos materiais!'.")
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
            player:setStorageValue(2026, 1)
            npcHandler.topic[cid] = topicList.NONE
        elseif npcHandler.topic[cid] == topicList.IRON_NUGGETS_CHECK then
            if player:getItemCount(13641) >= 2 then
                npcHandler:say('OH! You realy did it! Here is you hammer!', cid)
                player:removeItem(13641, 2)
                player:addItem(2321, 1)
                player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
                player:setStorageValue(2026, 2)
                npcHandler.topic[cid] = topicList.NONE
            else
                npcHandler:say('OH! But where are them?', cid)
            end
        end
    elseif msgcontains(msg, 'no') and npcHandler.topic[cid] > topicList.NONE then
        npcHandler:say('Ok than.', cid)
        npcHandler.topic[cid] = topicList.NONE
    end
    
    return true
end

keywordHandler:addKeyword({'offer'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I can teach you how to make itens by forging. But in the moment, I dont have the materials to make the Blacksmith Hammer.'
})

keywordHandler:addKeyword({'sell'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'Do i look like some Shopkeeper?'
})

keywordHandler:addKeyword({'buy'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'Do i look like some Shopkeeper?'
})

keywordHandler:addKeyword({'quest'}, StdModule.say, {
    npcHandler = npcHandler, 
    onlyFocus = true, 
    text = 'I have more important things to do.'
})

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
