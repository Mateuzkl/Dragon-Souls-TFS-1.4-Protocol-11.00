local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -60.0, -2300, -40.0, -2200)

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

local area = createCombatArea(combat_arr)
combat:setArea(area)

local function meteorCast(p)
    local combatToExecute = p.combat or combat
    combatToExecute:execute(p.cid, p.pos)
end

local function onTargetTile(cid, pos)
    local newpos = {x = pos.x - 7, y = pos.y - 6, z = pos.z}
    doSendDistanceShoot(newpos, pos, CONST_ANI_SUDDENDEATH)
    addEvent(meteorCast, 100, {cid = cid, pos = pos, combat = combat})
end

combat:setCallback(CALLBACK_PARAM_TARGETTILE, "
