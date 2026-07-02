local CODE_TOOLTIP = 105


local specialSkills = {
  [SKILL_CRITICAL_HIT_CHANCE] = "cc",
  [SKILL_CRITICAL_HIT_DAMAGE] = "ca",
  [SKILL_LIFE_LEECH_CHANCE] = "lc",
  [SKILL_LIFE_LEECH_AMOUNT] = "la",
  [SKILL_MANA_LEECH_CHANCE] = "mc",
  [SKILL_MANA_LEECH_AMOUNT] = "ma"
}


local skills = {
  [SKILL_FIST] = "fist",
  [SKILL_AXE] = "axe",
  [SKILL_SWORD] = "sword",
  [SKILL_CLUB] = "club",
  [SKILL_DISTANCE] = "dist",
  [SKILL_SHIELD] = "shield",
  [SKILL_FISHING] = "fish"
}


local stats = {
  [STAT_MAGICPOINTS] = "mag",
  [STAT_MAXHITPOINTS] = "maxhp",
  [STAT_MAXMANAPOINTS] = "maxmp"
}


local statsPercent = {
  [STAT_MAXHITPOINTS] = "maxhp_p",
  [STAT_MAXMANAPOINTS] = "maxmp_p"
}


local combatTypeNames = {
  [COMBAT_PHYSICALDAMAGE] = "Physical",
  [COMBAT_ENERGYDAMAGE] = "Energy",
  [COMBAT_EARTHDAMAGE] = "Earth",
  [COMBAT_FIREDAMAGE] = "Fire",
  [COMBAT_LIFEDRAIN] = "Lifedrain",
  [COMBAT_MANADRAIN] = "Manadrain",
  [COMBAT_HEALING] = "Healing",
  [COMBAT_DROWNDAMAGE] = "Drown",
  [COMBAT_ICEDAMAGE] = "Ice",
  [COMBAT_HOLYDAMAGE] = "Holy",
  [COMBAT_DEATHDAMAGE] = "Death"
}


local combatShortNames = {
  [COMBAT_PHYSICALDAMAGE] = "Inc_Phys",
  [COMBAT_ENERGYDAMAGE] = "a_ene",
  [COMBAT_EARTHDAMAGE] = "a_earth",
  [COMBAT_FIREDAMAGE] = "a_fire",
  [COMBAT_LIFEDRAIN] = "a_ldrain",
  [COMBAT_MANADRAIN] = "a_mdrain",
  [COMBAT_HEALING] = "a_heal",
  [COMBAT_DROWNDAMAGE] = "a_drown",
  [COMBAT_ICEDAMAGE] = "a_ice",
  [COMBAT_HOLYDAMAGE] = "a_holy",
  [COMBAT_DEATHDAMAGE] = "Inc_Magic"
}

local function getWeaponClassTooltip(itemType)
  if not itemType.getWeaponClass or not itemType.getWeaponClassDescription then
    return nil
  end

  local weaponClass = itemType:getWeaponClass()
  if not weaponClass then
    return nil
  end

  return {
    class = tostring(weaponClass),
    description = itemType:getWeaponClassDescription() or "",
    suitability = itemType:getWeaponClassSuitability() or "",
    powerAnalysis = itemType:getWeaponClassPowerAnalysis() or ""
  }
end


local LoginEvent = CreatureEvent("TooltipsLogin")


function LoginEvent.onLogin(player)
  player:registerEvent("TooltipsExtended")
  return true
end

local ExtendedEvent = CreatureEvent("TooltipsExtended")


function ExtendedEvent.onExtendedOpcode(player, opcode, buffer)
  if opcode == CODE_TOOLTIP then
    local status, data =
        pcall(
          function()
            return json.decode(buffer)
          end
        )
    if not status or not data then
      return
    end


    if #data == 4 then
      local pos = Position(data[1], data[2], data[3], data[4])
      local item = player:getItem(pos)
      player:sendItemTooltip(item)
    elseif #data == 1 then
      local item = Game.getRealUniqueItem(data[1])
      if item then
        player:sendItemTooltip(item)
      end
    end
  end
