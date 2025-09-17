local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_POISONDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GREEN_RINGS)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -0.1, -25, -0.3, -50)

local condition = Condition(CONDITION_POISON)
condition:setParameter(CONDITION_PARAM_DELAYED, true)
condition:addDamage(1, 3000, -20, -20)
condition:addDamage(2, 3000, -19, -19)
condition:addDamage(3, 3000, -17, -17)
condition:addDamage(4, 3000, -14, -14)
condition:addDamage(5, 3000, -10, -10)
condition:addDamage(4, 3000, -5, -5)
condition:addDamage(3, 3000, -4, -4)
condition:addDamage(5, 3000, -3, -3)
condition:addDamage(4, 3000, -2, -2)
condition:addDamage(10, 3000, -1, -1)
combat:setCondition(condition)

local area = createCombatArea({
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

combat:setArea(area)

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if player then
        local rand = math.random(1, 50)
        if rand == 1 then
            player:say("The sickness will show the real valor of life!", TALKTYPE_MONSTER_SAY)
        elseif rand == 2 then
            player:say("You don't deserves your life!", TALKTYPE_MONSTER_SAY)
        end
    end
    
    return combat:execute(creature, variant)
end
