local combat1 = Combat()
combat1:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)

local combat3 = Combat()
combat3:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)

local combat4 = Combat()
combat4:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)

local arr = {
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
    {0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0}
}

local area = createCombatArea(arr)
combat1:setArea(area)
combat2:setArea(area)
combat3:setArea(area)
combat4:setArea(area)

local function spell4(cid)
    local creature = Player(cid)
    combat4:execute(creature, param)
end

local function spell3(cid)
    local creature = Player(cid)
    addEvent(spell4, 750, cid)
    return combat3:execute(creature, param)
end

local function spell2(cid)
    local creature = Player(cid)
    addEvent(spell3, 750, cid)
    return combat2:execute(creature, param)
end

local function spell1(cid)
    local creature = Player(cid)
    addEvent(spell2, 750, cid)
    return combat1:execute(creature, param)
end

function spellCallback(cid, param)
    local form = 3.5

    if param.count > 0 or math.random(0, 1) == 1 then
        doSendMagicEffect(param.pos, CONST_ME_MORTAREA)
        spell1(cid)
    end

    if not isCreature(cid) then
        return false
    end

    if param.count < 5 then
        param.count = param.count + 1
        addEvent(spellCallback, math.random(1000, 3000), cid, param)
    end
end

function onCastSpell(cid, var)
    return spell1(cid, var)
end

function onTargetTile(cid, pos)
    local param = {cid = cid, pos = pos, count = 0}
    spellCallback(cid, param)
end

combat1:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

function onCastSpell(cid, var)
    return spell1(cid, var)
end
