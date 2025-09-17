local foods = {
    {itemID = 2666, quantity = 3},  
    {itemID = 2671, quantity = 2},  
    {itemID = 2681, quantity = 5},  
    {itemID = 2674, quantity = 4}, 
    {itemID = 2689, quantity = 1}, 
    {itemID = 2690, quantity = 2},  
    {itemID = 2696, quantity = 3}  
}

function onCastSpell(creature, variant)
    local itemToAdd = foods[math.random(#foods)]
    local quantityToAdd = itemToAdd.quantity or 1
    for i = 1, quantityToAdd do
        creature:addItem(itemToAdd.itemID)
    end
    creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
    return true
end
