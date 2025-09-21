local conf = {
    ["level"] = {
        [1] = {successPercent = 75, downgradeLevel = 0},
        [2] = {successPercent = 60, downgradeLevel = 1},
        [3] = {successPercent = 55, downgradeLevel = 2},
        [4] = {successPercent = 40, downgradeLevel = 3},
        [5] = {successPercent = 35, downgradeLevel = 4},
        [6] = {successPercent = 20, downgradeLevel = 5},
        [7] = {successPercent = 15, downgradeLevel = 0},
        [8] = {successPercent = 10, downgradeLevel = 0},
        [9] = {successPercent = 5, downgradeLevel = 0}
    },
    ["upgrade"] = {
        attack = 1,
        defense = 1,
        extraDefense = 1,
        armor = 1,
    },
    ["items"] = {
        [2391] = {name = "war hammer"},
        [2393] = {name = "giant sword"},
        [2414] = {name = "dragon lance"},
        [2493] = {name = "demon helmet", specialLevels = {
            [2] = {
                ["absorbPercentFire"] = 15
            }
        }},
        [2470] = {name = "golden legs"},
        [2472] = {name = "magic plate armor", specialLevels = {
            [2] = {
                ["increasePhysicalPercent"] = 5
            }
        }}
    }
}

local upgrading = {
    upValue = function(value, level, percent)
        if value < 0 then 
            return 0 
        end
        if level == 0 then 
            return value 
        end
        local nVal = value
        for i = 1, level do
            nVal = nVal + (math.ceil((nVal / 100 * percent)))
        end
        return nVal > 0 and nVal or value
    end,

    getLevel = function(item)
        local name = item:getName():split('+')
        if #name == 1 then
            return 0
        end
        return math.abs(tonumber(name[2]) or 0)
    end,

    applySpecialAttributes = function(item, itemId, level)
        local itemConfig = conf["items"][itemId]
        if not itemConfig or not itemConfig.specialLevels then
            return
        end
        
        local specialLevel = itemConfig.specialLevels[level]
        if specialLevel then
            for attributeName, value in pairs(specialLevel) do
                item:setAttribute(attributeName, value)
            end
        end
    end
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if target:isCreature() then
        return false
    end
    
    local targetId = target:getId()
    local itemConfig = conf["items"][targetId]
    
    if not itemConfig then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You cannot upgrade this item.")
        return true
    end
    
    local itemType = ItemType(targetId)
    if itemType:isStackable() then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You cannot upgrade this item.")
        return true
    end
    
    local level = upgrading.getLevel(target)
    if level >= #conf["level"] then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Your " .. itemConfig.name .. " is on max level already.")
        return true
    end
    
    local success = conf["level"][level + 1].successPercent >= math.random(1, 100)
    local nLevel = success and (level + 1) or conf["level"][level + 1].downgradeLevel
    
    if nLevel > level then
        toPosition:sendMagicEffect(CONST_ME_MAGIC_GREEN)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Upgrade to level " .. nLevel .. " successful!")
    else
        toPosition:sendMagicEffect(CONST_ME_BLOCKHIT)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Upgrade failed. Your " .. itemConfig.name .. " is now on level " .. nLevel)
    end
    
    target:setAttribute(ITEM_ATTRIBUTE_NAME, itemConfig.name .. ((nLevel > 0) and " +" .. nLevel or ""))
    target:setAttribute(ITEM_ATTRIBUTE_ATTACK, upgrading.upValue(itemType:getAttack(), nLevel, conf["upgrade"].attack))
    target:setAttribute(ITEM_ATTRIBUTE_DEFENSE, upgrading.upValue(itemType:getDefense(), nLevel, conf["upgrade"].defense))
    target:setAttribute(ITEM_ATTRIBUTE_EXTRADEFENSE, upgrading.upValue(itemType:getExtraDefense(), nLevel, conf["upgrade"].extraDefense))
    target:setAttribute(ITEM_ATTRIBUTE_ARMOR, upgrading.upValue(itemType:getArmor(), nLevel, conf["upgrade"].armor))
    
    upgrading.applySpecialAttributes(target, targetId, nLevel)
    
    item:remove(1)
    return true
end
