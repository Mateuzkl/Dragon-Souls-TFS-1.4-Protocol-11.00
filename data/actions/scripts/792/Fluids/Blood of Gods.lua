local function Blood15(cid)
if isPlayer(cid) == TRUE then
doPlayerAddHealth(cid,(12*getPlayerMaxHealth(cid)/100)+(skill*6)+(magic*2))
doPlayerAddMana(cid,(12*getPlayerMaxMana(cid)/100)+(skill*6)+(magic*2))
doSendMagicEffect(getCreaturePosition(cid), 51)
end
end

local function Blood14(cid)
if isPlayer(cid) == TRUE then
doPlayerAddHealth(cid,(12*getPlayerMaxHealth(cid)/100)+(skill*6)+(magic*2))
doPlayerAddMana(cid,(12*getPlayerMaxMana(cid)/100)+(skill*6)+(magic*2))
doSendMagicEffect(getCreaturePosition(cid), 51)
addEvent(Blood15, 1 * 2000, cid)
end
end

local function Blood13(cid)
if isPlayer(cid) == TRUE then
doPlayerAddHealth(cid,(12*getPlayerMaxHealth(cid)/100)+(skill*6)+(magic*2))
doPlayerAddMana(cid,(12*getPlayerMaxMana(cid)/100)+(skill*6)+(magic*2))
doSendMagicEffect(getCreaturePosition(cid), 51)
addEvent(Blood14, 1 * 2000, cid)
end
end

local function Blood12(cid)
if isPlayer(cid) == TRUE then
doPlayerAddHealth(cid,(12*getPlayerMaxHealth(cid)/100)+(skill*6)+(magic*2))
doPlayerAddMana(cid,(12*getPlayerMaxMana(cid)/100)+(skill*6)+(magic*2))
doSendMagicEffect(getCreaturePosition(cid), 51)
addEvent(Blood13, 1 * 2000, cid)
end
end

local function Blood11(cid)
if isPlayer(cid) == TRUE then
doPlayerAddHealth(cid,(12*getPlayerMaxHealth(cid)/100)+(skill*6)+(magic*2))
doPlayerAddMana(cid,(12*getPlayerMaxMana(cid)/100)+(skill*6)+(magic*2))
doSendMagicEffect(getCreaturePosition(cid), 51)
addEvent(Blood12, 1 * 2000, cid)
end
end

local function Blood10(cid)
if isPlayer(cid) == TRUE then
doPlayerAddHealth(cid,(12*getPlayerMaxHealth(cid)/100)+(skill*6)+(magic*2))
doPlayerAddMana(cid,(12*getPlayerMaxMana(cid)/100)+(skill*6)+(magic*2))
doSendMagicEffect(getCreaturePosition(cid), 51)
addEvent(Blood11, 1 * 2000, cid)
end
end

local function Blood9(cid)
if isPlayer(cid) == TRUE then
doPlayerAddHealth(cid,(12*getPlayerMaxHealth(cid)/100)+(skill*6)+(magic*2))
doPlayerAddMana(cid,(12*getPlayerMaxMana(cid)/100)+(skill*6)+(magic*2))
doSendMagicEffect(getCreaturePosition(cid), 51)
addEvent(Blood10, 1 * 2000, cid)
end
end

local function Blood8(cid)
if isPlayer(cid) == TRUE then
doPlayerAddHealth(cid,(12*getPlayerMaxHealth(cid)/100)+(skill*6)+(magic*2))
doPlayerAddMana(cid,(12*getPlayerMaxMana(cid)/100)+(skill*6)+(magic*2))
doSendMagicEffect(getCreaturePosition(cid), 51)
addEvent(Blood9, 1 * 2000, cid)
end
end

local function Blood7(cid)
if isPlayer(cid) == TRUE then
doPlayerAddHealth(cid,(12*getPlayerMaxHealth(cid)/100)+(skill*6)+(magic*2))
doPlayerAddMana(cid,(12*getPlayerMaxMana(cid)/100)+(skill*6)+(magic*2))
doSendMagicEffect(getCreaturePosition(cid), 51)
addEvent(Blood8, 1 * 2000, cid)
end
end

local function Blood6(cid)
if isPlayer(cid) == TRUE then
doPlayerAddHealth(cid,(12*getPlayerMaxHealth(cid)/100)+(skill*6)+(magic*2))
doPlayerAddMana(cid,(12*getPlayerMaxMana(cid)/100)+(skill*6)+(magic*2))
doSendMagicEffect(getCreaturePosition(cid), 51)
addEvent(Blood7, 1 * 2000, cid)
end
end