end

function Player:sendItemTooltip(item)
  if item then
    local item_data = item:buildTooltip()
    if item_data then
      self:sendExtendedOpcode(CODE_TOOLTIP, json.encode({ action = "new", data = item_data }))
    end
  end
end

function Item:buildTooltip()
  local uid = self:getRealUID()
  local itemType = self:getType()
  local item_data = {
    uid = uid,
    itemName = itemType:getName(),
    clientId = itemType:getClientId()
  }


  if itemType:getDescription():len() > 0 then
    item_data.desc = itemType:getDescription()
  end


  --[[if self:getType():isUpgradable() or self:getType():canHaveItemLevel() then
    item_data.itemLevel = self:getItemLevel()
  end]]


  local reqLevel = tonumber(itemType:getRequiredLevel()) or 0
  if reqLevel >= 1 then
    --if not self:isLimitless() then
    item_data.reqLvl = reqLevel
    --end
  end

  local reqReset = tonumber(itemType:getMinReqReset()) or 0
  if reqReset >= 1 then
    item_data.reqReset = reqReset
  end


  local implicit = {}


  if itemType:getElementType() ~= COMBAT_NONE and combatTypeNames[itemType:getElementType()] then
    implicit.eleDmg = "+" ..
        itemType:getElementDamage() .. " " .. combatTypeNames[itemType:getElementType()] .. " Damage"
  end


  local allprot = self:getAbsorbPercent(bit.lshift(1, 0))
  if allprot ~= 0 then
    for i = 1, COMBAT_COUNT - 1 do
      if self:getAbsorbPercent(bit.lshift(1, i)) ~= allprot then
        allprot = 0
        break
      end
    end
  end


  if allprot == 0 then
    for i = 0, COMBAT_COUNT - 1 do
      local combatType = bit.lshift(1, i)
      local absorbVal = self:getAbsorbPercent(combatType)
      if absorbVal ~= 0 and combatType ~= COMBAT_UNDEFINEDDAMAGE then
        implicit[combatShortNames[combatType]] = absorbVal
      end
    end
  else
    implicit.a_all = allprot
  end


  for key, value in pairs(specialSkills) do
    local s = itemType:getSpecialSkill(key)
    if s and s >= 1 then
      implicit[value] = s
    end
  end


  for key, value in pairs(skills) do
    local s = itemType:getSkill(key)
    if s and s >= 1 then
      implicit[value] = s
    end
  end


  for key, value in pairs(stats) do
    local s = itemType:getStat(key)
    if s and s >= 1 then
      implicit[value] = s
    end
  end


  for key, value in pairs(statsPercent) do
    local s = itemType:getStatPercent(key)
    if s and s >= 1 then
      implicit[value] = s - 100
    end
  end


  --------------------------
  local BoostPercent = itemType:getBoostPercent(0)


  if BoostPercent ~= 0 then
    for i = 0, COMBAT_COUNT - 1 do
      if itemType:getBoostPercent(i) ~= BoostPercent then
        BoostPercent = 0
        break
      end
    end
  end


  if BoostPercent == 0 then
    for i = 0, COMBAT_COUNT - 1 do
      if itemType:getBoostPercent(i) ~= 0 then
        local combatType = bit.lshift(1, i)
        if combatType ~= COMBAT_UNDEFINEDDAMAGE then
          local shortName = combatShortNames[combatType]
          if shortName == "Inc_Phys" then
            implicit.Inc_Phys = itemType:getBoostPercent(i)
          elseif shortName == "Inc_Magic" then
            implicit.Inc_Magic = itemType:getBoostPercent(i)
          end
        end
      end
    end
  else
    implicit.BoostPercent = BoostPercent
  end



  local healthGain = itemType:getHealthGain()
  if healthGain and healthGain > 0 then
    implicit.hpgain = healthGain
  end


  --local healthTicks = itemType:getHealthTicks()
  --if healthTicks and healthTicks > 0 then
  --implicit.hpticks = healthTicks
  --end


  local manaGain = itemType:getManaGain()
  if manaGain and manaGain > 0 then
    implicit.mpgain = manaGain
  end


  --local manaTicks = itemType:getManaTicks()
  --if manaTicks and manaTicks > 0 then
  --implicit.mpticks = manaTicks
  --end


  local speed = itemType:getSpeed()
  if speed and speed > 0 then
    implicit.speed = speed
  end

  -- Dodge from items.xml (ItemType abilities + item attributes)
  local itemDodge = self:getDodge()
  if itemDodge and itemDodge > 0 then
    implicit.dodge_base = itemDodge
  end


  if self:isContainer() then
    implicit.cap = self:getCapacity()
  end


  if next(implicit) ~= nil then
    item_data.imp = implicit
  end


  -- if self:getType():isUpgradable() then
  -- if self:isUnidentified() then
  -- item_data.unidentified = true
  -- else
  -- item_data.uLevel = self:getUpgradeLevel()
  -- if self:isMirrored() then
  -- item_data.mirrored = true
  -- end
  -- if self:isUnique() then
  -- item_data.uniqueName = self:getUniqueName()
  -- end
  -- item_data.rarityId = self:getRarityId()
  -- item_data.maxAttr = self:getMaxAttributes()
  -- item_data.attr = {}
  -- for i = self:getMaxAttributes(), 1, -1 do
  -- local enchant = self:getBonusAttribute(i)
  -- if enchant then
  -- local attr = US_ENCHANTMENTS[enchant[1]]
  -- item_data.attr[i] = attr.format(enchant[2])
  -- else
  -- item_data.attr[i] = "Empty Slot"
  -- end
  -- end
  -- end
  -- end


  item_data.stackable = itemType:isStackable()
  item_data.itemType = formatItemType(itemType)

  local weaponClass = getWeaponClassTooltip(itemType)
  if weaponClass then
    item_data.weaponClass = {
      class = weaponClass.class,
      description = weaponClass.description,
      suitability = weaponClass.suitability,
      powerAnalysis = weaponClass.powerAnalysis
    }
  end

  local itemArmor = tonumber(itemType:getArmor()) or 0
  if itemArmor > 0 then
    local attrArmor = tonumber(self:getAttribute(ITEM_ATTRIBUTE_ARMOR)) or 0
    if attrArmor > 0 then
      item_data.armor = attrArmor
    else
      item_data.armor = itemArmor
    end
  elseif (tonumber(itemType:getShootRange()) or 0) > 1 then
    local attrAttack = tonumber(self:getAttribute(ITEM_ATTRIBUTE_ATTACK)) or 0
    if attrAttack > 0 then
      item_data.attack = attrAttack
    else
      item_data.attack = tonumber(itemType:getAttack()) or 0
    end
    local attrHitChance = tonumber(self:getAttribute(ITEM_ATTRIBUTE_HITCHANCE)) or 0
    if attrHitChance > 0 then
      item_data.hitChance = attrHitChance
    else
      item_data.hitChance = tonumber(itemType:getHitChance()) or 0
    end
    item_data.shootRange = tonumber(itemType:getShootRange()) or 0
  elseif (tonumber(itemType:getAttack()) or 0) > 0 then
    local attrAttack = tonumber(self:getAttribute(ITEM_ATTRIBUTE_ATTACK)) or 0
    if attrAttack > 0 then
      item_data.attack = attrAttack
    else
      item_data.attack = tonumber(itemType:getAttack()) or 0
    end
    local attrDefense = tonumber(self:getAttribute(ITEM_ATTRIBUTE_DEFENSE)) or 0
    if attrDefense > 0 then
      item_data.defense = attrDefense
    else
      item_data.defense = tonumber(itemType:getDefense()) or 0
    end
    local attrExtraDefense = tonumber(self:getAttribute(ITEM_ATTRIBUTE_EXTRADEFENSE)) or 0
    if attrExtraDefense > 0 then
      item_data.extraDefense = attrExtraDefense
    else
      item_data.extraDefense = tonumber(itemType:getExtraDefense()) or 0
    end
  elseif (tonumber(itemType:getDefense()) or 0) > 0 then
    local attrDefense = tonumber(self:getAttribute(ITEM_ATTRIBUTE_DEFENSE)) or 0
    if attrDefense > 0 then
      item_data.defense = attrDefense
    else
      item_data.defense = tonumber(itemType:getDefense()) or 0
    end
    local attrExtraDefense = tonumber(self:getAttribute(ITEM_ATTRIBUTE_EXTRADEFENSE)) or 0
    if attrExtraDefense > 0 then
      item_data.extraDefense = attrExtraDefense
    else
      item_data.extraDefense = tonumber(itemType:getExtraDefense()) or 0
    end
  end


  local duration = tonumber(self:getRemainingDuration()) or 0
  if duration > 0 then
    item_data.duration = duration
  end


  local charges = tonumber(self:getCharges()) or 0
  if charges > 0 then
    item_data.charges = charges
  end


  -- Tier & Classification
  local itemType = self:getType()
  
  if self:hasAttribute(ITEM_ATTRIBUTE_TIER) then
    item_data.tier = tonumber(self:getAttribute(ITEM_ATTRIBUTE_TIER)) or 0
  elseif itemType:getTier() and itemType:getTier() > 0 then
    item_data.tier = itemType:getTier()
  end
  
  if self:hasAttribute(ITEM_ATTRIBUTE_CLASSIFICATION) then
    item_data.classification = tonumber(self:getAttribute(ITEM_ATTRIBUTE_CLASSIFICATION)) or 0
  elseif itemType:getClassification() and itemType:getClassification() > 0 then
    item_data.classification = itemType:getClassification()
  end


  -- Imbuements
  local slots = itemType:getImbuingSlots()
  if slots and slots > 0 then
    item_data.imbuingSlots = slots
    item_data.imbuements = {}
    for i = 1, slots do
      local imbuement = self:getImbuement(i - 1)
      if imbuement then
        local base = imbuement:getBase()
        local tierName = ""
        if base then
          if base.id == 1 then
            tierName = " (Basic)"
          elseif base.id == 2 then
            tierName = " (Intricate)"
          elseif base.id == 3 then
            tierName = " (Powerful)"
          end
        end
        table.insert(item_data.imbuements, imbuement:getName() .. tierName)
      else
        table.insert(item_data.imbuements, 0) -- Empty
      end
    end
  end


  -- Reflect
  local hasReflect = false
  local reflectData = {}
  local combatTypes = {
    { type = COMBAT_PHYSICALDAMAGE, name = "Physical" },
    { type = COMBAT_FIREDAMAGE,     name = "Fire" },
    { type = COMBAT_EARTHDAMAGE,    name = "Earth" },
    { type = COMBAT_ENERGYDAMAGE,   name = "Energy" },
    { type = COMBAT_ICEDAMAGE,      name = "Ice" },
    { type = COMBAT_HOLYDAMAGE,     name = "Holy" },
    { type = COMBAT_DEATHDAMAGE,    name = "Death" }
  }


  for _, combat in ipairs(combatTypes) do
    local reflect = self:getReflect(combat.type)
    if reflect and tonumber(reflect.percent) and tonumber(reflect.percent) > 0 then
      table.insert(reflectData, { name = combat.name, percent = reflect.percent, chance = reflect.chance })
      hasReflect = true
    end
  end
  if hasReflect then
    item_data.reflect = reflectData
  end


  -- Tier System Abilities
  local itemTier = tonumber(item_data.tier) or 0
  if itemTier > 0 then
    dofile('data/lib/core/tier_ability_config.lua')
    local itemType = ItemType(self:getId())
    local slotPosition = itemType:getSlotPosition()
    
    local slotName = nil
    if bit.band(slotPosition, 1) ~= 0 or bit.band(slotPosition, 2) ~= 0 then -- HAND (LEFT or RIGHT)
      local attack = itemType:getAttack()
      if attack > 0 then
        slotName = "hand"
      end
    elseif bit.band(slotPosition, 4) ~= 0 then -- NECKLACE
      slotName = "necklace"
    elseif bit.band(slotPosition, 8) ~= 0 then -- ARMOR
      slotName = "armor"
    elseif bit.band(slotPosition, 16) ~= 0 then -- HEAD
      slotName = "head"
    elseif bit.band(slotPosition, 32) ~= 0 then -- LEGS
      slotName = "legs"
    elseif bit.band(slotPosition, 64) ~= 0 then -- FEET
      slotName = "feet"
    end
    
    if slotName and TierSystem and TierSystem.abilityConfig and TierSystem.abilityConfig[slotName] then
      local ability = TierSystem.abilityConfig[slotName]
      local chance = ability.activationChances and ability.activationChances[itemTier]
      local dropBoost = ability.dropBoost and ability.dropBoost[itemTier]
      
      item_data.tierAbility = {
        name = ability.name,
        description = ability.description,
        chance = chance,
        dropBoost = dropBoost
      }
    end
  end


  item_data.weight = self:getWeight()
  return item_data
