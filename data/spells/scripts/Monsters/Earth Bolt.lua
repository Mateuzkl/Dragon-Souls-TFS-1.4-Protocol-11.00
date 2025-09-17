local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_EARTH)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_YELLOW_RINGS)
combat:setParameter(COMBAT_PARAM_HITCOLOR, COLOR_BROWN)

local arr = {
    {0, 1, 0},
    {1, 3, 1},
    {0, 1, 0}
}

local area = createCombatArea(arr)

function isTargetInArea(creature, targetPosition)
    local creaturePosition = creature:getPosition()
    local offsetX = targetPosition.x - creaturePosition.x
    local offsetY = targetPosition.y - creaturePosition.y
    local isInArea = area:getPosition(offsetX, offsetY)
    return isInArea
end

function onTargetCreature(creature, target)
    local targetPosition = target:getPosition()
    if isTargetInArea(creature, targetPosition) then
        creature:say("Earth Bolt!", TALKTYPE_MONSTER)
        return combat:execute(creature, variant)
    end
    return false
end

function onCastSpell(cid, var)
    return combat:execute(cid, var)
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(cid, var)
    return combat:execute(cid, var)
end
