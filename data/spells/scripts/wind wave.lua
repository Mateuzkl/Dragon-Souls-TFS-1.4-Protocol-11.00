--// Requerimento para compatibilidade com as novas versões de OTServer \\
local mayNotMove = doCreatureSetNoMove

function doPushCreature(pos, target)
    creature = getThingfromPos({x=target.x, y=target.y, z=target.z, stackpos=253}).uid
    if target.y < pos.y and target.x == pos.x then
        newpos = {x=target.x, y=target.y-1, z=target.z}
    elseif target.y > pos.y and target.x == pos.x then
        newpos = {x=target.x, y=target.y+1, z=target.z}
    elseif target.y == pos.y and target.x > pos.x then
        newpos = {x=target.x+1, y=target.y, z=target.z}
    elseif target.y == pos.y and target.x < pos.x then
        newpos = {x=target.x-1, y=target.y, z=target.z}
    elseif target.y < pos.y and target.x > pos.x then
        newpos = {x=target.x+1, y=target.y-1, z=target.z}
    elseif target.y > pos.y and target.x < pos.x then
        newpos = {x=target.x-1, y=target.y+1, z=target.z}
    elseif target.y > pos.y and target.x > pos.x then
        newpos = {x=target.x+1, y=target.y+1, z=target.z}
    elseif target.y < pos.y and target.x < pos.x then
        newpos = {x=target.x-1, y=target.y-1, z=target.z}
    end
    if creature > 0 then
        if queryTileAddThing(creature, newpos) == TRUE then
            doTeleportThing(creature, newpos, TRUE)
        end
    end
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

function onTargetCreature(cid, target)
    doPushCreature(getCreaturePosition(cid), target)
end

combat = {}
for n, v in pairs(arr) do
    combat[n] = createCombatObject()
    _G["callback"..n] = onTargetCreature
    setCombatCallback(combat[n], CALLBACK_PARAM_TARGETTILE, "callback"..n)
    setCombatParam(combat[n], COMBAT_PARAM_EFFECT, 2)
    setCombatArea(combat[n], createCombatArea(v))
end

function onCastSpell(cid, var)
if getPlayerStorageValue(cid, 10569) == 1 then
doSendAnimatedText((getCreaturePosition(cid)), "Silince!", 255)
doSendMagicEffect(getCreaturePosition(cid), 110)
doPlayerSendDefaultCancel(cid, RETURNVALUE_YOUAREEXHAUSTED)
return false 
end
    mayNotMove(cid, TRUE)
    for i = 1, #combat do
        addEvent(doCombat, i*150-150, cid, combat[i], var)
        if i == #combat then
            addEvent(mayNotMove, i*150-150, cid, FALSE)
        end
    end
end  