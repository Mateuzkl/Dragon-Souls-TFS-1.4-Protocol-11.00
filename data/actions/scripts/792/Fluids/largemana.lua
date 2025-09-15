local exhausted_seconds = 1
local exhausted_storagevalue = 9893

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local min = math.floor(5 * player:getMaxMana() / 100) + 250
    local max = math.floor(5 * player:getMaxMana() / 100) + 305
    
    if os.time() >= player:getStorageValue(exhausted_storagevalue) then
        local mana = math.random(min, max)
        
        player:addMana(mana)
        Game.sendAnimatedText("Aaaahh..", player:getPosition(), TEXTCOLOR_ORANGE)
        player:setStorageValue(exhausted_storagevalue, os.time() + exhausted_seconds)
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
        
        if item:getCount() > 1 then
            item:remove(1)
        else
            item:remove()
        end
    else
        player:sendCancelMessage("Você não pode usar este objeto.")
    end
    
    return true
end
