local rewardChest = Action()

function rewardChest.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local rewards = {
        {id = 2160, count = 50},  -- Crystal coins
        {id = 2400, count = 1},   -- Magic sword
        {id = 8472, count = 1}    -- Frozen starlight
    }
    
    -- Pegar store inbox
    local inboxItem = player:getSlotItem(CONST_SLOT_STORE_INBOX)
    if not inboxItem then
        player:sendCancelMessage("Error: Could not find store inbox.")
        return true
    end
    
    local storeInbox = inboxItem:getContainer()
    if not storeInbox then
        player:sendCancelMessage("Error: Store inbox is not a container.")
        return true
    end
    
    -- Adicionar todas as recompensas
    local addedItems = {}
    for _, reward in pairs(rewards) do
        local rewardItem = Game.createItem(reward.id, reward.count)
        if rewardItem then
            local ret = storeInbox:addItemEx(rewardItem)
            if ret == RETURNVALUE_NOERROR then
                table.insert(addedItems, string.format("%dx %s", reward.count, ItemType(reward.id):getName()))
            else
                rewardItem:remove()
                player:sendCancelMessage(string.format("Error adding %s to store inbox.", ItemType(reward.id):getName()))
            end
        end
    end
    
    if #addedItems > 0 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Recompensas enviadas para o store inbox!")
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Itens recebidos: " .. table.concat(addedItems, ", "))
        item:remove()
    else
        player:sendCancelMessage("Nenhuma recompensa pôde ser adicionada.")
    end
    
    return true
end

rewardChest:id(8003)
rewardChest:register()