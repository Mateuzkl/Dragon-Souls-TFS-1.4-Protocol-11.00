local storage = 88888 -- storage/ não mexa
local k = 1 -- não mexa
local duration = 20 -- duração em segundos da aurea
local tipo = "fire" -- tipo da aurea. validos: "fire","ice","energy","death","earth","all".
local offsets = {
	 [0] = {{0, 0}, {1, 0}, {1, 1}, {1, 2}, {0, 2}, {-1, 2}, {-1, 1}, {-1, 0}},
	 [1] = {{0, 0}, {0, 1}, {-1, 1}, {-2, 1}, {-2, 0}, {-2, -1}, {-1, -1}, {0, -1}},
	 [2] = {{0, 0}, {-1, 0}, {-1, -1}, {-1, -2}, {0, -2}, {1, -2}, {1, -1}, {1, 0}},
	 [3] = {{0, 0}, {0, -1}, {1, -1}, {2, -1}, {2, 0}, {2, 1}, {1, 1}, {0, 1}}
}
local combatType = {
["fire"] = {damage=COMBAT_FIREDAMAGE, attack=CONST_ME_FIREATTACK},
["ice"] = {damage=COMBAT_ICEDAMAGE, attack=CONST_ME_ICEATTACK},
["energy"] = {damage=COMBAT_ENERGYDAMAGE, attack=CONST_ME_ENERGYAREA},
["death"] = {damage=COMBAT_DEATHDAMAGE, attack=CONST_ME_MORTAREA},
["earth"] = {damage=COMBAT_EARTHDAMAGE, attack=CONST_ME_SMALLPLANTS},
["all"] = {damage=COMBAT_NONE, attack=CONST_ME_NONE}
}
local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, combatType[tipo].damage)
setCombatParam(combat, COMBAT_PARAM_EFFECT, combatType[tipo].attack)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -1, -10, -1, -20, 10, 10, 2.4, 2.4)
local combat_fire = createCombatObject()
setCombatParam(combat_fire, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat_fire, COMBAT_PARAM_EFFECT, CONST_ME_FIREATTACK)
setCombatFormula(combat_fire, COMBAT_FORMULA_SKILL, 1.0, -60, 1.0, -80)
local combat_ice = createCombatObject()
setCombatParam(combat_ice, COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
setCombatParam(combat_ice, COMBAT_PARAM_EFFECT, CONST_ME_ICEATTACK)
setCombatFormula(combat_ice, COMBAT_FORMULA_LEVELMAGIC, -1, -10, -1, -20, 10, 10, 2.4, 2.4)
local combat_energy = createCombatObject()
setCombatParam(combat_energy, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatParam(combat_energy, COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
setCombatFormula(combat_energy, COMBAT_FORMULA_LEVELMAGIC, -1, -10, -1, -20, 10, 10, 2.4, 2.4)
local combat_death = createCombatObject()
setCombatParam(combat_death, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat_death, COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
setCombatFormula(combat_death, COMBAT_FORMULA_LEVELMAGIC, -1, -10, -1, -20, 10, 10, 2.4, 2.4)
local combat_earth = createCombatObject()
setCombatParam(combat_earth, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
setCombatParam(combat_earth, COMBAT_PARAM_EFFECT, CONST_ME_SMALLPLANTS)
setCombatFormula(combat_earth, COMBAT_FORMULA_LEVELMAGIC, -1, -10, -1, -20, 10, 10, 2.4, 2.4)
local combatAll = {combat_fire,combat_ice,combat_energy,combat_death,combat_earth}
function onCastAura(cid, lastDirection)
if getTilePzInfo(getCreaturePosition(cid)) then
doPlayerSendTextMessage(cid, MESSAGE_STATUS_DEFAULT, "Aura effect ended.")
return true
end
local position = getPositionByDirection(getThingPosition(cid), lastDirection, 1)
local offset = offsets[lastDirection][(k > #offsets[lastDirection] and ((k % #offsets[lastDirection]) == 0 and #offsets[lastDirection] or (k % #offsets[lastDirection])) or k)]
local tmp = {x = position.x + offset[1], y = position.y + offset[2], z = position.z}
if tipo == "all" then
doCombat(cid, combatAll[math.random(1,#combatAll)], positionToVariant(tmp))
else
doCombat(cid, combat, positionToVariant(tmp))
end
if os.time() < getCreatureStorage(cid, storage) then
	 addEvent(onCastAura, 100, cid, getCreatureLookDirection(cid))
else
	 doPlayerSendTextMessage(cid, MESSAGE_STATUS_DEFAULT, "Aura effect ended.")
end
k = k + 1
end
function onCastSpell(cid, var)
doCreatureSetStorage(cid, storage, os.time() + duration)
onCastAura(cid, getCreatureLookDirection(cid))
return true
end