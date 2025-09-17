
local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, 63)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local function revertGhostMode(pid)
    local player = Player(pid)
    if not player then
        return
    end

    if player:isInGhostMode() then
        player:setGhostMode(false)
    end
end

function onCastSpell(player, variant, isHotkey)

    if player:isInGhostMode() then
        return player:getPosition():sendMagicEffect(CONST_ME_POFF)
    end

    player:setGhostMode(true)
    addEvent(revertGhostMode, 60 * 1000, player:getId())
    return combat:execute(player, variant)
end