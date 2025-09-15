local combat1 = Combat()
combat1:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat1:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat1:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat1:setParameter(COMBAT_PARAM_TARGETCASTERORTOPMOST, true)
combat1:setFormula(COMBAT_FORMULA_LEVELMAGIC, 0.6, -30, 1.2, 0)

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat2:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat2:setParameter(COMBAT_PARAM_TARGETCASTERORTOPMOST, true)
combat2:setFormula(COMBAT_FORMULA_LEVELMAGIC, 0.6, -30, 1.2, 0)

local condition1 = Condition(CONDITION_REGENERATION)
condition1:setParameter(CONDITION_PARAM_TICKS, 60000)
condition1:setParameter(CONDITION_PARAM_MANAGAIN, 1000)
condition1:setParameter(CONDITION_PARAM_MANATICKS, 1)
condition1:setParameter(CONDITION_PARAM_DELAYED, true)
condition1:setParameter(CONDITION_PARAM_HEALTHGAIN, 1000)

combat1:addCondition(condition1)

local condition2 = Condition(CONDITION_ENERGY)
condition2:setParameter(CONDITION_PARAM_DELAYED, true)
condition2:addDamage(120, 60000, 1000, 1000)

combat2:addCondition(condition2)

local area = createCombatArea({
    {0, 0, 1, 1, 1, 0, 0},
    {0, 1, 1, 1, 1, 1, 0},
    {1, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 3, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 1},
    {0, 1, 1, 1, 1, 1, 0},
    {0, 0, 1, 1, 1, 0, 0}
})

combat1:setArea(area)
combat2:setArea(area)

local function onCastSpell1(parameters)
    combat1:execute(Player(parameters.cid), parameters.var)
end

local function onCastSpell2(parameters)
    combat2:execute(Player(parameters.cid), parameters.var)
end

function onTargetCreature(creature, target)
    if target:isPlayer() then
        local rand = math.random(1, 5)
        target:getPosition():sendAnimatedText("Regen!", TEXTCOLOR_TEAL)
        
        if rand == 4 then
            target:getPosition():sendMagicEffect(24)
        end
    end
    return true
end

combat1:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end
    
    local parameters = { cid = player:getId(), var = variant }
    addEvent(onCastSpell1, 1, parameters)
    addEvent(onCastSpell2, 1, parameters)
    
    return true
end
