local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITBYFIRE)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -0.4, -30, -0.9, 0)

local area = createCombatArea({
{1, 1, 1, 1, 1},
{0, 1, 1, 1, 0},
{0, 1, 1, 1, 0},
{0, 0, 2, 0, 0}
})

combat:setArea(area)

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if player then
        local rand = math.random(1, 50)
        if rand == 1 then
            player:say("Flame on!", TALKTYPE_MONSTER_SAY)
        elseif rand == 2 then
            player:say("Burn on the fire of hell!", TALKTYPE_MONSTER_SAY)
        end
    end
    
    return combat:execute(creature, variant)
end
