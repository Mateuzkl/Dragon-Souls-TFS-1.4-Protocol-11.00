local combatDist = Combat()
combatDist:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combatDist:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 44)
combatDist:setFormula(COMBAT_FORMULA_LEVELMAGIC, -7.7, 0, -10.9, 0)

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)

local condition = Condition(CONDITION_OUTFIT)
condition:setParameter(CONDITION_PARAM_TICKS, 3000)
condition:setOutfit({lookTypeEx = 7303})

local function freezeTimer(creature, pos, count)
    if count >= 1 and Creature(creature) then
        local spectators = Game.getSpectators(pos, false, false, 13, 13, 7, 7)
        if #spectators > 0 then
            for _, spectator in pairs(spectators) do
                if spectator:isPlayer() then
                    spectator:sendTextMessage(MESSAGE_HEALED, nil, pos, count, TEXTCOLOR_ORANGE)
                end
            end
        end
        addEvent(freezeTimer, 1000, creature, pos, count - 1)
    end
end

local function unfreeze(targetId, pos)
    local target = Player(targetId)
    if target then
        pos:sendDistanceEffect(Position(pos.x+1, pos.y+1, pos.z), 29)
        pos:sendDistanceEffect(Position(pos.x+1, pos.y-1, pos.z), 29)
        pos:sendDistanceEffect(Position(pos.x-1, pos.y-1, pos.z), 29)
        pos:sendDistanceEffect(Position(pos.x-1, pos.y+1, pos.z), 29)
        target:say("UNFROZEN", TALKTYPE_MONSTER_SAY)
        pos:sendMagicEffect(44)
        target:setMovementBlocked(false)
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
    
    local pos = target:getPosition()
    
    if target:isPlayer() then
        local freezeChance = math.random(1, 100)
        if freezeChance <= 70 then
            Position(pos.x+1, pos.y+1, pos.z):sendDistanceEffect(pos, 29)
            Position(pos.x+1, pos.y-1, pos.z):sendDistanceEffect(pos, 29)
            Position(pos.x-1, pos.y-1, pos.z):sendDistanceEffect(pos, 29)
            Position(pos.x-1, pos.y+1, pos.z):sendDistanceEffect(pos, 29)
            
            target:addCondition(condition)
            target:say("FROZEN", TALKTYPE_MONSTER_SAY)
            target:setMovementBlocked(true)
            
            addEvent(freezeTimer, 1000, target.uid, target:getPosition(), 3000 / 1000)
            addEvent(unfreeze, 3000, target.uid, target:getPosition())
        else
            Game.sendAnimatedText("Resisted!", target:getPosition(), 215)
        end
    end
    
    pos:sendMagicEffect(44)
    combatDist:execute(creature, Variant(target:getPosition()))
    
    player:say("Adori Frigo!", TALKTYPE_MONSTER_SAY)
    
    return combat:execute(creature, variant)
end
