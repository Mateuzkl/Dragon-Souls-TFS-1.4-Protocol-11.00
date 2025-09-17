local combat = Combat()
local meteor = Combat()
meteor:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
meteor:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_PLANTATTACK)
meteor:setParameter(COMBAT_PARAM_HITCOLOR, 246)
meteor:setFormula(COMBAT_FORMULA_LEVELMAGIC, -5.2, -400, -8.0, -600)

local combatArr = {
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

local combatArea = createCombatArea(combatArr)
combat:setArea(combatArea)

local function meteorCast(parameters)
  local cid = parameters.cid
  local pos = parameters.pos
  local combat = parameters.combat
  combat:execute(cid, pos)
end

local function onTargetCreature(cid, target)
  doSendAnimatedText(getThingPos(target), "", 73)
end
combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local function onTargetTile(cid, pos)
  local newpos = {x = pos.x - 7, y = pos.y - 6, z = pos.z}
  doSendDistanceShoot(newpos, pos, 38)
  addEvent(meteorCast, 100, {cid = cid, pos = pos, combat = meteor})
end
combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

local cooldown = 5
local spellCooldowns = {}

local function clearCooldowns()
    local currentTime = os.time()
    for creatureId, cooldownTime in pairs(spellCooldowns) do
        if cooldownTime <= currentTime then
            spellCooldowns[creatureId] = nil
        end
    end
    addEvent(clearCooldowns, 60 * 1000) -- Limpar a tabela a cada 1 minuto
end

function onCastSpell(creature, variant)
    local creatureId = creature:getId()

    if spellCooldowns[creatureId] and spellCooldowns[creatureId] > os.time() then
        local remainingCooldown = spellCooldowns[creatureId] - os.time()
        doSendMagicEffect(getCreaturePosition(creature), CONST_ME_MAGIC_BLUE)
        doPlayerSendCancel(creature, "Wrath of Nature está em cooldown por " .. remainingCooldown .. " segundos.")
        return false
    end

    spellCooldowns[creatureId] = os.time() + cooldown
    addEvent(onCastSpell51, cooldown * 1000, creature)
    return combat:execute(creature, variant)
end

function onCastSpell51(creature)
    if isPlayer(creature) then
        doPlayerSendTextMessage(creature, MESSAGE_STATUS_CONSOLE_RED, "CD: Wrath of Nature.")
    end
end

-- Inicie a limpeza dos cooldowns
clearCooldowns()
