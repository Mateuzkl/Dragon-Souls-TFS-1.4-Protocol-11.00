local config = {
    effect = CONST_ME_MAGIC_BLUE, -- Efeito visual da magia
    distanceEffect = CONST_ANI_ICE -- Efeito visual de distância da magia
}

local condition = Condition(CONDITION_OUTFIT)
condition:setParameter(CONDITION_PARAM_TICKS, 4000)
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

local function unfreeze(cid)
    local creature = Creature(cid)
    if not creature then
        return
    end

    local pos = creature:getPosition()
    pos:sendDistanceEffect(Position(pos.x + 1, pos.y + 1, pos.z), config.distanceEffect)
    pos:sendDistanceEffect(Position(pos.x + 1, pos.y - 1, pos.z), config.distanceEffect)
    pos:sendDistanceEffect(Position(pos.x - 1, pos.y - 1, pos.z), config.distanceEffect)
    pos:sendDistanceEffect(Position(pos.x - 1, pos.y + 1, pos.z), config.distanceEffect)
    creature:say("UNFROZEN", TALKTYPE_MONSTER_SAY)
    pos:sendMagicEffect(config.effect)
    creature:setMovementBlocked(false)
end

function onCastSpell(cid, var)
    local player = Player(cid)
    local target = Creature(var.number)
    if not target or (not target:isPlayer() and not target:isMonster()) then
        player:sendCancelMessage("You can only freeze players and monsters.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end

    local pos = target:getPosition()
    pos:sendDistanceEffect(Position(pos.x + 1, pos.y + 1, pos.z), config.distanceEffect)
    pos:sendDistanceEffect(Position(pos.x + 1, pos.y - 1, pos.z), config.distanceEffect)
    pos:sendDistanceEffect(Position(pos.x - 1, pos.y - 1, pos.z), config.distanceEffect)
    pos:sendDistanceEffect(Position(pos.x - 1, pos.y + 1, pos.z), config.distanceEffect)
    target:addCondition(condition)
    pos:sendMagicEffect(config.effect)
    target:say("FROZEN", TALKTYPE_MONSTER_SAY)
    target:setMovementBlocked(true)
    addEvent(freezeTimer, 1000, target.uid, target:getPosition(), 3000 / 1000)
    addEvent(unfreeze, 4000, target.uid)

    return true
end
