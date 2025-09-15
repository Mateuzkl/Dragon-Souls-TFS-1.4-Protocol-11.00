local combat = Combat()
local fieldItems = {1487, 1488, 1489, 1490, 1491, 1492, 1493, 1494, 1495, 1496, 1500, 1501, 1502, 1503, 1504, 5061, 5062, 5063, 5064, 5065, 5066, 5067}

function onTargetTile(creature, position)
    local tile = Tile(position)
    if tile then
        local item = tile:getItemByTopOrder(1)
        if item and table.contains(fieldItems, item:getId()) then
            item:remove()
        end
    end
    position:sendMagicEffect(CONST_ME_POFF)
end

combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

function onCastSpell(creature, variant)
    return combat:execute(creature, variant)
end
