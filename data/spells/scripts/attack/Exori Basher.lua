local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 113)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 55)
combat:setParameter(COMBAT_PARAM_HITCOLOR, 32)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -3.4, -1000, -4.4, -2700)

function onCastSpell(cid, var)
    local player = Player(cid)
    if not player then
        return false
    end

    if player:getCondition(CONDITION_EXHAUST) then
        player:sendCancelMessage(RETURNVALUE_YOUAREEXHAUSTED)
        return false
    end

    local position = player:getPosition()
    Game.sendAnimatedText("Silence!", position, 20)

    local exhaustTime = 10 -- Substitua pelo tempo desejado em segundos
    player:addCondition(Condition(CONDITION_EXHAUST, exhaustTime * 1000))

    return combat:execute(player, var)
end
