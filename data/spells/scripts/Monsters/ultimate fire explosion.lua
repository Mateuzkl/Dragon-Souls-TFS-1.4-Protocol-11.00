local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -2.2, -30, -3.0, -30)

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
  local rand = math.random(1, 50)
  if rand == 1 and isPlayer(cid) then
    doCreatureSay(cid, "Come on! I got more for you!", TALKTYPE_MONSTER_SAY)
  elseif rand == 2 and isPlayer(cid) then
    doCreatureSay(cid, "Feel the power of darkness!", TALKTYPE_MONSTER_SAY)
  elseif rand == 3 and isPlayer(cid) then
    doCreatureSay(cid, "You can't run from your death!", TALKTYPE_MONSTER_SAY)
  elseif rand == 4 and isPlayer(cid) then
    doCreatureSay(cid, "FLAME OF HELL!!!", TALKTYPE_MONSTER_SAY)
  end
  return combat:execute(cid, var)
end
