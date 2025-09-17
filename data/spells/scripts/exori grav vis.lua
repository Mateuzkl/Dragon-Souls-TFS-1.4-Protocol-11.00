 local config = {
                jumps = 50,
                walktime = 500
}

combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TARGETCASTERORTOPMOST, true)
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 57)
setCombatParam(combat, COMBAT_PARAM_HITCOLOR, 70)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -50.0, -500, -30.0, -1000)

local condition = createConditionObject(CONDITION_PARALYZE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 20000)
setConditionParam(condition, CONDITION_PARAM_SPEED, -600)
setCombatCondition(combat, condition)


function onCastSpell(cid)
if getPlayerStorageValue(cid, 10569) == 1 then
doSendAnimatedText((getCreaturePosition(cid)), "Socorro!", 255)
doPlayerSendDefaultCancel(cid, RETURNVALUE_YOUAREEXHAUSTED)
return false 
end
    function move(cid, pos, n)
        local n = n or 0

        if (n < config.jumps) then
            if (isCreature(cid)) then
                local pos = pos or getCreaturePosition(cid)
                local target = getCreatureTarget(cid)

                local dir = (target ~= 0) and getDirectionTo(pos, getCreaturePosition(target)) or getCreatureLookDirection(cid)
                local tpos = (target ~= 0) and getCreaturePosition(target)

                local newPos

                if ((target ~= 0) and ((pos.x == tpos.x) and (pos.y == tpos.y))) then
                    newPos = tpos
                else
                    newPos = getPosByDir(pos, dir)
                end

                if ((getTopCreature(newPos).uid == 0) and doTileQueryAdd(cid, newPos) ~= 1) then return false end

                doCombat(cid, combat, {
                    pos = newPos,
                    type = 2
                })

                addEvent(move, config.walktime, cid, newPos, n + 1)
            end
        end
    end

    move(cid)
    return true
end  