local function Blood5(cid)
if isPlayer(cid) == TRUE then
doPlayerAddHealth(cid,(12*getPlayerMaxHealth(cid)/100)+(skill*6)+(magic*2))
doPlayerAddMana(cid,(12*getPlayerMaxMana(cid)/100)+(skill*6)+(magic*2))
doSendMagicEffect(getCreaturePosition(cid), 51)
addEvent(Blood6, 1 * 2000, cid)
end
end

local function Blood4(cid)
if isPlayer(cid) == TRUE then
doPlayerAddHealth(cid,(12*getPlayerMaxHealth(cid)/100)+(skill*6)+(magic*2))
doPlayerAddMana(cid,(12*getPlayerMaxMana(cid)/100)+(skill*6)+(magic*2))
doSendMagicEffect(getCreaturePosition(cid), 51)
addEvent(Blood5, 1 * 2000, cid)
end
end

local function Blood3(cid)
if isPlayer(cid) == TRUE then
doPlayerAddHealth(cid,(12*getPlayerMaxHealth(cid)/100)+(skill*6)+(magic*2))
doPlayerAddMana(cid,(12*getPlayerMaxMana(cid)/100)+(skill*6)+(magic*2))
doSendMagicEffect(getCreaturePosition(cid), 51)
addEvent(Blood4, 1 * 2000, cid)
end
end

local function Blood2(cid)
if isPlayer(cid) == TRUE then
doPlayerAddHealth(cid,(12*getPlayerMaxHealth(cid)/100)+(skill*6)+(magic*2))
doPlayerAddMana(cid,(12*getPlayerMaxMana(cid)/100)+(skill*6)+(magic*2))
doSendMagicEffect(getCreaturePosition(cid), 51)
addEvent(Blood3, 1 * 2000, cid)
end
end

local function Blood1(cid)
if isPlayer(cid) == TRUE then
doSendMagicEffect(getCreaturePosition(cid), 51)
addEvent(Blood2, 1 * 2000, cid)
end
end

local Speed = createConditionObject(CONDITION_HASTE)
setConditionParam(Speed, CONDITION_PARAM_TICKS, 30000)
setConditionFormula(Speed, 0, 6000, 0, 6000)

function onUse(cid, item, frompos, item2, topos)

chronos = { lookType = 251,lookHead = getCreatureOutfit(cid).lookHead, lookBody = getCreatureOutfit(cid).lookBody, lookLegs = getCreatureOutfit(cid).lookLegs, lookFeet = getCreatureOutfit(cid).lookFeet, lookAddons = getCreatureOutfit(cid).lookAddons } 
hazus = { lookType = 194,lookHead = getCreatureOutfit(cid).lookHead, lookBody = getCreatureOutfit(cid).lookBody, lookLegs = getCreatureOutfit(cid).lookLegs, lookFeet = getCreatureOutfit(cid).lookFeet, lookAddons = getCreatureOutfit(cid).lookAddons } 
kazard = { lookType = 262,lookHead = getCreatureOutfit(cid).lookHead, lookBody = getCreatureOutfit(cid).lookBody, lookLegs = getCreatureOutfit(cid).lookLegs, lookFeet = getCreatureOutfit(cid).lookFeet, lookAddons = getCreatureOutfit(cid).lookAddons } 
skill = getPlayerSkill(cid,0)
magic = getPlayerMagLevel(cid)
Blood = math.random(1,3)

-- Exhausted Settings --
local exhausted_seconds = 30 -- Segundos que o blood vai demorar para usar denovo
local exhausted_storagevalue = 4850 -- Storage Value do exhausted

local exhausted_seconds2 = 1 -- How many seconds 
local exhausted_storagevalue2 = 9893 -- Storage Value 

local exhausted_seconds3 = 2 -- How many seconds 
local exhausted_storagevalue3 = 8162 -- Storage Value 

local exhausted_seconds4 = 1 -- How many seconds 
local exhausted_storagevalue4 = 6245 -- Storage Value 

local exhausted_seconds5 = 15 -- How many seconds 
local exhausted_storagevalue5 = 15555 -- Storage Value 

-- Exhausted Settings END --

if getPlayerSoul(cid) <= 49 then
doPlayerSendTextMessage(cid,20,'Desculpe, você não tem Souls suficiente.')
return TRUE
end

