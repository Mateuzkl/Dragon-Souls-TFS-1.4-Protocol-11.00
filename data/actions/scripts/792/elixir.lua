local function getBonus(cid)
         if getPlayerStorageValue(cid, 6621) < 0 then
            return 0
         else
            return getPlayerStorageValue(cid, 6621)
         end
end

local function addBonus(cid, number)
      local bonusvoc = {
      [9] = {health = 20, mana = 120},
      [10] = {health = 20, mana = 120},
      [11] = {health = 40, mana = 60},
      [12] = {health = 60, mana = 20},
      [13] = {health = 30, mana = 180},
      [14] = {health = 30, mana = 180},
      [15] = {health = 60, mana = 90},
      [16] = {health = 90, mana = 30}
      }
      if getPlayerStorageValue(cid, 6621) < 0 then
         setPlayerStorageValue(cid, 6621, 1)
      else
          setPlayerStorageValue(cid, 6621, 1+getBonus(cid))
      end
      local health = bonusvoc[getPlayerVocation(cid)].health
      local mana = bonusvoc[getPlayerVocation(cid)].mana
      setPlayerMaxHealth(cid,getPlayerMaxHealth(cid)+health)        
      setPlayerMaxMana(cid,getPlayerMaxMana(cid)+mana)
      doPlayerAddMana(cid,100000)
      doPlayerAddHealth(cid,100000)         doPlayerSendTextMessage(cid,20,"voce recebeu "..health.." pontos de HP e "..mana.." pontos de Mana, agora seu bônus está: "..getBonus(cid)..".")
end

local condition = createConditionObject(CONDITION_ENERGY)
setConditionParam(condition, CONDITION_PARAM_DELAYED, 1)
addDamageCondition(condition, 0, 0, 0)

function onUse(cid, item, frompos, item2, topos)
skill = getPlayerSkill(cid,0)
maglevel = getPlayerMagLevel(cid)
level = getPlayerLevel(cid)
min = ((level*3520)+(skill*1285)+(maglevel*1650))
max = ((level*4895)+(skill*1870)+(maglevel*2090))

exp = math.random(min,max)
bonus = getBonus(cid)

if getPlayerLevel(cid) <= 149 then
doPlayerSendTextMessage(cid,20,'Somente jogadores com nivel superior a 150 podem usar este elixir.')
return TRUE
end

if getPlayerSoul(cid) <= 249 then
doPlayerSendTextMessage(cid,20,'Voce não tem Souls suficiente.')
return TRUE
end

doPlayerAddExp(cid,exp)
doTargetCombatCondition(0, cid, condition, CONST_ME_MAGIC_RED)
doPlayerSendTextMessage(cid,20,'voce recebeu ' .. exp .. ' pontos de experiência. Bônus: ' .. bonus .. '.')
doSendAnimatedText(getPlayerPosition(cid),exp, 179)
doRemoveItem(item.uid,1)
doPlayerAddSoul(cid,-250)

local random = math.random(1,100)
         if random <= 5 then
            if not(getBonus(cid) >= 10) then
               addBonus(cid, bonus)
            end
          end
         end