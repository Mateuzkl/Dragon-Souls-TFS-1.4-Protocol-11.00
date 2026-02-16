--[[
    ========================================
    EQUIPMENT STATS DISPLAY SYSTEM
    ========================================
    
    Tracks and displays equipment statistics in real-time:
    - Dodge chance from tier system
    - Inc.Phys (Physical damage increase)
    - Inc.Magic (Magic damage increase)
    - Abs.ALL (Protection from all elements)
    
    Updates automatically when equipment changes.
    ========================================
]]

local CODE_EQUIPMENT_STATS = 106

-- Combat types for checking magic and protection values
local MAGIC_COMBAT_TYPES = {
    COMBAT_FIREDAMAGE,
    COMBAT_ICEDAMAGE,
    COMBAT_ENERGYDAMAGE,
    COMBAT_EARTHDAMAGE,
    COMBAT_HOLYDAMAGE,
    COMBAT_DEATHDAMAGE
}

local ALL_COMBAT_TYPES = {
    COMBAT_PHYSICALDAMAGE,
    COMBAT_FIREDAMAGE,
    COMBAT_ICEDAMAGE,
    COMBAT_ENERGYDAMAGE,
    COMBAT_EARTHDAMAGE,
    COMBAT_HOLYDAMAGE,
    COMBAT_DEATHDAMAGE
}

local EQUIPMENT_SLOTS = {
    CONST_SLOT_HEAD,
    CONST_SLOT_NECKLACE,
    CONST_SLOT_ARMOR,
    CONST_SLOT_LEGS,
    CONST_SLOT_FEET,
    CONST_SLOT_RING,
    CONST_SLOT_LEFT,
    CONST_SLOT_RIGHT,
    CONST_SLOT_AMMO
}

-- ========================================
-- Helper Functions
-- ========================================

local function getAllValuesEqual(values)
    if #values == 0 then
        return false, 0
    end
    
    local firstValue = values[1]
    if not firstValue or firstValue == 0 then
        return false, 0
    end
    
    for i = 2, #values do
        if values[i] ~= firstValue then
            return false, 0
        end
    end
    
    return true, firstValue
end

local function getItemIncMagic(item)
    local magicValues = {}
    
    for _, combatType in ipairs(MAGIC_COMBAT_TYPES) do
        local value = tonumber(item:getIncreasePercent(combatType)) or 0
        table.insert(magicValues, value)
    end
    
    local allEqual, value = getAllValuesEqual(magicValues)
    return allEqual and value or 0
end

local function getItemAbsAll(item)
    local absValues = {}
    
    for _, combatType in ipairs(ALL_COMBAT_TYPES) do
        local value = tonumber(item:getAbsorbPercent(combatType)) or 0
        table.insert(absValues, value)
    end
    
    local allEqual, value = getAllValuesEqual(absValues)
    return allEqual and value or 0
end

-- ========================================
-- Main Function
-- ========================================

function Player:sendEquipmentStats()
    local stats = {
        dodge = 0,
        incPhys = 0,
        incMagic = 0,
        absAll = 0
    }
    
    for _, slot in ipairs(EQUIPMENT_SLOTS) do
        local item = self:getSlotItem(slot)
        if item then
            -- Dodge
            local itemDodge = tonumber(item:getDodge()) or 0
            if itemDodge > 0 then
                stats.dodge = stats.dodge + itemDodge
            end
            
            -- Inc.Phys (Physical damage increase)
            local itemIncPhys = tonumber(item:getIncreasePercent(COMBAT_PHYSICALDAMAGE)) or 0
            if itemIncPhys > 0 then
                stats.incPhys = stats.incPhys + itemIncPhys
            end
            
            -- Inc.Magic (All magic elements equal)
            local itemIncMagic = getItemIncMagic(item)
            if itemIncMagic > 0 then
                stats.incMagic = stats.incMagic + itemIncMagic
            end
            
            -- Abs.ALL (All protections equal)
            local itemAbsAll = getItemAbsAll(item)
            if itemAbsAll > 0 then
                stats.absAll = stats.absAll + itemAbsAll
            end
        end
    end
    
    self:sendExtendedOpcode(CODE_EQUIPMENT_STATS, json.encode(stats))
end

-- ========================================
-- Events Registration
-- ========================================

local LoginEvent = CreatureEvent("EquipmentStatsLogin")
function LoginEvent.onLogin(player)
    player:registerEvent("EquipmentStatsExtendedOpcode")
    player:sendEquipmentStats()
    return true
end
LoginEvent:type("login")
LoginEvent:register()

local ExtendedOpcodeEvent = CreatureEvent("EquipmentStatsExtendedOpcode")
function ExtendedOpcodeEvent.onExtendedOpcode(player, opcode, buffer)
    if opcode == CODE_EQUIPMENT_STATS then
        player:sendEquipmentStats()
    end
end
ExtendedOpcodeEvent:type("extendedopcode")
ExtendedOpcodeEvent:register()

local InventoryUpdateCallback = EventCallback
InventoryUpdateCallback.onInventoryUpdate = function(self, item, slot, equip)
    self:sendEquipmentStats()
end
InventoryUpdateCallback:register()
