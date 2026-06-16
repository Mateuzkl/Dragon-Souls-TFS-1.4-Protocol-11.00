local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local voices = { {text = "Olá mortal! Posso te ajudar com itens elementais e bênçãos!"} }
npcHandler:addModule(VoiceModule:new(voices))

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu sou uma serva de Merlian!'})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu posso criar itens elementais, energizar seus itens, dar {bless} para mortais e fazer {reset} de deuses! Diga {info} para informações de reset.'})
keywordHandler:addKeyword({'sell'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu não sou mercadora!'})
keywordHandler:addKeyword({'buy'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu não sou mercadora!'})
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, text = 'Ha! Você é apenas um novato!'})
keywordHandler:addKeyword({'mission'}, StdModule.say, {npcHandler = npcHandler, text = 'Ha! Você é apenas um novato!'})

local resetConfig = {
    requiredLevel = 510,
    newLevel = 8,

    rubyCoinId = 38915,
    logoutDelay = 5000,

    -- growthMode:
    -- "percent" = base + porcentagem por reset
    -- "linear" = base * resets
    growthMode = "percent",

    -- usado no modo percent
    bonusPercentPerReset = 15,

    -- false = aplica bônus de skill/ML apenas no primeiro reset
    -- true = aplica bônus de skill/ML em todo reset
    applyBonusesEachReset = false,

    -- custo ruby:
    -- primeiro reset grátis
    -- fórmula editável abaixo
    rubyCost = {
        freeFirstReset = true,
        levelMultiplier = 4000,
        resetMultiplier = 60,
        divisor = 1000000,
        minimum = 1
    },

    vocations = {
        -- God Sorcerer
        [13] = {
            name = "God Sorcerer",
            baseHp = 3000,
            baseMp = 1900,
            magicLevelBonus = 10
        },

        -- God Druid
        [14] = {
            name = "God Druid",
            baseHp = 3000,
            baseMp = 1900,
            magicLevelBonus = 10
        },

        -- God Paladin
        [15] = {
            name = "God Paladin",
            baseHp = 4200,
            baseMp = 1500,
            distanceBonus = 10,
            magicLevelBonus = 3
        },

        -- God Knight
        [16] = {
            name = "God Knight",
            baseHp = 6000,
            baseMp = 800,
            swordBonus = 10,
            axeBonus = 10,
            clubBonus = 10,
            fistBonus = 10
        }
    }
}

local function getCurrentReset(player)
    return math.max(0, tonumber(player:getReset()) or 0)
end

local function getResetLevel()
    return math.max(1, tonumber(resetConfig.requiredLevel) or 510)
end

local function getNewLevel()
    return math.max(1, tonumber(resetConfig.newLevel) or 8)
end

local function getVocationConfig(player)
    local vocation = player:getVocation()
    if not vocation then
        return nil, 0
    end

    local vocationId = vocation:getId()
    return resetConfig.vocations[vocationId], vocationId
end

local function calculateResetStats(vocationConfig, newResets)
    if type(vocationConfig) ~= "table" then
        return nil, nil
    end

    newResets = math.max(1, tonumber(newResets) or 1)

    local baseHp = math.max(1, tonumber(vocationConfig.baseHp) or 1)
    local baseMp = math.max(1, tonumber(vocationConfig.baseMp) or 1)

    local hp
    local mp
    if resetConfig.growthMode == "linear" then
        hp = baseHp * newResets
        mp = baseMp * newResets
    else
        local bonusPercent = tonumber(resetConfig.bonusPercentPerReset) or 0
        local multiplier = 1 + ((newResets - 1) * bonusPercent / 100)

        hp = baseHp * multiplier
        mp = baseMp * multiplier
    end

    return math.max(1, math.floor(hp)), math.max(1, math.floor(mp))
end

local function getResetCost(player, currentResets)
    currentResets = math.max(0, tonumber(currentResets) or 0)

    local rubyCost = resetConfig.rubyCost or {}
    if rubyCost.freeFirstReset and currentResets <= 0 then
        return 0
    end

    local levelMultiplier = tonumber(rubyCost.levelMultiplier) or 4000
    local resetMultiplier = tonumber(rubyCost.resetMultiplier) or 60
    local divisor = math.max(1, tonumber(rubyCost.divisor) or 1000000)
    local minimum = math.max(0, tonumber(rubyCost.minimum) or 1)
    local chargedReset = currentResets
    if chargedReset <= 0 then
        chargedReset = 1
    end

    local cost = math.floor((player:getLevel() * levelMultiplier) * (chargedReset * resetMultiplier) / divisor)
    return math.max(minimum, cost)
end

local function logResetFailure(player, reason, snapshot, refundCost)
    local snapshotInfo = ""
    if snapshot then
        snapshotInfo = " | before: level=" .. tostring(snapshot.level) ..
            ", resets=" .. tostring(snapshot.resets) ..
            ", maxHp=" .. tostring(snapshot.maxHp) ..
            ", maxMp=" .. tostring(snapshot.maxMp)
    end

    print("[Isolda] Reset failure for " .. player:getName() .. ": " .. tostring(reason) .. snapshotInfo .. ", refundCost=" .. tostring(refundCost or 0))
end

local function refundResetCost(player, cost)
    cost = math.max(0, tonumber(cost) or 0)
    if cost <= 0 then
        return true
    end

    local refundOk, refundResult = pcall(function()
        return player:addItem(resetConfig.rubyCoinId, cost)
    end)

    if not refundOk or refundResult == false then
        print("[Isolda] AVISO: Falha ao reembolsar " .. cost .. " ruby coins para " .. player:getName())
        return false
    end

    return true
end

local function buildResetPreview(player)
    local vocConfig, vocationId = getVocationConfig(player)
    if not vocConfig then
        return nil, vocationId
    end

    local currentResets = getCurrentReset(player)
    local newResets = currentResets + 1
    local newHp, newMp = calculateResetStats(vocConfig, newResets)
    if not newHp or not newMp then
        return nil, vocationId
    end

    return {
        vocationConfig = vocConfig,
        vocationId = vocationId,
        currentResets = currentResets,
        newResets = newResets,
        resetCost = getResetCost(player, currentResets),
        newHp = newHp,
        newMp = newMp
    }, vocationId
end

local function shouldApplyResetBonuses(newResets)
    if resetConfig.applyBonusesEachReset then
        return true
    end

    return math.max(1, tonumber(newResets) or 1) <= 1
end

local function applyResetBonuses(player, vocConfig, newResets)
    if not shouldApplyResetBonuses(newResets) then
        return
    end

    local skillBonuses = {
        fistBonus = SKILL_FIST,
        clubBonus = SKILL_CLUB,
        swordBonus = SKILL_SWORD,
        axeBonus = SKILL_AXE,
        distanceBonus = SKILL_DISTANCE
    }

    for bonusKey, skillId in pairs(skillBonuses) do
        local bonus = tonumber(vocConfig[bonusKey]) or 0
        if bonus > 0 then
            player:setSkillLevel(skillId, player:getSkillLevel(skillId) + bonus)
        end
    end

    local magicLevelBonus = tonumber(vocConfig.magicLevelBonus) or 0
    if magicLevelBonus > 0 then
        player:setMagicLevel(player:getMagicLevel() + magicLevelBonus)
    end
end

local function fillPlayerVitals(player)
    local maxHealth = player:getMaxHealth()
    local healthOk = pcall(function()
        player:setHealth(maxHealth)
    end)

    if not healthOk then
        local currentHealth = 0
        pcall(function()
            currentHealth = player:getHealth()
        end)

        local healthToAdd = math.max(0, maxHealth - currentHealth)
        if healthToAdd > 0 then
            pcall(function()
                player:addHealth(healthToAdd)
            end)
        end
    end

    local maxMana = player:getMaxMana()
    local manaOk = pcall(function()
        player:setMana(maxMana)
    end)

    if not manaOk then
        local currentMana = 0
        pcall(function()
            currentMana = player:getMana()
        end)

        local manaToAdd = math.max(0, maxMana - currentMana)
        if manaToAdd > 0 then
            pcall(function()
                player:addMana(manaToAdd)
            end)
        end
    end
end

local function scheduleResetLogout(player)
    addEvent(function(playerId)
        local resetPlayer = Player(playerId)
        if resetPlayer then
            resetPlayer:remove()
        end
    end, resetConfig.logoutDelay, player:getId())
end

local function sendResetOffer(player, cid)
    if not player:isPremium() then
        npcHandler:say('Desculpe, eu só posso resetar deuses Premium.', cid)
        return false
    end

    local requiredLevel = getResetLevel()
    if player:getLevel() < requiredLevel then
        npcHandler:say('Você precisa ser level ' .. requiredLevel .. ' ou superior para resetar.', cid)
        return false
    end

    local preview = buildResetPreview(player)
    if not preview then
        npcHandler:say('Desculpe, apenas deuses podem resetar comigo.', cid)
        return false
    end

    if preview.resetCost <= 0 then
        npcHandler:say('Como é sua primeira vez, o reset será grátis. Você voltará para level ' .. getNewLevel() .. ' com ' .. preview.newHp .. ' HP e ' .. preview.newMp .. ' MP. Deseja continuar?', cid)
    else
        npcHandler:say('Este será seu reset número ' .. preview.newResets .. '. O custo é ' .. preview.resetCost .. ' ruby coins. Você voltará para level ' .. getNewLevel() .. ' com ' .. preview.newHp .. ' HP e ' .. preview.newMp .. ' MP. Deseja continuar?', cid)
    end

    npcHandler.topic[cid] = 11
    return true
end

local function sendResetInfo(player, cid)
    local currentResets = getCurrentReset(player)
    local preview = buildResetPreview(player)

    if not preview then
        npcHandler:say('Status atual: Level ' .. player:getLevel() .. ', Resets: ' .. currentResets .. ', HP atual: ' .. player:getMaxHealth() .. ', MP atual: ' .. player:getMaxMana() .. '. Sua vocação atual não está liberada para reset.', cid)
        return
    end

    npcHandler:say('Status atual: Level ' .. player:getLevel() .. ', Resets: ' .. currentResets .. ', HP atual: ' .. player:getMaxHealth() .. ', MP atual: ' .. player:getMaxMana() .. '. Próximo reset: ' .. preview.newResets .. '. Próximo reset custará ' .. preview.resetCost .. ' ruby coins. Após reset você ficará com HP ' .. preview.newHp .. ' e MP ' .. preview.newMp .. '. Modo de crescimento: ' .. resetConfig.growthMode .. '.', cid)
end

local function canApplyResetStats(player, snapshot)
    local hpOk, hpResult = pcall(function()
        return player:setMaxHealth(snapshot.maxHp)
    end)
    if not hpOk or hpResult == false then
        return false, 'setMaxHealth indisponível'
    end

    local mpOk, mpResult = pcall(function()
        return player:setMaxMana(snapshot.maxMp)
    end)
    if not mpOk or mpResult == false then
        return false, 'setMaxMana indisponível'
    end

    return true
end

local function doIsoldaReset(player, cid)
    if not player:isPremium() then
        npcHandler:say('Desculpe, eu só posso resetar deuses Premium.', cid)
        return false
    end

    local requiredLevel = getResetLevel()
    if player:getLevel() < requiredLevel then
        npcHandler:say('Você precisa ser level ' .. requiredLevel .. ' ou superior para resetar.', cid)
        return false
    end

    local preview = buildResetPreview(player)
    if not preview then
        npcHandler:say('Desculpe, apenas deuses podem resetar comigo.', cid)
        return false
    end

    if preview.resetCost > 0 and player:getItemCount(resetConfig.rubyCoinId) < preview.resetCost then
        npcHandler:say('Você precisa de ' .. preview.resetCost .. ' ruby coins para resetar.', cid)
        return false
    end

    local newHp = preview.newHp
    local newMp = preview.newMp
    if not newHp or not newMp then
        npcHandler:say('Desculpe, não foi possível calcular seu HP e MP de reset.', cid)
        return false
    end

    local resetSnapshot = {
        resets = preview.currentResets,
        level = player:getLevel(),
        maxHp = player:getMaxHealth(),
        maxMp = player:getMaxMana()
    }

    local statsPrecheckOk, statsPrecheckReason = canApplyResetStats(player, resetSnapshot)
    if not statsPrecheckOk then
        npcHandler:say('Desculpe, não foi possível validar o sistema de MaxHP/MaxMP agora.', cid)
        logResetFailure(player, statsPrecheckReason, resetSnapshot, 0)
        return false
    end

    local paymentRemoved = false
    if preview.resetCost > 0 then
        if not player:removeItem(resetConfig.rubyCoinId, preview.resetCost) then
            npcHandler:say('Não foi possível remover os ruby coins.', cid)
            return false
        end
        paymentRemoved = true
    end

    local resetOk, resetResult = pcall(function()
        return player:doReset()
    end)

    if not resetOk or resetResult == false then
        if paymentRemoved then
            refundResetCost(player, preview.resetCost)
        end
        logResetFailure(player, 'player:doReset falhou', resetSnapshot, preview.resetCost)
        npcHandler:say('Desculpe, não foi possível resetar agora.', cid)
        return false
    end

    local newResets = getCurrentReset(player)
    if newResets <= resetSnapshot.resets then
        if paymentRemoved then
            refundResetCost(player, preview.resetCost)
        end
        logResetFailure(player, 'reset counter não aumentou após player:doReset', resetSnapshot, preview.resetCost)
        npcHandler:say('Desculpe, o reset não foi aplicado corretamente.', cid)
        return false
    end

    if newResets ~= preview.newResets then
        newHp, newMp = calculateResetStats(preview.vocationConfig, newResets)
    end

    local hpOk, hpResult = pcall(function()
        return player:setMaxHealth(newHp)
    end)

    if not hpOk or hpResult == false then
        if paymentRemoved then
            refundResetCost(player, preview.resetCost)
        end
        logResetFailure(player, 'setMaxHealth falhou após player:doReset', resetSnapshot, preview.resetCost)
        npcHandler:say('Desculpe, não foi possível aplicar seu MaxHP de reset. A staff foi avisada pelo console.', cid)
        return false
    end

    local mpOk, mpResult = pcall(function()
        return player:setMaxMana(newMp)
    end)

    if not mpOk or mpResult == false then
        pcall(function()
            player:setMaxHealth(resetSnapshot.maxHp)
        end)
        if paymentRemoved then
            refundResetCost(player, preview.resetCost)
        end
        logResetFailure(player, 'setMaxMana falhou após player:doReset', resetSnapshot, preview.resetCost)
        npcHandler:say('Desculpe, não foi possível aplicar seu MaxMP de reset. A staff foi avisada pelo console.', cid)
        return false
    end

    applyResetBonuses(player, preview.vocationConfig, newResets)
    fillPlayerVitals(player)

    pcall(function()
        player:save()
    end)

    Game.broadcastMessage("Parabéns! O jogador " .. player:getName() .. " resetou com sucesso e agora tem " .. newResets .. " resets!", MESSAGE_STATUS_WARNING)
    npcHandler:say('Seu poder agora é ainda maior, parabéns ' .. player:getName() .. '.', cid)
    player:sendTextMessage(MESSAGE_INFO_DESCR, "Você resetou seu personagem. Novo MaxHP: " .. newHp .. ", novo MaxMP: " .. newMp .. ".")
    player:sendTextMessage(MESSAGE_STATUS_WARNING, "Você será desconectado em 5 segundos para finalizar o reset.")
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
    scheduleResetLogout(player)
    return true
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    local preco = player:getLevel() * 2 -- Original script uses level * 2000, so level * 2 for "k" format
    local bless = player:hasBlessing(1)
    local currentResets = getCurrentReset(player)
    local resetLevel = getResetLevel()
    
    if msgcontains(msg, 'energyze') or msgcontains(msg, 'energize') then
        npcHandler:say('Eu posso energyzar seu elemental necklace por 50k, spirit elemental amulet por 100k ou o seu magic elemental amulet por 150k, você deseja que eu energyze?', cid)
        npcHandler.topic[cid] = 1
        
    elseif npcHandler.topic[cid] == 1 and (msgcontains(msg, 'yes') or msgcontains(msg, 'sim')) then
        -- Check for Elemental Necklace (2197)
        if player:getItemCount(2197) >= 1 and player:removeMoney(50000) then
            player:removeItem(2197, 1)
            player:addItem(38906, 1)
            npcHandler:say('Ele é todo seu! Você está protegido.', cid)
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Você energizou seu Elemental necklace.")
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        -- Check for Spirit Elemental Amulet (2173)  
        elseif player:getItemCount(2173) >= 1 and player:removeMoney(100000) then
            player:removeItem(2173, 1)
            player:addItem(38901, 1)
            npcHandler:say('Ele é todo seu! Você está protegido.', cid)
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Você energizou seu Spirit Elemental amulet.")
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        -- Check for Magic Elemental Amulet (2125)
        elseif player:getItemCount(2125) >= 1 and player:removeMoney(150000) then
            player:removeItem(2125, 1)
            player:addItem(38900, 1)
            npcHandler:say('Ele é todo seu! Você está protegido.', cid)
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Você energizou seu Magic Elemental amulet.")
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        else
            if player:getItemCount(2125) == 0 and player:getItemCount(2173) == 0 and player:getItemCount(2197) == 0 then
                npcHandler:say('Você não tem nenhum amulet para ser energyzado.', cid)
            else
                npcHandler:say('Desculpe, você não tem a quantia necessária.', cid)
            end
        end
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'elemental necklace') or msgcontains(msg, 'elemental') then
        npcHandler:say('Você deseja trocar o mysterious, dragon breath, scorpion, platinum e o vampire tooth necklace por um Elemental necklace?', cid)
        npcHandler.topic[cid] = 4
        
    elseif npcHandler.topic[cid] == 4 and (msgcontains(msg, 'yes') or msgcontains(msg, 'sim')) then
        if player:getItemCount(2201) >= 1 and player:getItemCount(2171) >= 1 and 
           player:getItemCount(2170) >= 1 and player:getItemCount(2161) >= 1 and 
           player:getItemCount(2198) >= 1 then
            
            player:removeItem(2201, 1) -- mysterious
            player:removeItem(2171, 1) -- dragon breath  
            player:removeItem(2170, 1) -- scorpion
            player:removeItem(2161, 1) -- platinum
            player:removeItem(2198, 1) -- vampire tooth
            player:addItem(2197, 1) -- elemental necklace
            npcHandler:say('Pronto! O seu elemental necklace está pronto, obrigada.', cid)
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Você recebeu um Elemental necklace.")
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        else
            npcHandler:say('Desculpe, você não tem todos amulets necessários.', cid)
        end
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'spirit elemental amulet') or msgcontains(msg, 'spirit') then
        npcHandler:say('Você deseja trocar o Ialamar, frozzen, sickness, Samantha, Mastafar, priest e o eletric amulet por um Spirit Elemental Amulet?', cid)
        npcHandler.topic[cid] = 5
        
    elseif npcHandler.topic[cid] == 5 and (msgcontains(msg, 'yes') or msgcontains(msg, 'sim')) then
        if player:getItemCount(2199) >= 1 and player:getItemCount(2133) >= 1 and 
           player:getItemCount(2130) >= 1 and player:getItemCount(2135) >= 1 and 
           player:getItemCount(2126) >= 1 and player:getItemCount(2131) >= 1 and 
           player:getItemCount(2129) >= 1 then
            
            player:removeItem(2199, 1) -- ialamar
            player:removeItem(2133, 1) -- frozen
            player:removeItem(2130, 1) -- sickness
            player:removeItem(2135, 1) -- samantha
            player:removeItem(2126, 1) -- mastafar  
            player:removeItem(2131, 1) -- priest
            player:removeItem(2129, 1) -- electric
            player:addItem(2173, 1) -- spirit elemental amulet
            npcHandler:say('Pronto! O seu spirit elemental necklace está pronto, obrigada.', cid)
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Você recebeu um Spirit Elemental amulet.")
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        else
            npcHandler:say('Desculpe, você não tem todos amulets necessários.', cid)
        end
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'magic elemental amulet') or msgcontains(msg, 'magic') then
        npcHandler:say('Você deseja trocar o Merlian, relic of the hell, Broonier, Thordain, dark wyzard, angel e o gaya amulet por um Elemental Magic Amulet?', cid)
        npcHandler.topic[cid] = 6
        
    elseif npcHandler.topic[cid] == 6 and (msgcontains(msg, 'yes') or msgcontains(msg, 'sim')) then
        if player:getItemCount(2139) >= 1 and player:getItemCount(2142) >= 1 and 
           player:getItemCount(2132) >= 1 and player:getItemCount(2136) >= 1 and 
           player:getItemCount(2200) >= 1 and player:getItemCount(2196) >= 1 and 
           player:getItemCount(2138) >= 1 then
            
            player:removeItem(2139, 1) -- merlian
            player:removeItem(2142, 1) -- relic of hell
            player:removeItem(2132, 1) -- broonier
            player:removeItem(2136, 1) -- thordain
            player:removeItem(2200, 1) -- dark wizard
            player:removeItem(2196, 1) -- angel
            player:removeItem(2138, 1) -- gaya
            player:addItem(2125, 1) -- magic elemental amulet
            npcHandler:say('Pronto! O seu magic elemental necklace está pronto, obrigada.', cid)
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Você recebeu um Magic Elemental amulet.")
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        else
            npcHandler:say('Desculpe, você não tem todos amulets necessários.', cid)
        end
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'bless') or msgcontains(msg, 'blessing') then
        npcHandler:say('Você deseja ser abençoado por ' .. (preco * 1000) .. ' gold coins?', cid)
        npcHandler.topic[cid] = 7
        
    elseif npcHandler.topic[cid] == 7 and (msgcontains(msg, 'yes') or msgcontains(msg, 'sim')) then
        if bless then
            npcHandler:say('Você já está abençoado, meu pequeno mortal.', cid)
        else
            if player:isPremium() then
                if player:removeMoney(preco * 1000) then
                    for i = 1, 5 do
                        player:addBlessing(i)
                    end
                    player:sendTextMessage(MESSAGE_INFO_DESCR, "Você recebeu a benção de Isolda.")
                    npcHandler:say('Receba essa benção, agora todos os deuses estão olhando por tí.', cid)
                    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
                else
                    npcHandler:say('Desculpe, você não tem a quantia necessária.', cid)
                end
            else
                npcHandler:say('Desculpe, eu só posso abençoar Premiums.', cid)
            end
        end
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'the great dark wyzard') or msgcontains(msg, 'poem') then
        npcHandler:say('Você possui o poema de Merlian?', cid)
        npcHandler.topic[cid] = 8
        
    elseif npcHandler.topic[cid] == 8 and (msgcontains(msg, 'yes') or msgcontains(msg, 'sim')) then
        if player:removeItem(5952, 1) then
            player:addItem(2453, 1)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Quest 'The Great Dark Wyzard.' completada.")
            npcHandler:say('Eu posso sentir o poder de Merlian, o grande dark wyzard.', cid)
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        else
            npcHandler:say('Desculpe, você não está com o poema.', cid)
        end
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'uihiui') or msgcontains(msg, 'god') then
        local vocation = player:getVocation():getId()
        local level = player:getLevel()
        
        if vocation < 9 then
            npcHandler:say('Hahaha, você me faz rir caro mortal, apenas valans podem ser tornar Deuses.', cid)
            return true
        end
        
        if level < resetLevel then
            if vocation < 13 then
                npcHandler:say('Hahaha, você não tem level suficiente para isso humilde semi-deus.', cid)
            else
                npcHandler:say('Essa é uma escolha de extrema sabedoria, você ainda não está preparado.', cid)
            end
            return true
        end
        
        if vocation > 12 then
            if not sendResetOffer(player, cid) then
                npcHandler.topic[cid] = 0
            end
            return true
        end
        
        npcHandler:say('Hmm, fico impressionada que você tenha chegado até aqui! Então realmente você deseja se tornar um Deus? Cuidado mortal, essa decisão é irreversivel.', cid)
        npcHandler.topic[cid] = 9
        
    elseif msgcontains(msg, 'reset') then
        if not sendResetOffer(player, cid) then
            npcHandler.topic[cid] = 0
        end
        
    elseif msgcontains(msg, 'info') or msgcontains(msg, 'information') then
        sendResetInfo(player, cid)
        npcHandler.topic[cid] = 0
        
    elseif npcHandler.topic[cid] == 9 and (msgcontains(msg, 'yes') or msgcontains(msg, 'sim')) then
        local vocation = player:getVocation():getId()
        
        if vocation < 9 then
            npcHandler:say('Hahaha, você me faz rir caro mortal, apenas valans podem ser tornar Deuses.', cid)
            return true
        end
        
        if player:getLevel() < resetLevel then
            npcHandler:say('Hahaha, você não tem level suficiente para isso humilde semi-deus.', cid)
            return true
        end
        
        if vocation > 12 then
            npcHandler:say('Você já é um deus, guerreiro.', cid)
            return true
        end
        
        if vocation > 8 and vocation < 13 then
            -- Promote to god vocation (add 4 to vocation ID)
            player:setVocation(Vocation(vocation + 4))
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Você evoluiu seu espírito a Deus.")
            npcHandler:say('Oh, um novo Deus! Boa sorte em sua jornada meu caro.', cid)
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        else
            npcHandler:say('Você já é um deus, guerreiro.', cid)
        end
        npcHandler.topic[cid] = 0
        
    elseif npcHandler.topic[cid] == 11 and (msgcontains(msg, 'yes') or msgcontains(msg, 'sim')) then
        doIsoldaReset(player, cid)
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'no') and npcHandler.topic[cid] > 0 then
        npcHandler:say('Ok então.', cid)
        npcHandler.topic[cid] = 0
    end
    
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, 'Olá |PLAYERNAME|! Em que posso lhe ajudar, mortal?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Até logo, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Então tá, tchau.')
npcHandler:setMessage(MESSAGE_DECLINE, 'Proxímo porfavor...')
npcHandler:addModule(FocusModule:new())
