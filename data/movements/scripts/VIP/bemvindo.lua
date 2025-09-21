function onStepIn(creature, item, position, fromPosition)
    if not creature:isPlayer() then
        return true
    end
    
    local player = creature
    
    if item:getActionId() == 61124 then
        position:sendAnimatedText("Bem Vindo a Cidade VIP", TEXTCOLOR_BLUE)
        position:sendMagicEffect(65)
    end
    
    return true
end
