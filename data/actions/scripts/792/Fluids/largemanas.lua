local EXHAUSTED_SECONDS = 1
local EXHAUSTED_STORAGE = 9893
local LARGE_MANA_FLUID = 13690

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if os.time() < player:getStorageValue(EXHAUSTED_STORAGE) then
        player:sendCancelMessage("Você não pode usar este objeto.")
        return true
    end
    
    local maxMana = player:getMaxMana()
    local minMana = math.floor(5 * maxMana / 100) + 250
    local maxManaGain = math.floor(5 * maxMana / 100) + 305
    local manaGain = math.random(minMana, maxManaGain)
    
    player:addMana(manaGain)
    Game.sendAnimatedText("Aaaahh..", player:getPosition(), TEXTCOLOR_ORANGE)
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
    player:setStorageValue(EXHAUSTED_STORAGE, os.time() + EXHAUSTED_SECONDS)
    
    if item:getCount() > 1 then
        item:remove(1)
    else
        item:remove()
    end
    
    return true
end
