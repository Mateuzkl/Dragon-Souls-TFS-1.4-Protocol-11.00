function onCastSpell(cid, var)
    local itemID = 38780  -- ID do item a ser criado
    local itemAmount = 1 -- Quantidade do item a ser criado

    local player = Player(cid)

    -- Verifica se o jogador tem espaço suficiente no inventário
    if player:getFreeCapacity() < getItemWeight(itemID, itemAmount) then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Você não tem capacidade suficiente no inventário.")
        return false
    end

    -- Cria o item no inventário do jogador
    local item = player:addItem(itemID, itemAmount)

    -- Verifica se o item foi adicionado com sucesso
    if item then
        -- Exibe uma mensagem e um efeito visual
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Você criou " .. itemAmount .. " " .. getItemNameById(itemID, false) .. ".")
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
        return true
    else
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "Falha ao criar o item.")
        return false
    end
end
