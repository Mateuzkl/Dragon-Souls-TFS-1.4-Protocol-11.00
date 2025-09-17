local combat = createCombatObject()

local meteor = createCombatObject()
setCombatParam(meteor, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(meteor, COMBAT_PARAM_EFFECT, 121)
setCombatParam(meteor, COMBAT_PARAM_HITCOLOR, 73)
setCombatFormula(meteor, COMBAT_FORMULA_LEVELMAGIC, -99999.99999, -999999, -99999.99999, -999999)

combat_arr = {
{0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
{0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
{1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1},
{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
{0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
{0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
}
local combat_area = createCombatArea(combat_arr)
setCombatArea(combat, combat_area)

local function meteorCast(p)
    doCombat(p.cid, p.combat, positionToVariant(p.pos))
end

local function stunEffect(cid)
    doSendMagicEffect(getThingPos(cid), CONST_ME_STUN)
end

local condition = createConditionObject(CONDITION_FREEZING)
setConditionParam(condition, CONDITION_PARAM_DELAYED, 1)
addDamageCondition(condition, 5, 2000, -200)
addDamageCondition(condition, 10, 2000, -2500)
addDamageCondition(condition, 15, 2000, -3000)
setCombatCondition(meteor, condition)

function onTargetTile(cid, pos)
    if (math.random(0, 0) == 0) then
        local ground = getThingfromPos({x = pos.x, y = pos.y, z = pos.z, stackpos = 0})
        if (isInArray(water, ground.itemid) == TRUE) then
            local newpos = {x = pos.x - 7, y = pos.y - 6, z = pos.z}
            doSendDistanceShoot(newpos, pos, 30)
            addEvent(meteorCast, 200, {cid = cid, pos = pos, combat = meteor_water})
        else
            local newpos = {x = pos.x - 7, y = pos.y - 6, z = pos.z}
            doSendDistanceShoot(newpos, pos, 30)
            addEvent(meteorCast, 100, {cid = cid,pos = pos, combat = meteor})
        end
    end
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTile")

function onCastSpell(cid, var)
if getPlayerStorageValue(cid, 10569) == 1 then
doSendAnimatedText((getCreaturePosition(cid)), "Socorro!", 255)
doSendMagicEffect(getCreaturePosition(cid), 19)
doPlayerSendDefaultCancel(cid, RETURNVALUE_YOUAREEXHAUSTED)
return false 
end

if exhaustion.check(cid, 23014) == false then
return doCombat(cid, combat, var)

else
doSendMagicEffect(getCreaturePosition(cid), 2)
doPlayerSendCancel(cid, "Golpe em cooldown por " ..exhaustion.get(cid, 23014).." segundos")
return false 
end
	return doCombat(cid, combat, var)
end