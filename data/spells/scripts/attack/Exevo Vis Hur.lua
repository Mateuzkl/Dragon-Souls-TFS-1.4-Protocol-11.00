local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -5.4, -50, -3.7, 0)

local area = createCombatArea({
  {1, 1, 1},
  {1, 1, 1},
  {1, 1, 1},
  {0, 1, 0},
  {0, 3, 0}
}, {
  {1, 1, 1, 0, 0},
  {1, 1, 0, 0, 0},
  {1, 0, 1, 0, 0},
  {0, 0, 0, 1, 0},
  {0, 0, 0, 0, 3}
})
combat:setArea(area)

function onCastSpell(cid, var)
    local player = Player(cid)
    local target = player:getTarget()
    local pos = player:getPosition()

    if player:getStorageValue(10569) == 1 then
        Game.sendAnimatedText("Silence!", target:getPosition(), 215)
        pos:sendMagicEffect(CONST_ME_MAGIC_RED)
        player:sendCancelMessage(RETURNVALUE_YOUAREEXHAUSTED)
        return false
    end

    return combat:execute(player, var)
end
