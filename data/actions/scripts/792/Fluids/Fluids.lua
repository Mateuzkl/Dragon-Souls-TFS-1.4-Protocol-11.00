local drunk = Condition(CONDITION_DRUNK)
drunk:setParameter(CONDITION_PARAM_TICKS, 60000)

local poison = Condition(CONDITION_POISON)
poison:addDamage(-5, 2, 6000)
poison:addDamage(-4, 3, 6000)
poison:addDamage(-3, 5, 6000)
poison:addDamage(-2, 10, 6000)
poison:addDamage(-1, 20, 6000)

local fluidType = {3, 4, 5, 7, 10, 11, 13, 15, 19, 23}
local fluidMessage = {"Aah...", "Urgh!", "Mmmh.", "Aaah.", "Aaaah...", "Urgh!", "Urgh!", "Aaaah.", "Urgh!", "Aaaaah."}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if target.itemid == 1 then
        if item.type == 0 then
            player:sendCancelMessage("It is empty.")
            return true
        end
        
        if target.uid == player:getId() then
            local fluidType = item.type
            item:transform(item:getId(), 0)
            
            if fluidType == 3 or fluidType == 15 then
                player:addCondition(drunk)
            elseif fluidType == 4 then
                player:addCondition(poison)
            elseif fluidType == 7 then
                player:addMana(math.random(100, 250))
                fromPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
            elseif fluidType == 10 then
                player:addHealth(60)
                fromPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
            elseif fluidType == 31 then
                player:addMana(math.random(250, 350))
                fromPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
            elseif fluidType == 39 then
                player:addMana(math.random(350, 500))
                fromPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
            end
            
            for i = 1, #fluidType do
                if fluidType == fluidType[i] then
                    Game.sendAnimatedText(fluidMessage[i], player:getPosition(), TEXTCOLOR_ORANGE)
                    return true
                end
            end
            
            Game.sendAnimatedText("Aaaahh..", player:getPosition(), TEXTCOLOR_ORANGE)
        else
            local splash = Game.createItem(2025, item.type, toPosition)
            item:transform(item:getId(), 0)
            if splash then
                splash:decay()
            end
        end
    elseif (target.itemid >= 490 and target.itemid <= 493) or 
           (target.itemid >= 4608 and target.itemid <= 4625) or 
           (target.itemid >= 618 and target.itemid <= 629) or 
           target.itemid == 1771 then
        item:transform(item:getId(), 9)
    elseif target.itemid == 103 then
        item:transform(item:getId(), 19)
    elseif (target.itemid >= 598 and target.itemid < 712) or target.itemid == 1509 then
        item:transform(item:getId(), 26)
    elseif target.itemid >= 351 and target.itemid <= 355 then
        item:transform(item:getId(), 19)
    elseif target.itemid >= 602 and target.itemid <= 605 then
        item:transform(item:getId(), 28)
    elseif target.itemid == 1772 then
        item:transform(item:getId(), 3)
    elseif target.itemid == 1773 then
        item:transform(item:getId(), 15)
    elseif target.itemid == 5739 then
        toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        item:transform(item:getId(), 1)
    elseif target.itemid == 1504 then
        item:remove()
        Item(target.uid):remove()
        toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        Game.createItem(1422, 1, toPosition)
        Game.createItem(5908, 1, toPosition)
    elseif item.type == 0 then
        player:sendCancelMessage("It is empty.")
    else
        local splash = Game.createItem(2025, item.type, toPosition)
        item:transform(item:getId(), 0)
        if splash then
            splash:decay()
        end
    end
    
    return true
end
