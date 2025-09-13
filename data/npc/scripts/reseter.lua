local config = {
    minlevel = 150,      -- level inicial para resetar
    price = 10000,       -- preco inicial para resetar
    newlevel = 20,       -- level apos reset
    priceByReset = 0,    -- preco acrescentado por reset
    percent = 100,       -- porcentagem da vida/mana que voce tera ao resetar
    maxresets = 50,      -- maximo de resets
    levelbyreset = 0     -- quanto de level vai precisar a mais no proximo reset
}

function getResets(uid)
    local player = Player(uid)
    if not player then
        return 0
    end
    local resets = player:getStorageValue(378378)
    if resets < 0 then
        resets = 0
    end
    return resets
end

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                          npcHandler:onThink() end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local player = Player(cid)
    if not player then
        return false
    end

    local talk_state = npcHandler.topic[cid] or 0
    local playerResets = getResets(cid)
    local newPrice = config.price + (playerResets * config.priceByReset)
    local newminlevel = config.minlevel + (playerResets * config.levelbyreset)

    function addReset(playerId)
        local resetPlayer = Player(playerId)
        if not resetPlayer then
            return false
        end
        
        local resets = getResets(playerId)
        resetPlayer:setStorageValue(378378, resets + 1)
        
        -- Teleport to temple
        local town = resetPlayer:getTown()
        if town then
            resetPlayer:teleportTo(town:getTemplePosition())
        end
        
        -- Adjust HP
        local hp = resetPlayer:getMaxHealth()
        local resethp = math.floor(hp * (config.percent / 100))
        resetPlayer:setMaxHealth(resethp)
        resetPlayer:addHealth(resethp - resetPlayer:getHealth())
        
        -- Adjust Mana  
        local mana = resetPlayer:getMaxMana()
        local resetmana = math.floor(mana * (config.percent / 100))
        resetPlayer:setMaxMana(resetmana)
        resetPlayer:addMana(resetmana - resetPlayer:getMana())
        
        -- Update database
        local playerId = resetPlayer:getGuid()
        local description = resets + 1
        
        db.query("UPDATE `players` SET `description` = ' [Reset: " .. description .. "]' WHERE `id` = " .. playerId)
        db.query("UPDATE `players` SET `level` = " .. config.newlevel .. ", `experience` = 0 WHERE `id` = " .. playerId)
        
        -- Remove player (disconnect)
        resetPlayer:remove()
        return true
    end

    if msgcontains(msg, 'reset') then
        if playerResets < config.maxresets then
            selfSay('You want to reset your character? It will cost ' .. newPrice .. ' gp\'s!', cid)
            npcHandler.topic[cid] = 1
        else
            selfSay('You already reached the maximum reset level!', cid)
        end
        
    elseif msgcontains(msg, 'yes') and talk_state == 1 then
        if player:getMoney() + player:getBankBalance() < newPrice then
            selfSay('Its necessary to have at least ' .. newPrice .. ' gp\'s for reseting!', cid)
        elseif player:getLevel() < newminlevel then
            selfSay('The minimum level for reseting is ' .. newminlevel .. '!', cid)
        else
            if not player:removeTotalMoney(newPrice) then
                selfSay('You do not have enough money!', cid)
                npcHandler.topic[cid] = 0
                return true
            end
            
            addEvent(function()
                addReset(cid)
            end, 3000)
            
            local number = playerResets + 1
            local msg = "---[Reset: " .. number .. "]-- You have reseted! You'll be disconnected in 3 seconds."
            player:popupFYI(msg)
            npcHandler.topic[cid] = 0
            npcHandler:releaseFocus()
        end
        
    elseif msgcontains(msg, 'no') and talk_state == 1 then
        npcHandler.topic[cid] = 0
        npcHandler:releaseFocus()
        selfSay('Ok.', cid)
        
    elseif msgcontains(msg, 'quantity') or msgcontains(msg, 'resets') then
        selfSay('You have a total of ' .. playerResets .. ' reset(s).', cid)
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'info') or msgcontains(msg, 'price') then
        selfSay('Reset costs ' .. newPrice .. ' gp. Minimum level: ' .. newminlevel .. '. You have ' .. playerResets .. ' resets.', cid)
        
    elseif msgcontains(msg, 'help') then
        selfSay('I can reset your character. Say "reset" to start, "quantity" to check your resets, or "info" for details.', cid)
    end

    return true
end

-- Keywords for additional functionality
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I help players reset their characters to start over with bonuses.'})
keywordHandler:addKeyword({'service'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I provide character reset services for experienced players.'})

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
