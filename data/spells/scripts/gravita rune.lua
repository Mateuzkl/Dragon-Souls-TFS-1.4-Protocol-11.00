local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 34)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_NONE)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -7.3, -250, -10.0, -1000)

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, 34)
combat2:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_NONE)
combat2:setFormula(COMBAT_FORMULA_LEVELMAGIC, -9.9, -250, -10.0, -1200)

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end
    
    local rand = math.random(97, 100)
    player:getPosition():sendAnimatedText("Gravita!", TEXTCOLOR_LIGHTGREEN)
    
    if rand == 99 then
        player:addHealth(-2500)
        player:say("Ouch!", TALKTYPE_MONSTER_SAY)
        return combat2:execute(creature, variant)
    else
        return combat:execute(creature, variant)
    end
end
