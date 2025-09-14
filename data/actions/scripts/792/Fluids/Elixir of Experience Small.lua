local function getBonus(cid)
         if getPlayerStorageValue(cid, 6629) < 0 then
            return 0
         else
            return getPlayerStorageValue(cid, 6629)
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
      if getPlayerStorageValue(cid, 6629) < 0 then
         setPlayerStorageValue(cid, 6629, 1)
      else
          setPlayerStorageValue(cid, 6629, 1+getBonus(cid))
      end
      local health = bonusvoc[getPlayerVocation(cid)].health
      local mana = bonusvoc[getPlayerVocation(cid)].mana
      setPlayerMaxHealth(cid,getPlayerMaxHealth(cid)+health)        
      setPlayerMaxMana(cid,getPlayerMaxMana(cid)+mana)
      doPlayerAddMana(cid,100000)
      doPlayerAddHealth(cid,100000)         
      doPlayerSendTextMessage(cid,20,"voce recebeu "..health.." pontos de HP e "..mana.." pontos de Mana, agora seu bônus está: "..getBonus(cid)..".")
end

local condition = createConditionObject(CONDITION_ENERGY)
setConditionParam(condition, CONDITION_PARAM_DELAYED, 1)
addDamageCondition(condition, 0, 0, 0)

function onUse(cid, item, frompos, item2, topos)
skill = getPlayerSkill(cid,0)
maglevel = getPlayerMagLevel(cid)
level = getPlayerLevel(cid)
min = ((level*220)+(skill*155)+(maglevel*100))
max = ((level*595)+(skill*310)+(maglevel*290))

exp = math.random(min,max)
bonus = getBonus(cid)

if getPlayerLevel(cid) <= 7 then
doPlayerSendTextMessage(cid,20,'Somente jogadores com nivel superior a 8 podem usar este elixir.')
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

local random = math.random(1,220)
         if random <= 1 then
            if not(getBonus(cid) >= 10) then
               addBonus(cid, bonus)
            end
          end
         end