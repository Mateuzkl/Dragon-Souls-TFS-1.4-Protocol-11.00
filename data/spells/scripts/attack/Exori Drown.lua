local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 26)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, 0, -4500, 0, -4500)

local matrix = {
  {0, 0, 1, 0, 0},
  {0, 1, 1, 1, 0},
  {1, 1, 2, 1, 1},
  {0, 1, 1, 1, 0},
  {0, 0, 1, 0, 0}
}

local combatArea = createCombatArea(matrix)
combat:setArea(combatArea)

function onCastSpell(cid, var)
  return combat:execute(cid, var)
end

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, 26)
combat2:setFormula(COMBAT_FORMULA_LEVELMAGIC, 0, -15000, 0, -15000)

local condition = Condition(CONDITION_DROWN)
condition:setParameter(CONDITION_PARAM_DELAYED, 15)
condition:addDamage(2500, 10, -4000)
combat2:addCondition(condition)

local matrix2 = {
  {0, 0, 1, 0, 0},
  {0, 1, 1, 1, 0},
  {1, 1, 2, 1, 1},
  {0, 1, 1, 1, 0},
  {0, 0, 1, 0, 0}
}

local combatArea2 = createCombatArea(matrix2)
combat2:setArea(combatArea2)

function onCastSpell(cid, var)
    local player = Player(cid)  -- Defina a variável player aqui
    local rand = math.random(97, 100)
    
    if rand == 97 then
        Game.sendAnimatedText("waterfull power", player:getPosition(), 35)
        player:say("The Just!", TALKTYPE_MONSTER_SAY)
        Game.sendAnimatedText("FATAL!", player:getPosition(), 108)
        return combat2:execute(cid, var)
    else
        return combat:execute(cid, var)
    end
end

