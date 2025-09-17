function doPushCreature(sourcePos, targetPos)
    local tile = Tile(targetPos)
    if not tile then
        return false
    end
    
    local creature = tile:getTopCreature()
    if not creature then
        return false
    end
    
    local newpos = {x = targetPos.x, y = targetPos.y, z = targetPos.z}
    
    if targetPos.y < sourcePos.y and targetPos.x == sourcePos.x then
        newpos.y = newpos.y - 1
    elseif targetPos.y > sourcePos.y and targetPos.x == sourcePos.x then
        newpos.y = newpos.y + 1
    elseif targetPos.y == sourcePos.y and targetPos.x > sourcePos.x then
        newpos.x = newpos.x + 1
    elseif targetPos.y == sourcePos.y and targetPos.x < sourcePos.x then
        newpos.x = newpos.x - 1
    elseif targetPos.y < sourcePos.y and targetPos.x > sourcePos.x then
        newpos.x = newpos.x + 1
        newpos.y = newpos.y - 1
    elseif targetPos.y > sourcePos.y and targetPos.x < sourcePos.x then
        newpos.x = newpos.x - 1
        newpos.y = newpos.y + 1
    elseif targetPos.y > sourcePos.y and targetPos.x > sourcePos.x then
        newpos.x = newpos.x + 1
        newpos.y = newpos.y + 1
    elseif targetPos.y < sourcePos.y and targetPos.x < sourcePos.x then
        newpos.x = newpos.x - 1
        newpos.y = newpos.y - 1
    end
    
    local newTile = Tile(newpos)
    if newTile and newTile:isWalkable() then
        creature:teleportTo(newpos)
        return true
    end
    
    return false
end

local arr = {
  [1] = {
    {1,1,1},
    {1,2,1},
    {1,1,1}
  },

  [2] = {
    {0,1,1,1,0},
    {1,0,0,0,1},
    {1,0,2,0,1},
    {1,0,0,0,1},
    {0,1,1,1,0}
  },

  [3] = {
    {0,0,1,1,1,0,0},
    {0,1,0,0,0,1,0},
    {1,0,0,0,0,0,1},
    {1,0,0,2,0,0,1},
    {1,0,0,0,0,0,1},
    {0,1,0,0,0,1,0},
    {0,0,1,1,1,0,0}
  },

  [4] = {
    {0,0,0,1,1,1,0,0,0},
    {0,0,1,0,0,0,1,0,0},
    {0,1,0,0,0,0,0,1,0},
    {1,0,0,0,0,0,0,0,1},
    {1,0,0,0,2,0,0,0,1},
    {1,0,0,0,0,0,0,0,1},
    {0,1,0,0,0,0,0,1,0},
    {0,0,1,0,0,0,1,0,0},
    {0,0,0,1,1,1,0,0,0}
  }
}

function onTargetTile(creature, pos)
    doPushCreature(creature:getPosition(), pos)
end

local combat = {}
for n, v in pairs(arr) do
    combat[n] = Combat()
    combat[n]:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")
    combat[n]:setParameter(COMBAT_PARAM_EFFECT, 2)
    combat[n]:setArea(createCombatArea(v))
end

local function executeSpell(creatureId, combatObj, variant)
    local creature = Creature(creatureId)
    if creature then
        combatObj:execute(creature, variant)
    end
end

local function allowMovement(creatureId)
    local creature = Creature(creatureId)
    if creature then
        creature:setMovementBlocked(false)
    end
end

function onCastSpell(creature, variant)
    local creatureId = creature:getId()
    
    creature:setMovementBlocked(true)
    
    for i = 1, #combat do
        addEvent(executeSpell, (i-1)*150, creatureId, combat[i], variant)
        if i == #combat then
            addEvent(allowMovement, (i-1)*150, creatureId)
        end
    end
    
    return true
end
