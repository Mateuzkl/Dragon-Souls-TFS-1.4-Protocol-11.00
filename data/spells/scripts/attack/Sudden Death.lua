local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SUDDENDEATH)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -0.85, -30, -1.75, 0)

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
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
marcher1:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
marcher1:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 16)

local mmage1 = Combat()
mmage1:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
mmage1:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_EXPLOSIONHIT)
mmage1:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)
mmage1:setFormula(COMBAT_FORMULA_LEVELMAGIC, -0.4, 0, -0.8, 0)

function onGetFormulaValues1(player, level, maglevel)
    local weapon = player:getSlotItem(CONST_SLOT_RING)
    if weapon and weapon:getId() == 2543 then
        local skill = player:getSkillLevel(SKILL_DISTANCE)
        local min = -((skill * 5) + level) / 2
        local max = -((skill * 7) + level) / 2
        return min, max
    end
    if weapon and weapon:getId() == 2547 then
        local skill = player:getSkillLevel(SKILL_DISTANCE)
        local min = -((skill * 7) + level) / 2
        local max = -((skill * 9) + level) / 2
        return min, max
    end
    return 0, 0
end

marcher1:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues1")

function onTargetCreature(creature, target)
    local player = creature:getPlayer()
    local targetPlayer = target:getPlayer()
    
    if player and targetPlayer then
        local outfit = targetPlayer:getOutfit()
        
        if outfit.lookType == 194 then
            targetPlayer:say('Haha!', TALKTYPE_MONSTER_SAY)
            return combat2:execute(target, Variant(player:getPosition()))
        end
        
        if outfit.lookType == 251 then
            targetPlayer:say('Weak!', TALKTYPE_MONSTER_SAY)
            combat3:execute(creature, Variant(target:getPosition()))
            return combat4:execute(creature, Variant(target:getPosition()))
        end
        
        if outfit.lookType == 262 then
            targetPlayer:say('Shhhh!', TALKTYPE_MONSTER_SAY)
            Game.sendAnimatedText("Silence!", player:getPosition(), 215)
            player:say('...', TALKTYPE_MONSTER_SAY)
            player:addCondition(exhaust)
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

local function combo(creatureId, targetId)
    local creature = Creature(creatureId)
    if not creature then
        return
    end

    local player = creature:getPlayer()
    if not player then
        return
    end
    
    local target = Creature(targetId)
    if not target then
        return
    end
    
    player:addCondition(exhaust)
    local vocation = player:getVocation():getId()
    local var = Variant(targetId)
    
    if table.contains({1, 2, 5, 6}, vocation) then
        mmage1:execute(creature, var)
    end
    
    if table.contains({3, 7}, vocation) then
        marcher1:execute(creature, var)
    end
end

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end
    
    local comboChance = math.random(1, 10)
    if comboChance == 1 then
        Game.sendAnimatedText("Combo!", player:getPosition(), 215)
        local vocation = player:getVocation():getId()
        
        if table.contains({1, 2, 5, 6}, vocation) then
            player:say('Trovão!', TALKTYPE_MONSTER_SAY)
        end
        
        if table.contains({3, 7}, vocation) then
            player:say('Rajada!', TALKTYPE_MONSTER_SAY)
        end
        
        local creatureId = creature:getId()
        local targetId = variant:getNumber()
        
        addEvent(combo, 800, creatureId, targetId)
        addEvent(combo, 1200, creatureId, targetId)
        addEvent(combo, 1600, creatureId, targetId)
        
        local extendedChance = math.random(1, 20)
        if extendedChance == 1 then
            addEvent(combo, 2000, creatureId, targetId)
            addEvent(combo, 2400, creatureId, targetId)
        end
    end
    
    local rand = math.random(1, 50)
    if rand == 1 then
        player:say("Take This!", TALKTYPE_MONSTER_SAY)
    end
    
    return combat:execute(creature, variant)
end
