--[[SevuEntertainment(c)]]--
local recAnimateText = false
local startSeconds = 20

local combat = Combat()
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)
combat:setParameter(COMBAT_PARAM_CREATEITEM, ITEM_MAGICWALL)

mwCountDownStart = function(position, seconds)
    local spectators = Game.getSpectators(position, false, true, 7, 7, 7, 7)
    if #spectators > 0 then
        for _, spectator in ipairs(spectators) do
            local animatedText = tostring(seconds)
            Game.sendAnimatedText(animatedText, position, 180)
        end
    end
    if seconds > 0 then
        addEvent(mwCountDownStart, 1000, position, seconds - 1)
    end
end
function onCastSpell(creature, variant, isHotkey)
    if combat:execute(creature, variant) then
        mwCountDownStart(Variant.getPosition(variant), startSeconds)
        return true
    end
    return false
end