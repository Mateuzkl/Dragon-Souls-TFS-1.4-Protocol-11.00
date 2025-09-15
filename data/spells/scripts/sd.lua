local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SUDDENDEATH)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -0.85, -30, -1.75, 0)

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat2:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SUDDENDEATH)
combat2:setFormula(COMBAT_FORMULA_LEVELMAGIC, -0.40, -30, -0.90, 0)

local combat3 = Combat()
combat3:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat3:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat3:setParameter(COMBAT_PARAM_TARGETCASTERORTOPMOST, true)
combat3:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat3:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)
combat3:setFormula(COMBAT_FORMULA_LEVELMAGIC, 0.9, 0, 1.8, 0)

local combat4 = Combat()
combat4:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_RED)
combat4:setParameter(COMBAT_PARAM_TYPE, COMBAT_MANADRAIN)
combat4:setFormula(COMBAT_FORMULA_LEVELMAGIC, 0.5, 0, 1.0, 0)

local exhaust = Condition(CONDITION_EXHAUSTED)
exhaust:setParameter(CONDITION_PARAM_TICKS, 2000)

local marcher1 = Combat()
marcher1:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
marcher1:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 16)

local mmage1 = Combat()
mmage1:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
mmage1:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_EXPLOSIONHIT)
mmage1:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)
mmage1:setFormula(COMBAT_FORMULA_LEVELMAGIC, -0.4, 0, -0.8, 0)

function onGetFormulaValues1(player, level, maglevel)
    local weapon = player:getSlotItem(CONST_SLOT_RING)
    if weapon then
        local skill = player:getEffectiveSkillLevel(SKILL_DISTANCE)
        if weapon:getId() == 2543 then
            local min = -((skill * 5) + level) / 2
            local max = -((skill * 7) + level) / 2
            return min, max
        elseif weapon:getId() == 2547 then
            local min = -((skill * 7) + level) / 2
            local max = -((skill * 9) + level) / 2
            return min, max
        end
    end
    return 0, 0
end

marcher1:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues1")

function onTargetCreature(creature, target)
    local player = creature:getPlayer()
    local targetPlayer = target:getPlayer()
    
    if player and targetPlayer then
        local targetOutfit = target:getOutfit()
        
        if targetOutfit.lookType == 194 then
            targetPlayer:say('Haha!', TALKTYPE_MONSTER_SAY)
            return combat2:execute(target, positionToVariant(player:getPosition()))
        elseif targetOutfit.lookType == 251 then
            targetPlayer:say('Weak!', TALKTYPE_MONSTER_SAY)
            combat3:execute(creature, positionToVariant(target:getPosition()))
            return combat4:execute(creature, positionToVariant(target:getPosition()))
        elseif targetOutfit.lookType == 262 then
            targetPlayer:say('Shhhh!', TALKTYPE_MONSTER_SAY)
            player:getPosition():sendAnimatedText("Silence!", 215)
            player:say('...', TALKTYPE_MONSTER_SAY)
            creature:addCondition(exhaust)
        end
        
        local rand = math.random(1, 50)
        if rand == 1 then
            targetPlayer:say("Ouch, its hurt!", TALKTYPE_MONSTER_SAY)
        elseif rand == 2 then
            targetPlayer:say("Ouch!", TALKTYPE_MONSTER_SAY)
        end
    end
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local function combo(parameters)
    local player = Player(parameters.cid)
    if not player then
        return
    end
    
    player:addCondition(exhaust)
    local vocation = player:getVocation():getId()
    
    if table.contains({1, 2, 5, 6}, vocation) then
        mmage1:execute(player, parameters.var)
    elseif table.contains({3, 7}, vocation) then
        marcher1:execute(player, parameters.var)
    end
end

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end
    
    local parameters = { cid = player:getId(), var = variant }
    
    if player:getStorageValue(7001) == 1 then
        player:getPosition():sendAnimatedText("Combo!", 215)
        local vocation = player:getVocation():getId()
        
        if table.contains({1, 2, 5, 6}, vocation) then
            player:say('Trovão!', TALKTYPE_MONSTER_SAY)
        elseif table.contains({3, 7}, vocation) then
            player:say('Rajada!', TALKTYPE_MONSTER_SAY)
        end
        
        player:setStorageValue(7001, 0)
        addEvent(combo, 800, parameters)
        addEvent(combo, 1200, parameters)
        addEvent(combo, 1600, parameters)
        
        if player:getStorageValue(7000) > 900 then
            addEvent(combo, 2000, parameters)
            addEvent(combo, 2400, parameters)
        end
    end
    
    local rand = math.random(1, 50)
    if rand == 1 then
        player:say("Take This!", TALKTYPE_MONSTER_SAY)
    end
    
    return combat:execute(creature, variant)
end
