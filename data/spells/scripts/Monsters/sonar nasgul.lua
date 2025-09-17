local combat = Combat()

local meteor = Combat()
meteor:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
meteor:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
meteor:setFormula(COMBAT_FORMULA_LEVELMAGIC, -60.0, -2300, -40.0, -2200)

local combat_arr = {
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

local combat_area = CombatArea(combat_arr)
combat:setArea(combat_area)

local function meteorCast(p)
    combat:execute(p.cid, p.pos)
end

local function stunEffect(cid)
    doSendMagicEffect(getCreaturePosition(cid), CONST_ME_STUN)
end

local function onTargetTile(cid, pos)
    if (math.random(0, 0) == 0) then
        local ground = getTileItemById(pos, water)
        if (ground.itemid > 0) then
            local newpos = {x = pos.x - 7, y = pos.y - 6, z = pos.z}
            doSendDistanceShoot(newpos, pos, 10)
            addEvent(meteorCast, 200, {cid = cid, pos = pos, combat = meteor_water})
        else
            local newpos = {x = pos.x - 7, y = pos.y - 6, z = pos.z}
            doSendDistanceShoot(newpos, pos, 10)
            addEvent(meteorCast, 100, {cid = cid,pos = pos, combat = meteor})
        end
    end
end

combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

function onCastSpell(cid, var)
    if getPlayerStorageValue(cid, 10569) == 1 then
        doSendAnimatedText(getCreaturePosition(cid), "Silence!", 129)
        doPlayerSendDefaultCancel(cid, RETURNVALUE_YOUAREEXHAUSTED)
        return false
    end
    return combat:execute(cid, var)
end
