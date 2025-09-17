local combatDist = Combat()
combatDist:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combatDist:setParameter(COMBAT_PARAM_EFFECT, 202)
combatDist:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 32)
combatDist:setFormula(COMBAT_FORMULA_LEVELMAGIC, -7.7, 0, -10.9, 0)

local drunk = Condition(CONDITION_DRUNK)
drunk:setParameter(CONDITION_PARAM_TICKS, 15000)
combatDist:setCondition(drunk)

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)

local function restoreOutfit(targetId, originalOutfit)
    local target = Player(targetId)
    if target then
        target:setOutfit(originalOutfit)
    end
end

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end
    
    local target = creature:getTarget()
    if not target then
        player:sendCancelMessage('Select your target.')
        creature:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end
    
    local function frozzen(targetId, damage)
        local target = Creature(targetId)
        if target then
            target:getPosition():sendMagicEffect(81)
            target:addHealth(-damage)
            Game.sendAnimatedText("-" .. damage, target:getPosition(), TEXTCOLOR_RED)
        end
    end
    
    local function frozzen2(targetId, damage)
        local target = Creature(targetId)
        if target then
            target:getPosition():sendMagicEffect(82)
            target:addHealth(-damage)
            Game.sendAnimatedText("-" .. damage, target:getPosition(), TEXTCOLOR_RED)
        end
    end
    
    local targetId = target:getId()
    local rand1 = math.random(2000, 4000)
    local rand2 = math.random(2000, 4000)
    local rand3 = math.random(2000, 4000)
    local rand4 = math.random(2000, 4000)
    local rand5 = math.random(2000, 4000)
    
    if target:isPlayer() then
        local targetPlayer = target:getPlayer()
        local targetOutfit = target:getOutfit()
        local congelado = {
            lookType = targetOutfit.lookType,
            lookHead = 9,
            lookBody = 9,
            lookLegs = 9,
            lookFeet = 9,
            lookAddons = targetOutfit.lookAddons
        }
        target:setOutfit(congelado)
        targetPlayer:sendTextMessage(MESSAGE_STATUS_WARNING, 'Voce está em panico.')
        
        addEvent(restoreOutfit, 3000, targetPlayer:getId(), targetOutfit)
        
        combatDist:execute(creature, Variant(target:getPosition()))
    else
        combatDist:execute(creature, Variant(target:getPosition()))
    end
    
    player:say("Exevo Mas Vita", TALKTYPE_MONSTER_SAY)
    
    addEvent(frozzen, 1000, targetId, rand1)
    addEvent(frozzen2, 1500, targetId, rand2)
    addEvent(frozzen, 2000, targetId, rand3)
    addEvent(frozzen, 2500, targetId, rand4)
    addEvent(frozzen, 3000, targetId, rand5)
    
    return combat:execute(creature, variant)
end
