-- Critical chance by vocation (percentage)
CRITICAL_CHANCE = {
    [0] = 2.0,   -- None
    [1] = 5.0,   -- Sorcerer
    [2] = 5.0,   -- Druid
    [3] = 8.0,   -- Archer
    [4] = 10.0,  -- Knight
    [5] = 5.0,   -- Master Sorcerer
    [6] = 5.0,   -- Elder Druid
    [7] = 8.0,   -- Royal Archer
    [8] = 10.0,  -- Elite Knight
    [9] = 6.0,   -- Wyzard
    [10] = 6.0,  -- Cleric
    [11] = 9.0,  -- Ranger
    [12] = 11.0, -- Slayer
    [13] = 7.0,  -- Dark Wyzard
    [14] = 7.0,  -- Elemental Cleric
    [15] = 10.0, -- Elven Ranger
    [16] = 12.0  -- Dragon Slayer
}

CRITICAL_MULTIPLIERS = {
    [0] = 1.2,   -- None
    [1] = 1.5,   -- Sorcerer
    [2] = 1.5,   -- Druid
    [3] = 1.7,   -- Archer
    [4] = 2.0,   -- Knight
    [5] = 1.5,   -- Master Sorcerer
    [6] = 1.5,   -- Elder Druid
    [7] = 1.7,   -- Royal Archer
    [8] = 2.0,   -- Elite Knight
    [9] = 1.6,   -- Wyzard
    [10] = 1.6,  -- Cleric
    [11] = 1.8,  -- Ranger
    [12] = 2.1,  -- Slayer
    [13] = 1.7,  -- Dark Wyzard
    [14] = 1.7,  -- Elemental Cleric
    [15] = 2.0,  -- Elven Ranger
    [16] = 2.3   -- Dragon Slayer
}

CRITICAL_HEAL_PERCENT = {
    [0] = 1.0,   -- None
    [1] = 3.0,   -- Sorcerer
    [2] = 3.0,   -- Druid
    [3] = 4.0,   -- Archer
    [4] = 5.0,   -- Knight
    [5] = 3.0,   -- Master Sorcerer
    [6] = 3.0,   -- Elder Druid
    [7] = 4.0,   -- Royal Archer
    [8] = 5.0,   -- Elite Knight
    [9] = 3.5,   -- Wyzard
    [10] = 3.5,  -- Cleric
    [11] = 4.5,  -- Ranger
    [12] = 5.5,  -- Slayer
    [13] = 4.0,  -- Dark Wyzard
    [14] = 4.0,  -- Elemental Cleric
    [15] = 5.0,  -- Elven Ranger
    [16] = 6.0   -- Dragon Slayer
}

CRITICAL_PHRASES = {
    [0] = {"Basic strike!", "Simple hit!", "Basic attack!"},
    [1] = {"Arcane power!", "You shall not pass!", "Magic flows through me!"},
    [2] = {"Light guides me!", "Faith is my shield!", "Nature's wrath!"},
    [3] = {"Precise shot!", "Arrow of destiny!", "Distance is my ally!"},
    [4] = {"Strength and steel!", "No mercy!", "Feel my blade!"},
    [5] = {"Arcane mastery!", "Supreme magic!", "Master sorcery!"},
    [6] = {"Elder wisdom!", "Ancient healing!", "Druidic power!"},
    [7] = {"Royal precision!", "Noble shot!", "Elite archery!"},
    [8] = {"Elite strength!", "Knight's honor!", "Elite blade!"},
    [9] = {"Mystic energy!", "Ancient wisdom!", "Power of the arcane!"},
    [10] = {"Divine blessing!", "Heaven's light!", "Sacred power!"},
    [11] = {"Forest's call!", "Nature's precision!", "Wild spirit!"},
    [12] = {"Slayer's edge!", "Death's embrace!", "Hunter's fury!"},
    [13] = {"Dark magic!", "Shadow's power!", "Void energy!"},
    [14] = {"Elemental fury!", "Nature's balance!", "Elemental storm!"},
    [15] = {"Elven grace!", "Forest's might!", "Ancient precision!"},
    [16] = {"Dragon's fury!", "Slayer's might!", "Feel the dragon's wrath!"}
}

function getCriticalChance(vocationId)
    return CRITICAL_CHANCE[vocationId] or 10.0
end

function getCriticalMultiplier(vocationId)
    return CRITICAL_MULTIPLIERS[vocationId] or 2.0
end

function getCriticalHealPercent(vocationId)
    return CRITICAL_HEAL_PERCENT[vocationId] or 1.0
end

function getCriticalPhrases(vocationId)
    return CRITICAL_PHRASES[vocationId] or {"Critical hit!", "Power strike!", "Devastating blow!"}
end

function calculateCriticalDamageNew(finalDamage, vocationId)
    local multiplier = getCriticalMultiplier(vocationId)
    local result = math.floor(math.abs(finalDamage) * multiplier)
    --print("[LUA DEBUG] Vocation: " .. vocationId .. " | Final Damage: " .. math.abs(finalDamage) .. " | Multiplier: " .. multiplier .. " | Result: " .. result)
    return result
end

function getRandomCriticalPhrase(vocationId)
    local phrases = getCriticalPhrases(vocationId)
    if #phrases > 0 then
        return phrases[math.random(1, #phrases)]
    end
    return ""
end

WEAPON_CLASSES = {
    [250] = {
        class = "GOD",
        description = "Legendary weapon of divine power",
        suitability = "Recommended for high-level players (200+)",
        powerAnalysis = "This weapon has devastating power!"
    },
    [180] = {
        class = "A", 
        description = "Epic weapon of great power",
        suitability = "Recommended for experienced players (150+)",
        powerAnalysis = "This weapon is very powerful!"
    },
    [150] = {
        class = "B",
        description = "Rare weapon of moderate power", 
        suitability = "Recommended for intermediate players (100+)",
        powerAnalysis = "This weapon has moderate power."
    },
    [130] = {
        class = "C",
        description = "Common weapon of basic power",
        suitability = "Suitable for beginner players (50+)",
        powerAnalysis = "This weapon has limited power."
    },
    [100] = {
        class = "D",
        description = "Basic weapon of limited power",
        suitability = "Suitable for novice players (20+)",
        powerAnalysis = "This weapon has limited power."
    },
    [0] = {
        class = "E",
        description = "Weak weapon of minimal power",
        suitability = "Only for initial training",
        powerAnalysis = "This weapon has limited power."
    }
}

function getWeaponClassification(attack)
    if attack >= 250 then
        return WEAPON_CLASSES[250]
    elseif attack >= 180 then
        return WEAPON_CLASSES[180]
    elseif attack >= 150 then
        return WEAPON_CLASSES[150]
    elseif attack >= 130 then
        return WEAPON_CLASSES[130]
    elseif attack >= 100 then
        return WEAPON_CLASSES[100]
    else
        return WEAPON_CLASSES[0]
    end
end

function getWeaponClassDescription(attack)
    local classification = getWeaponClassification(attack)
    return "Class " .. classification.class .. ": " .. classification.description
end

function getWeaponSuitability(attack)
    local classification = getWeaponClassification(attack)
    return classification.suitability
end

function getWeaponPowerAnalysis(attack)
    local classification = getWeaponClassification(attack)
    return classification.powerAnalysis
end
