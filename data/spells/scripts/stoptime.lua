local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_RED)

local condition = Condition(CONDITION_PARALYZE)
condition:setParameter(CONDITION_PARAM_TICKS, 3000)
condition:setParameter(CONDITION_PARAM_SPEED, -300)

combat:addCondition(condition)

local silence = Condition(CONDITION_SILENCE)
silence:setParameter(CONDITION_PARAM_TICKS, 15000)
combat:addCondition(silence)

local area = createCombatArea({
    {0, 1, 1, 1, 0},
    {1, 1, 1, 1, 1},
    {1, 1, 3, 1, 1},
    {1, 1, 1, 1, 1},
    {0, 1, 1, 1, 0}
})

combat:setArea(area)

function onTargetCreature(creature, target)
    local targetPlayer = target:getPlayer()
    if targetPlayer then
        target:getPosition():sendAnimatedText("Silence!", 215)
    end
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end
    
    local rand = math.random(1, 50)
    if rand == 1 then
        player:say("Stop Time!", TALKTYPE_MONSTER_SAY)
    elseif rand == 2 then
        player:say("Stop Bitch!", TALKTYPE_MONSTER_SAY)
    end
    
    return combat:execute(creature, variant)
end
