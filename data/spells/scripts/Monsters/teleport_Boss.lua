local playerPositions = {}

function onCastSpell(cid, variant)
    local monster = Creature(cid)
   
    local closeSpec = Game.getSpectators(monster:getPosition(), false, true, 2, 2, 2, 2)
    for i = 1, #closeSpec do
        if closeSpec[i] ~= nil then
            return false
        end
    end
   
    local specs = Game.getSpectators(Position(monster:getPosition()), false, true, 20, 20, 20, 20)
    for i = 1, #specs do
        local spectator = specs[i]
        playerPositions[#playerPositions + 1] = spectator:getPosition()
    end
   
    local randomPos = playerPositions[math.random(#playerPositions)]
    local freePos = getFreeTile(randomPos)
   
    if freePos then
        monster:getPosition():sendMagicEffect(CONST_ME_POFF)
        monster:teleportTo(freePos)
        monster:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        monster:say('BUU!!', TALKTYPE_MONSTER_SAY)
    end
   
    return false
end

function getFreeTile(positions)
    local checkTiles = {
        -- 1, 2, 3
        -- 4, 0, 5 -- 0 is player
        -- 6, 7, 8
        Position(positions.x + 1, positions.y, positions.z), -- 5
        Position(positions.x - 1, positions.y, positions.z), -- 4
        Position(positions.x, positions.y + 1, positions.z), -- 7
        Position(positions.x, positions.y - 1, positions.z), -- 2
        Position(positions.x + 1, positions.y - 1, positions.z), -- 3
        Position(positions.x + 1, positions.y + 1, positions.z), -- 8
        Position(positions.x - 1, positions.y - 1, positions.z), -- 1
        Position(positions.x - 1, positions.y + 1, positions.z) -- 6
    }
   
    local freePosition
    for i = 1, #checkTiles do
        if Tile(checkTiles[i]):getGround() and not Tile(checkTiles[i]):getItemById(1387) and not Tile(checkTiles[i]):getItemById(5070) then
            freePosition = checkTiles[i]
            return freePosition
        else
            return false
        end
    end
end