local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -2.0, -30, -2.6, 0)

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combat2:setFormula(COMBAT_FORMULA_LEVELMAGIC, -1.0, -30, -1.4, 0)

local exhaust = Condition(CONDITION_EXHAUSTED)
exhaust:setParameter(CONDITION_PARAM_TICKS, 2000)

local area = createCombatArea({
    {1, 1, 1},
    {1, 2, 1},
    {1, 1, 1}
})

combat:setArea(area)
combat2:setArea(area)

local function combo(parameters)
    local creature = Creature(parameters.creatureId)
    if not creature then
        return
    end
    
    creature:addCondition(exhaust)
    parameters.combat2:execute(creature, parameters.variant)
end

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end
    
    local creatureId = creature:getId()
    local parameters = { 
        creatureId = creatureId, 
        variant = variant, 
        combat2 = combat2 
    }
    
    if player:getStorageValue(7001) == 1 then
        creature:getPosition():sendAnimatedText("Combo!", 215)
        player:say('Fúria!', TALKTYPE_MONSTER_SAY)
        
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
        player:say("Feel my fury!", TALKTYPE_MONSTER_SAY)
    elseif rand == 2 then
        player:say("GROOOAR!", TALKTYPE_MONSTER_SAY)
    end
    
    return combat:execute(creature, variant)
end
