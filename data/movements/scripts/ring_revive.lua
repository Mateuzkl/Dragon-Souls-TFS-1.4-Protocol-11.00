local REVIVE_RING_ID = 2354
local STORAGE_COOLDOWN = 900002
local COOLDOWN_SECONDS = 5 * 60

local function canEquip(player)
    local ts = player:getStorageValue(STORAGE_COOLDOWN)
    if ts ~= -1 and ts > 0 then
        local now = os.time()
        if ts > now then
            local left = ts - now
            player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, string.format("Voce precisa aguardar %d segundos para usar o anel novamente.", left))
            return false
        else
            player:setStorageValue(STORAGE_COOLDOWN, -1)
        end
    end
    return true
end

function onEquip(player, item, slot)
    if item:getId() ~= REVIVE_RING_ID then
        return true
    end
    
    if not canEquip(player) then
        return false
    end
    
    local lastMessageTime = player:getStorageValue(12346)
    if lastMessageTime == -1 or os.time() - lastMessageTime > 2 then
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Voce equipou o Ankh of life. Voce tera efeito apos reviver. ATENCAO: Se remover o anel, ele sera perdido!")
        player:setStorageValue(12346, os.time())
    end
    return true
end

function onDeEquip(player, item, slot)
    if item:getId() ~= REVIVE_RING_ID then
        return true
    end
    
    item:remove()
    
    player:getPosition():sendMagicEffect(CONST_ME_POFF)
    
    return true
end
