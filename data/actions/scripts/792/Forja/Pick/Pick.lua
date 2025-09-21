local MiningSystem = {
    -- Configuração dos minérios
    stones = {
        -- Pick.lua - Sistema básico
        [13685] = {transformTo = 356, loot = 13641}, -- Iron ore
        [13687] = {transformTo = 360, loot = 13641},
        [13686] = {transformTo = 358, loot = 13641},
        [13640] = {transformTo = 367, loot = 13641},
        [13638] = {transformTo = 364, loot = 13641},
        [13639] = {transformTo = 365, loot = 13641},
        [387] = {transformTo = 386, loot = 13641},
        [386] = {transformTo = 390, loot = 13641},
        [390] = {transformTo = 391, loot = 13641},
        [391] = {transformTo = 355, loot = 13641},
    },
    
    -- Sistema de loot com chance para gemas (Pick1-10.lua)
    gemStones = {
        [13685] = {transformTo = 356}, -- Base stone 1
        [13686] = {transformTo = 358}, -- Base stone 2
        [391] = {transformTo = 355},   -- Final stone
    },
    
    -- Tabela de loot com pesos
    gemLoot = {
        {item = 13641, chance = 10, message = "iron nugget"},      -- 1/10 chance
        {item = 2150, chance = 20, message = "small amethyst"},    -- 2/10 chance  
        {item = 2149, chance = 30, message = "small emerald"},     -- 3/10 chance
        {item = 2147, chance = 40, message = "small ruby"},        -- 4/10 chance
        {item = 2146, chance = 50, message = "small sapphire"},    -- 5/10 chance
        {item = 2145, chance = 60, message = "small diamond"},     -- 6/10 chance
        {item = 1294, chance = 70, message = "small stone"},       -- 7/10 chance
    }
}

function MiningSystem.getRandomGemLoot()
    local roll = math.random(1, 10)
    for _, loot in ipairs(MiningSystem.gemLoot) do
        if roll * 10 <= loot.chance then
            return loot
        end
    end
    return MiningSystem.gemLoot[1] -- fallback
end

function MiningSystem.performMining(player, target, toPosition, isGemStone)
    local skillLevel = player:getSkillLevel(SKILL_MINING)
    local randomNumber = math.random(1, 100 + skillLevel/10)
    
    toPosition:sendAnimatedText("Cleck!", TEXTCOLOR_ORANGE)
    toPosition:sendMagicEffect(CONST_ME_BLOCKHIT)
    
    if randomNumber <= skillLevel then
        local stoneConfig = isGemStone and MiningSystem.gemStones[target:getId()] or MiningSystem.stones[target:getId()]
        target:transform(stoneConfig.transformTo)
        target:decay()
        
        if isGemStone then
            local gemLoot = MiningSystem.getRandomGemLoot()
            player:addItem(gemLoot.item, 1)
            if gemLoot.message ~= "iron nugget" then
                player:sendTextMessage(MESSAGE_INFO_DESCR, "Voce achou um " .. gemLoot.message .. ".")
            end
        else
            player:addItem(stoneConfig.loot, 1)
        end
        
        player:addHealth(-25)
    end
    
    player:addSkillTries(SKILL_MINING, 1)
    player:addHealth(-25)
end

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local targetId = target:getId()
    
    -- Verifica se é um minério válido
    if MiningSystem.stones[targetId] then
        MiningSystem.performMining(player, target, toPosition, false)
        return true
    end
    
    -- Verifica se é uma pedra preciosa
    if MiningSystem.gemStones[targetId] then
        MiningSystem.performMining(player, target, toPosition, true)
        return true
    end
    
    return false
end
