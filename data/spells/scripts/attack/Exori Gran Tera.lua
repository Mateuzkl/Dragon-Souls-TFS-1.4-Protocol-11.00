local combat1 = Combat()
combat1:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat1:setParameter(COMBAT_PARAM_EFFECT, 189)
combat1:setFormula(COMBAT_FORMULA_LEVELMAGIC, -13.7, 0, -19.9, 0)
combat1:setParameter(COMBAT_PARAM_CREATEITEM, 5396)

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, 189)
combat2:setFormula(COMBAT_FORMULA_LEVELMAGIC, -13.7, 0, -19.9, 0)

local area = createCombatArea({
{0, 0, 0, 0, 0, 0, 0},
{0, 1, 1, 1, 1, 1, 0},
{0, 1, 1, 1, 1, 1, 0},
{0, 1, 1, 2, 1, 1, 0},
{0, 1, 1, 1, 1, 1, 0},
{0, 1, 1, 1, 1, 1, 0},
{0, 0, 0, 0, 0, 0, 0}
})

combat1:setArea(area)
combat2:setArea(area)

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end
    
    local rand = math.random(1, 50)
    if rand == 1 then
        player:say("Does not move!", TALKTYPE_MONSTER_SAY)
    elseif rand == 2 then
        player:say("Where do you think you're going?", TALKTYPE_MONSTER_SAY)
    end
    
    return combat1:execute(creature, variant)
end