if(os.time() < getPlayerStorageValue(cid, exhausted_storagevalue)) then
doPlayerSendTextMessage(cid,20,'Você não pode usar um blood of gods durante o efeito de outro.')
return TRUE
end

if(os.time() < getPlayerStorageValue(cid, exhausted_storagevalue2)) then
 doPlayerSendCancel(cid,"Você está muito cansado.")
return TRUE
end

if(os.time() < getPlayerStorageValue(cid, exhausted_storagevalue3)) then
doPlayerSendCancel(cid,"Você está muito cansado.")
return TRUE
end

if(os.time() < getPlayerStorageValue(cid, exhausted_storagevalue4)) then
doPlayerSendCancel(cid,"Está esgotado.")
return TRUE
end

if(os.time() < getPlayerStorageValue(cid, exhausted_storagevalue5)) then
doPlayerSendCancel(cid,"Você está muito cansado.")
return TRUE
end

if Blood == 1 and (os.time() >= getPlayerStorageValue(cid, exhausted_storagevalue)) and (os.time() >= getPlayerStorageValue(cid, exhausted_storagevalue2)) and (os.time() >= getPlayerStorageValue(cid, exhausted_storagevalue3)) and (os.time() >= getPlayerStorageValue(cid, exhausted_storagevalue4)) then
doPlayerAddHealth(cid,15*getPlayerMaxHealth(cid)/100)
doPlayerAddMana(cid,15*getPlayerMaxHealth(cid)/100)
doSetCreatureOutfit(cid, chronos, 30000)
doSendMagicEffect(getCreaturePosition(cid), 12)
doPlayerSendTextMessage(cid,20,"você usou concentrated demoniac blood e se transformou em um Chronos. (Revitalization Ativado)")
doPlayerSay(cid, "Grr! Chronos back!", TALKTYPE_ORANGE_1)
addEvent(Blood1, 1*2000,cid)
setPlayerStorageValue(cid, exhausted_storagevalue, os.time() + exhausted_seconds)
doPlayerAddSoul(cid,-50)
doRemoveItem(item.uid,1)

elseif Blood == 2 and (os.time() >= getPlayerStorageValue(cid, exhausted_storagevalue)) and (os.time() >= getPlayerStorageValue(cid, exhausted_storagevalue2)) and (os.time() >= getPlayerStorageValue(cid, exhausted_storagevalue3)) and (os.time() >= getPlayerStorageValue(cid, exhausted_storagevalue4)) then
doPlayerAddHealth(cid,10*getPlayerMaxHealth(cid)/100)
doPlayerAddMana(cid,10*getPlayerMaxHealth(cid)/100)
doSetCreatureOutfit(cid, kazard, 30000)
doTargetCombatCondition(0, cid, Speed, 51)
doSendMagicEffect(getCreaturePosition(cid), 12)
doPlayerSay(cid, "Nhe hehe!", TALKTYPE_ORANGE_1)
doPlayerSendTextMessage(cid,20,"Você usou um concentrated demoniac blood e se transformou em um Kazard. (Full Haste Ativado)")
addEvent(Blood1, 1*2000,cid)
setPlayerStorageValue(cid, exhausted_storagevalue, os.time() + exhausted_seconds)
doPlayerAddSoul(cid,-50)
doRemoveItem(item.uid,1)

elseif Blood == 3 and (os.time() >= getPlayerStorageValue(cid, exhausted_storagevalue)) and (os.time() >= getPlayerStorageValue(cid, exhausted_storagevalue2)) and (os.time() >= getPlayerStorageValue(cid, exhausted_storagevalue3)) and (os.time() >= getPlayerStorageValue(cid, exhausted_storagevalue4)) then
doPlayerAddHealth(cid,10*getPlayerMaxHealth(cid)/100)
doPlayerAddMana(cid,10*getPlayerMaxHealth(cid)/100)
doSetCreatureOutfit(cid, hazus, 30000)
doSendMagicEffect(getCreaturePosition(cid), 12)
doPlayerSendTextMessage(cid,20,'Você usou um concentrated demoniac blood e se transformou em um Hazus. (Reflect Ativado)')
doPlayerSay(cid, "My hands are burning!", TALKTYPE_ORANGE_1)
addEvent(Blood1, 1*2000,cid)
setPlayerStorageValue(cid, exhausted_storagevalue, os.time() + exhausted_seconds)
doPlayerAddSoul(cid,-50)
doRemoveItem(item.uid,1)
end
end
