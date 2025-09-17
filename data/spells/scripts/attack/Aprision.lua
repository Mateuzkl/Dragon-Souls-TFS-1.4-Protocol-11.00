local combat1 = Combat()
combat1:setParameter(COMBAT_PARAM_HITCOLOR, 64)
combat1:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat1:setParameter(COMBAT_PARAM_BLOCKARMOR, false)
combat1:setParameter(COMBAT_PARAM_EFFECT, 68)
combat1:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 35)
combat1:setFormula(COMBAT_FORMULA_LEVELMAGIC, -30.6, -119, -22.0, 0)

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_HITCOLOR, 64)
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat2:setParameter(COMBAT_PARAM_BLOCKARMOR, false)
combat2:setParameter(COMBAT_PARAM_EFFECT, 68)
combat2:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 35)
combat2:setFormula(COMBAT_FORMULA_LEVELMAGIC, -30.6, -119, -22.0, 0)

local combat3 = Combat()
combat3:setParameter(COMBAT_PARAM_HITCOLOR, 64)
combat3:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat3:setParameter(COMBAT_PARAM_BLOCKARMOR, false)
combat3:setParameter(COMBAT_PARAM_EFFECT, 68)
combat3:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 35)
combat3:setFormula(COMBAT_FORMULA_LEVELMAGIC, -30.6, -119, -22.0, 0)

local combat4 = Combat()
combat4:setParameter(COMBAT_PARAM_HITCOLOR, 64)
combat4:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat4:setParameter(COMBAT_PARAM_BLOCKARMOR, false)
combat4:setParameter(COMBAT_PARAM_EFFECT, 68)
combat4:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 35)
combat4:setFormula(COMBAT_FORMULA_LEVELMAGIC, -30.6, -119, -22.0, 0)

local combat5 = Combat()
combat5:setParameter(COMBAT_PARAM_HITCOLOR, 64)
combat5:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat5:setParameter(COMBAT_PARAM_BLOCKARMOR, false)
combat5:setParameter(COMBAT_PARAM_EFFECT, 68)
combat5:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 35)
combat5:setFormula(COMBAT_FORMULA_LEVELMAGIC, -30.6, -119, -22.0, 0)

local combat6 = Combat()
combat6:setParameter(COMBAT_PARAM_HITCOLOR, 64)
combat6:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat6:setParameter(COMBAT_PARAM_BLOCKARMOR, false)
combat6:setParameter(COMBAT_PARAM_EFFECT, 68)
combat6:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 35)
combat6:setFormula(COMBAT_FORMULA_LEVELMAGIC, -30.6, -119, -22.0, 0)

local combat7 = Combat()
combat7:setParameter(COMBAT_PARAM_HITCOLOR, 64)
combat7:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat7:setParameter(COMBAT_PARAM_BLOCKARMOR, false)
combat7:setParameter(COMBAT_PARAM_EFFECT, 68)
combat7:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 35)
combat7:setFormula(COMBAT_FORMULA_LEVELMAGIC, -30.6, -119, -22.0, 0)

local combat8 = Combat()
combat8:setParameter(COMBAT_PARAM_HITCOLOR, 64)
combat8:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat8:setParameter(COMBAT_PARAM_BLOCKARMOR, false)
combat8:setParameter(COMBAT_PARAM_EFFECT, 68)
combat8:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 35)
combat8:setFormula(COMBAT_FORMULA_LEVELMAGIC, -30.6, -119, -22.0, 0)

local combat9 = Combat()
combat9:setParameter(COMBAT_PARAM_HITCOLOR, 64)
combat9:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat9:setParameter(COMBAT_PARAM_BLOCKARMOR, false)
combat9:setParameter(COMBAT_PARAM_EFFECT, 68)
combat9:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 35)
combat9:setFormula(COMBAT_FORMULA_LEVELMAGIC, -30.6, -119, -22.0, 0)

local combat10 = Combat()
combat10:setParameter(COMBAT_PARAM_HITCOLOR, 64)
combat10:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat10:setParameter(COMBAT_PARAM_BLOCKARMOR, false)
combat10:setParameter(COMBAT_PARAM_EFFECT, 68)
combat10:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 35)
combat10:setFormula(COMBAT_FORMULA_LEVELMAGIC, -30.6, -119, -22.0, 0)

local function onCastSpell1(parameters)
    parameters.combat1:execute(parameters.cid, parameters.var)
end

local function onCastSpell2(parameters)
    parameters.combat2:execute(parameters.cid, parameters.var)
end

local function onCastSpell3(parameters)
    parameters.combat3:execute(parameters.cid, parameters.var)
end

local function onCastSpell4(parameters)
    parameters.combat4:execute(parameters.cid, parameters.var)
end

local function onCastSpell5(parameters)
    parameters.combat5:execute(parameters.cid, parameters.var)
end

local function onCastSpell6(parameters)
    parameters.combat6:execute(parameters.cid, parameters.var)
end

local function onCastSpell7(parameters)
    parameters.combat7:execute(parameters.cid, parameters.var)
end

local function onCastSpell8(parameters)
    parameters.combat8:execute(parameters.cid, parameters.var)
end

local function onCastSpell9(parameters)
    parameters.combat9:execute(parameters.cid, parameters.var)
end

local function onCastSpell10(parameters)
    parameters.combat10:execute(parameters.cid, parameters.var)
end

function onCastSpell9988(cid)
    if isPlayer(cid) then
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "CD: The Energy.")
    end
end

function onCastSpell(cid, var)
    local parameters = {
        cid = cid,
        var = var,
        combat1 = combat1,
        combat2 = combat2,
        combat3 = combat3,
        combat4 = combat4,
        combat5 = combat5,
        combat6 = combat6,
        combat7 = combat7,
        combat8 = combat8,
        combat9 = combat9,
        combat10 = combat10
    }

    addEvent(onCastSpell1, 0, parameters)
    addEvent(onCastSpell2, 500, parameters)
    addEvent(onCastSpell3, 1000, parameters)
    addEvent(onCastSpell4, 1500, parameters)
    addEvent(onCastSpell5, 2000, parameters)
    addEvent(onCastSpell6, 2500, parameters)
    addEvent(onCastSpell7, 3000, parameters)
    addEvent(onCastSpell8, 3500, parameters)
    addEvent(onCastSpell9, 4000, parameters)
    addEvent(onCastSpell10, 4500, parameters)
    addEvent(onCastSpell9988, 10000, cid)

    return true
end
