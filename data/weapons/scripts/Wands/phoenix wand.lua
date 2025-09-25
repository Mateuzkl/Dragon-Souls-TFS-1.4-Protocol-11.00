local combat1 = Combat()
combat1:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat1:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 60)
combat1:setParameter(COMBAT_PARAM_EFFECT, 127)
combat1:setFormula(COMBAT_FORMULA_LEVELMAGIC, -1.9, 0, -2.4, 0)

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat2:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 60)
combat2:setParameter(COMBAT_PARAM_EFFECT, 127)
combat2:setFormula(COMBAT_FORMULA_LEVELMAGIC, -3.1, 0, -4.9, 0)

function onUseWeapon(player, variant)
    local critical = math.random(1, 100)
    if critical > 95 then
        player:say("Burn in the HELL!", TALKTYPE_MONSTER_SAY)
        Game.sendAnimatedText("Critical!", player:getPosition(), 180)
        return combat2:execute(player, variant)
    else 
        return combat1:execute(player, variant)
    end
end