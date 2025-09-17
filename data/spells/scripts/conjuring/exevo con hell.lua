function onCastSpell(cid, var)
    local itemID = 6529  -- ID do item a ser criado
    local itemAmount = 1 -- Quantidade do item a ser criado

    -- Verifica se o jogador tem espaço suficiente no inventário
    if getPlayerFreeCap(cid) < getItemWeight(itemID, itemAmount) then
        doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Voce nao tem capacidade suficiente no inventario.")
        return false
    end

    -- Cria o item no inventário do jogador
    for i = 1, itemAmount do
        doPlayerAddItem(cid, itemID, 1)
    end

    -- Exibe uma mensagem e um efeito visual
    doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Voce criou " .. itemAmount .. " " .. getItemNameById(itemID, false) .. ".")
    doSendMagicEffect(getCreaturePosition(cid), CONST_ME_MAGIC_GREEN)

    return true
end
