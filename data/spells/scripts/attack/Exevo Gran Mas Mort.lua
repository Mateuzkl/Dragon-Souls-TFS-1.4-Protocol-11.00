local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 117)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -2.8, -30, -3.0, -30)

local arr = {
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
  {0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
}

local area = createCombatArea(arr)
combat:setArea(area)

function onCastSpell(cid, var)
local player = Player(cid)
  if not isPlayer(cid) then
    return false
  end

  local rand = math.random(1, 10)
  if rand == 5 then
    player:say(cid, "", TALKTYPE_MONSTER_SAY)
  elseif rand == 7 then
    player:say(cid, "", TALKTYPE_MONSTER_SAY)
  elseif rand == 9 then
    player:say(cid, "", TALKTYPE_MONSTER_SAY)
    combat:execute(cid, var)
  end
     
  return combat:execute(cid, var)
end