end

function ItemType:buildTooltip(count)
  if not count then
    count = 1
  end


  local item_data = {
    clientId = self:getClientId(),
    count = count,
    itemName = self:getName()
  }


  if self:getDescription():len() > 0 then
    item_data.desc = self:getDescription()
  end


  local reqLevel = tonumber(self:getRequiredLevel()) or 0
  if reqLevel >= 1 then
    item_data.reqLvl = reqLevel
  end

  local reqReset = tonumber(self:getMinReqReset()) or 0
  if reqReset >= 1 then
    item_data.reqReset = reqReset
  end


  local implicit = {}


  if self:getElementType() ~= COMBAT_NONE and combatTypeNames[self:getElementType()] then
    implicit.eleDmg = "Attack +" .. self:getElementDamage() .. " " .. combatTypeNames[self:getElementType()]
  end


  local allprot = self:getAbsorbPercent(0)


  if allprot ~= 0 then
    for i = 0, COMBAT_COUNT - 1 do
      if self:getAbsorbPercent(i) ~= allprot then
        allprot = 0
        break
      end
    end
  end


  if allprot == 0 then
    for i = 0, COMBAT_COUNT - 1 do
      if self:getAbsorbPercent(i) ~= 0 then
        local combatType = bit.lshift(1, i)
        if combatType ~= COMBAT_UNDEFINEDDAMAGE then
          implicit[combatShortNames[combatType]] = self:getAbsorbPercent(i)
        end
      end
    end
  else
    implicit.a_all = allprot
  end


  for key, value in pairs(specialSkills) do
    local s = self:getSpecialSkill(key)
    if s and s >= 1 then
      implicit[value] = s
    end
  end


  for key, value in pairs(skills) do
    local s = self:getSkill(key)
    if s and s >= 1 then
      implicit[value] = s
    end
  end


  for key, value in pairs(stats) do
    local s = self:getStat(key)
    if s and s >= 1 then
      implicit[value] = s
    end
  end


  for key, value in pairs(statsPercent) do
    local s = self:getStatPercent(key)
    if s and s >= 1 then
      implicit[value] = s - 100
    end
  end


  local healthGain = self:getHealthGain()
  if healthGain and healthGain > 0 then
    implicit.hpgain = healthGain
  end


  --local healthTicks = self:getHealthTicks()
  --if healthTicks and healthTicks > 0 then
  --implicit.hpticks = healthTicks
  --end


  local manaGain = self:getManaGain()
  if manaGain and manaGain > 0 then
    implicit.mpgain = manaGain
  end


  --local manaTicks = self:getManaTicks()
  --if manaTicks and manaTicks > 0 then
  --implicit.mpticks = manaTicks
  --end


  local speed = self:getSpeed()
  if speed and speed > 0 then
    implicit.speed = speed
  end


  if self:isContainer() then
    implicit.cap = "Capacity " .. self:getCapacity()
  end


  if next(implicit) ~= nil then
    item_data.imp = implicit
  end


  item_data.itemType = formatItemType(self)

  local weaponClass = getWeaponClassTooltip(self)
  if weaponClass then
    item_data.weaponClass = {
      class = weaponClass.class,
      description = weaponClass.description,
      suitability = weaponClass.suitability,
      powerAnalysis = weaponClass.powerAnalysis
    }
  end

  local itemArmor = tonumber(self:getArmor()) or 0
  if itemArmor > 0 then
    item_data.armor = itemArmor
  elseif (tonumber(self:getShootRange()) or 0) > 1 then
    item_data.attack = tonumber(self:getAttack()) or 0
    item_data.hitChance = tonumber(self:getHitChance()) or 0
    item_data.shootRange = tonumber(self:getShootRange()) or 0
  elseif (tonumber(self:getAttack()) or 0) > 0 then
    item_data.attack = tonumber(self:getAttack()) or 0
    item_data.defense = tonumber(self:getDefense()) or 0
    item_data.extraDefense = tonumber(self:getExtraDefense()) or 0
  elseif (tonumber(self:getDefense()) or 0) > 0 then
    item_data.defense = tonumber(self:getDefense()) or 0
    item_data.extraDefense = tonumber(self:getExtraDefense()) or 0
  end


  local charges = tonumber(self:getCharges()) or 0
  if charges > 0 then
    item_data.charges = charges
  end


  item_data.weight = self:getWeight() * item_data.count
  return item_data
