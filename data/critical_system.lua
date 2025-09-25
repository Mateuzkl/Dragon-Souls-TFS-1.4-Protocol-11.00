-- Critical chance by vocation (percentage)
CRITICAL_CHANCE = {
    [4] = 10.0,  -- Knight
    [8] = 10.0,  -- Elite Knight
    [12] = 11.0, -- Slayer
    [16] = 12.0  -- Dragon Slayer
}

CRITICAL_MULTIPLIERS = {
    [0] = 1.2,   -- None
    [4] = 2.0,   -- Knight
    [8] = 2.0,   -- Elite Knight
    [12] = 2.1,  -- Slayer
    [16] = 2.3   -- Dragon Slayer
}

CRITICAL_HEAL_PERCENT = {
    [4] = 5.0,   -- Knight
    [8] = 5.0,   -- Elite Knight
    [12] = 5.5,  -- Slayer
    [16] = 6.0   -- Dragon Slayer
}

CRITICAL_PHRASES = {
    [4] = {"Strength and steel!", "No mercy!", "Feel my blade!"},
    [8] = {"Elite strength!", "Knight's honor!", "Elite blade!"},
    [12] = {"Slayer's edge!", "Death's embrace!", "Hunter's fury!"},
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
