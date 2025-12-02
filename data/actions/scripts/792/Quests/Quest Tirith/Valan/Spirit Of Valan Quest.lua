function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local vocation = player:getVocation():getId()
    local questStatus = player:getStorageValue(2361)
    
    local vocationMap = {
        [1] = "Sorcerer's",
        [2] = "Druid's",
        [3] = "Archer's",
        [4] = "Knight's",
        [5] = "Wyzard's",
        [6] = "Cleric's", 
        [7] = "Ranger's",
        [8] = "Slayer's"
    }
    
    local vocationName = vocationMap[vocation]
    
    if vocationName then
        if questStatus == -1 then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Você recebeu o Espírito de um Valan.")
            
            local rewardItem = player:addItem(2361, 1)
            if rewardItem then
                rewardItem:setAttribute("description", "Esse item é uma recordação com a vocação " .. vocationName .. " " .. player:getName() .. " Obrigado pela Valan Quest.")
            end
            
            toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
            Game.sendAnimatedText("Cleck!", toPosition, TEXTCOLOR_LIGHTGREEN)
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
            
            player:showTextDialog(2180, "Parabéns ao ter chegado aqui, agora crie um novo jogador e esse spirit of valan no seu novo char level 8 ele irá ser seu novo valan.")
            
            player:setStorageValue(2361, 1)
        else
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Desculpe, você já pegou este item. Só pode pegar uma vez por jogador.")
        end
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Desculpe, mas você não tem vocação necessária.")
    end
    
    return true
end