end

function formatItemType(itemType)
  local weaponType = itemType:getWeaponType()


  if weaponType ~= WEAPON_SHIELD then
    local slotPosition = itemType:getSlotPosition() - SLOTP_LEFT - SLOTP_RIGHT


    if slotPosition == SLOTP_TWO_HAND and weaponType == WEAPON_SWORD then
      return "Two-Handed Sword"
    elseif slotPosition == SLOTP_TWO_HAND and weaponType == WEAPON_CLUB then
      return "Two-Handed Club"
    elseif slotPosition == SLOTP_TWO_HAND and weaponType == WEAPON_AXE then
      return "Two-Handed Axe"
    elseif weaponType == WEAPON_SWORD then
      return "Sword"
    elseif weaponType == WEAPON_CLUB then
      return "Club"
    elseif weaponType == WEAPON_AXE then
      return "Axe"
    elseif weaponType == WEAPON_DISTANCE then
      return "Distance"
    elseif weaponType == WEAPON_WAND then
      return "Wand"
    elseif slotPosition == SLOTP_HEAD then
      return "Helmet"
    elseif slotPosition == SLOTP_NECKLACE then
      return "Necklace"
    elseif slotPosition == SLOTP_ARMOR then
      return "Armor"
    elseif slotPosition == SLOTP_LEGS then
      return "Legs"
    elseif slotPosition == SLOTP_FEET then
      return "Boots"
    elseif slotPosition == SLOTP_RING then
      return "Ring"
    elseif slotPosition == SLOTP_AMMO and itemType:getAmmoType() > 0 then
      return "Ammunition"
    elseif itemType:isRune() then
      return "Rune"
    elseif itemType:isContainer() then
      return "Container"
    elseif itemType:isFluidContainer() then
      return "Potion"
    elseif itemType:isUseable() then
      return "Usable"
    end
  else
    return "Shield"
  end


  return "Common"
end

LoginEvent:type("login")
LoginEvent:register()
ExtendedEvent:type("extendedopcode")
ExtendedEvent:register()
