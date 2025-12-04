local combat1 = Combat()
combat1:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat1:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat1:setFormula(COMBAT_FORMULA_LEVELMAGIC, -3.50, -30, -6.25, 0)

local condition1 = Condition(CONDITION_PARALYZE)
condition1:setParameter(CONDITION_PARAM_TICKS, 6000)
condition1:setFormula(-0.7, 0, -0.7, 0)
combat1:setCondition(condition1)

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, 131)
combat2:setFormula(COMBAT_FORMULA_LEVELMAGIC, -13.7, 0, -19.9, 0)

local condition2 = Condition(CONDITION_PARALYZE)
condition2:setParameter(CONDITION_PARAM_TICKS, 6000)
condition2:setFormula(-0.7, 0, -0.7, 0)
combat2:setCondition(condition2)

local area1 = createCombatArea({
{0, 1, 1, 1, 0},
{1, 1, 1, 1, 1},
{1, 1, 2, 1, 1},
{1, 1, 1, 1, 1},
{0, 1, 1, 1, 0}
})

local area2 = createCombatArea({
{0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
{0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
{1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1},
{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
{0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
{0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0}
})

combat1:setArea(area1)
combat2:setArea(area2)

function onTargetCreature(creature, target)
    Game.sendAnimatedText("Weakness!", target:getPosition(), TEXTCOLOR_WHITE_EXP)
    
    local rand = math.random(1, 5)
    if rand < 4 then
        target:getPosition():sendMagicEffect(CONST_ME_MORTAREA)
    end
    
    return true
end

combat1:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local function spell2(creatureId, variant)
    local creature = Creature(creatureId)
    if creature then
        combat2:execute(creature, variant)
    end
end

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end
    
    combat1:execute(creature, variant)
    
    local comboChance = math.random(1, 5)
    if comboChance == 1 then
        addEvent(spell2, 150, creature:getId(), variant)
    end
    
    return true
end
