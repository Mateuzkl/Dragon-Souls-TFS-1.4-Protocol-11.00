local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -8.2, -440, -15.3, 500)

local arr = {
  {1, 1, 1},
  {1, 2, 1},
  {1, 1, 1}
}

local area = createCombatArea(arr)
combat:setArea(area)

function onCastSpell(cid, var)
  if getPlayerStorageValue(cid, 10569) == 1 then
    doSendAnimatedText(getCreaturePosition(cid), "Socorro!", COLOR_WHITE)
    doSendMagicEffect(getCreaturePosition(cid), CONST_ME_POFF)
    doPlayerSendDefaultCancel(cid, RETURNVALUE_YOUAREEXHAUSTED)
    return false
  end
  doCreatureSay(cid, "Exori!", TALKTYPE_MONSTER_SAY)
  return combat:execute(cid, var)
end
