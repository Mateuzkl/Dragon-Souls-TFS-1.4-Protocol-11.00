local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 61)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -1.2, -30, -3.0, -30)

local area = createCombatArea({
    {0, 1, 1, 1, 0},
    {1, 1, 1, 1, 1},
    {1, 1, 2, 1, 1},
    {1, 1, 1, 1, 1},
    {0, 1, 1, 1, 0}
})

combat:setArea(area)

local function Cooldown(playerId)
    local player = Player(playerId)
    if player then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, 'CD: Exevo Mas San')
    end
end

local exhausted_seconds = 5
local exhausted_storagevalue = 45625

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end
    
    if os.time() < player:getStorageValue(exhausted_storagevalue) then
        player:sendCancelMessage('O Cooldown não está pronto.')
        return false
    end
    
    local rand = math.random(1, 50)
    if rand == 1 then
        player:say("Come on! I got more for you!", TALKTYPE_MONSTER_SAY)
    elseif rand == 2 then
        player:say("Feel the power of light!", TALKTYPE_MONSTER_SAY)
    end
    
    player:setStorageValue(exhausted_storagevalue, os.time() + exhausted_seconds)
    addEvent(Cooldown, exhausted_seconds * 1000, player:getId())
    
    return combat:execute(creature, variant)
end
