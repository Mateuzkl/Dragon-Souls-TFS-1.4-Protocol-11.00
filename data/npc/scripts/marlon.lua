local STORAGE = 100010
local ITEM = 2403
local QUANT = 50
local PREMIO = 13685
local PQUANT = 50

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

function santaNPC(cid, message, keywords, parameters, node)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    if parameters.present == true then
        local storage = player:getStorageValue(STORAGE)
        
        if storage == 1 and player:getItemCount(ITEM) >= QUANT then
            player:removeItem(ITEM, QUANT)
            player:addItem(PREMIO, PQUANT)
            player:setStorageValue(STORAGE, 2)
            npcHandler:say('Obrigado!', cid)
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Você completou a missão!")
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
            
        elseif storage >= 2 then
            npcHandler:say('Você já completou essa missão.', cid)
            
        elseif storage < 1 then
            npcHandler:say('Você não falou com Frederic.', cid)
            
        elseif player:getItemCount(ITEM) < QUANT then
            npcHandler:say('Você não tem o item que Frederic te deu.', cid)
        end
    end
    
    npcHandler:resetNpc()
    return true
end

npcHandler:setMessage(MESSAGE_GREET, 'Olá |PLAYERNAME|. Diga {mission} para prosseguir essa missão.')

local noNode = KeywordNode:new({'no'}, santaNPC, {present = false})
local yesNode = KeywordNode:new({'yes'}, santaNPC, {present = true})

local node = keywordHandler:addKeyword({'mission'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Frederic mandou você me entregar os knife? {yes}'})
node:addChildKeywordNode(yesNode)
node:addChildKeywordNode(noNode)

npcHandler:addModule(FocusModule:new())
