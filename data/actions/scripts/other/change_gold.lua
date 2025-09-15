local config = {
    [ITEM_GOLD_COIN] = {
        changeTo = ITEM_PLATINUM_COIN,
        upgradeText = "$$",
        upgradeColor = TEXTCOLOR_YELLOW,
        upgradeEffect = CONST_ME_MAGIC_BLUE
    },
    [ITEM_PLATINUM_COIN] = {
        changeBack = ITEM_GOLD_COIN,
        changeTo = ITEM_CRYSTAL_COIN,
        upgradeText = "$$$",
        upgradeColor = TEXTCOLOR_WHITE,
        upgradeEffect = CONST_ME_MAGIC_GREEN,
        downgradeText = "$",
        downgradeColor = TEXTCOLOR_ORANGE,
        downgradeEffect = CONST_ME_POFF
    },
    [ITEM_CRYSTAL_COIN] = {
        changeBack = ITEM_PLATINUM_COIN,
        changeTo = ITEM_RUBY_COIN,
        upgradeText = "$$$$",
        upgradeColor = TEXTCOLOR_RED,
        upgradeEffect = CONST_ME_MAGIC_RED,
        downgradeText = "$$",
        downgradeColor = TEXTCOLOR_PLATINUMBLUE,
        downgradeEffect = CONST_ME_ENERGYAREA
    },
    [ITEM_RUBY_COIN] = {
        changeBack = ITEM_CRYSTAL_COIN,
        downgradeText = "$$$",
        downgradeColor = TEXTCOLOR_PURPLE,
        downgradeEffect = CONST_ME_PURPLEENERGY
    }
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local coin = config[item:getId()]
    if not coin then
        return false
    end
    
    if coin.changeTo and item:getCount() == 100 then
        -- Upgrade: 100 para 1
        item:remove()
        player:addItem(coin.changeTo, 1)
        
        Game.sendAnimatedText(coin.upgradeText, player:getPosition(), coin.upgradeColor)
        player:getPosition():sendMagicEffect(coin.upgradeEffect)
        
    elseif coin.changeBack and item:getCount() < 100 then
        -- Downgrade: 1 para 100
        item:remove()
        player:addItem(coin.changeBack, 100)
        
        Game.sendAnimatedText(coin.downgradeText, player:getPosition(), coin.downgradeColor)
        player:getPosition():sendMagicEffect(coin.downgradeEffect)
        
    else
        return false
    end
    
    return true
end
