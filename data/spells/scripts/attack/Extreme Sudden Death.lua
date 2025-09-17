local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 39)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -3.50, -30, -6.25, 0)

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat2:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 39)
combat2:setFormula(COMBAT_FORMULA_LEVELMAGIC, -1.70, -30, -3.10, 0)

local combat3 = Combat()
combat3:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat3:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat3:setParameter(COMBAT_PARAM_TARGETCASTERORTOPMOST, true)
combat3:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat3:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)
combat3:setFormula(COMBAT_FORMULA_LEVELMAGIC, 1.8, 0, 3.6, 0)

local combat4 = Combat()
combat4:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_RED)
combat4:setParameter(COMBAT_PARAM_TYPE, COMBAT_MANADRAIN)
combat4:setFormula(COMBAT_FORMULA_LEVELMAGIC, 1.0, 0, 2.0, 0)

local exhaust = Condition(CONDITION_EXHAUSTED)
exhaust:setParameter(CONDITION_PARAM_TICKS, 3000)

function onTargetCreature(creature, target)
    local player = creature:getPlayer()
    local targetPlayer = target:getPlayer()
    
    if player and targetPlayer then
        local targetOutfit = target:getOutfit()
        
        if targetOutfit.lookType == 194 then
            targetPlayer:say('Haha!', TALKTYPE_MONSTER_SAY)
            return combat2:execute(target, Variant(creature:getPosition()))
        elseif targetOutfit.lookType == 251 then
            targetPlayer:say('Weak!', TALKTYPE_MONSTER_SAY)
            combat3:execute(creature, Variant(target:getPosition()))
            return combat4:execute(creature, Variant(target:getPosition()))
        elseif targetOutfit.lookType == 262 then
            targetPlayer:say('Shhhh!', TALKTYPE_MONSTER_SAY)
            Game.sendAnimatedText("Silence!", creature:getPosition(), 215)
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

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if player then
        local rande = math.random(1, 50)
        if rande == 1 then
            player:say("Take This!", TALKTYPE_MONSTER_SAY)
        end
    end
    
    return combat:execute(creature, variant)
end
