local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICEAREA)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -6.0, -50, -3.6, 0)

local function isInArray(array, value)
    for _, v in ipairs(array) do
        if v == value then
            return true
        end
    end
    return false
end

function onCastSpell(cid, var)
    local player = Player(cid)
    if not player then
        return false
    end

    local pos = player:getPosition()
    local targetPos = {x = pos.x, y = pos.y, z = pos.z}

    local arr = {
        {0, 1, 0},
        {1, 1, 1},
        {0, 1, 0}
    }

    for x = -1, 1 do
        for y = -1, 1 do
            targetPos.x = pos.x + x
            targetPos.y = pos.y + y
            if isInArray(arr[x + 2], y) then
                Position(targetPos):sendMagicEffect(CONST_ME_ICEAREA)
                combat:execute(player, var)
            end
        end
    end

    return true
end
