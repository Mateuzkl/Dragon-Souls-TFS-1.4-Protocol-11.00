local function Teleport10(cid)
if isPlayer(cid) == TRUE then
xpos = getPlayerStorageValue(cid, 111)
ypos = getPlayerStorageValue(cid, 222)
zpos = getPlayerStorageValue(cid, 333)
spos = {x=xpos, y=ypos, z=zpos}
doTeleportThing(cid, spos)
doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE, 'Você foi teletransportado com sucesso.')
doSendMagicEffect(getCreaturePosition(cid), CONST_ME_ENERGYAREA)
doSendAnimatedText(getCreaturePosition(cid), "Woup!!", 213)
end
return TRUE
end

local function Teleport9(cid)
xpos = getPlayerStorageValue(cid, 111)
ypos = getPlayerStorageValue(cid, 222)
zpos = getPlayerStorageValue(cid, 333)
spos = {x=xpos, y=ypos, z=zpos}
if isPlayer(cid) == TRUE then
doSendMagicEffect(spos, CONST_ME_ENERGYAREA)
doSendMagicEffect(getCreaturePosition(cid), CONST_ME_ENERGYAREA)
addEvent(Teleport10, 1 * 1000, cid)
end
end

local function Teleport8(cid)
xpos = getPlayerStorageValue(cid, 111)
ypos = getPlayerStorageValue(cid, 222)
zpos = getPlayerStorageValue(cid, 333)
spos = {x=xpos, y=ypos, z=zpos}
if isPlayer(cid) == TRUE then
doSendMagicEffect(spos, CONST_ME_ENERGYAREA)
doSendMagicEffect(getCreaturePosition(cid), CONST_ME_ENERGYAREA)
addEvent(Teleport9, 1 * 1000, cid)
end
end

local function Teleport7(cid)
xpos = getPlayerStorageValue(cid, 111)
ypos = getPlayerStorageValue(cid, 222)
zpos = getPlayerStorageValue(cid, 333)
spos = {x=xpos, y=ypos, z=zpos}
if isPlayer(cid) == TRUE then
doSendMagicEffect(spos, CONST_ME_ENERGYAREA)
doSendMagicEffect(getCreaturePosition(cid), CONST_ME_ENERGYAREA)
addEvent(Teleport8, 1 * 1000, cid)
end
end

local function Teleport6(cid)
xpos = getPlayerStorageValue(cid, 111)
ypos = getPlayerStorageValue(cid, 222)
zpos = getPlayerStorageValue(cid, 333)
spos = {x=xpos, y=ypos, z=zpos}
if isPlayer(cid) == TRUE then
doSendMagicEffect(spos, CONST_ME_ENERGYAREA)
doSendMagicEffect(getCreaturePosition(cid), CONST_ME_ENERGYAREA)
addEvent(Teleport7, 1 * 1000, cid)
end
end

local function Teleport5(cid)
xpos = getPlayerStorageValue(cid, 111)
ypos = getPlayerStorageValue(cid, 222)
zpos = getPlayerStorageValue(cid, 333)
spos = {x=xpos, y=ypos, z=zpos}
if isPlayer(cid) == TRUE then
doSendMagicEffect(spos, CONST_ME_ENERGYAREA)
doSendMagicEffect(getCreaturePosition(cid), CONST_ME_ENERGYAREA)
addEvent(Teleport6, 1 * 1000, cid)
end
end

local function Teleport4(cid)
xpos = getPlayerStorageValue(cid, 111)
ypos = getPlayerStorageValue(cid, 222)
zpos = getPlayerStorageValue(cid, 333)
spos = {x=xpos, y=ypos, z=zpos}
if isPlayer(cid) == TRUE then
doSendMagicEffect(spos, CONST_ME_ENERGYAREA)
doSendMagicEffect(getCreaturePosition(cid), CONST_ME_ENERGYAREA)
addEvent(Teleport5, 1 * 1000, cid)
end
end

local function Teleport3(cid)
xpos = getPlayerStorageValue(cid, 111)
ypos = getPlayerStorageValue(cid, 222)
zpos = getPlayerStorageValue(cid, 333)
spos = {x=xpos, y=ypos, z=zpos}
if isPlayer(cid) == TRUE then
doSendMagicEffect(spos, CONST_ME_ENERGYAREA)
doSendMagicEffect(getCreaturePosition(cid), CONST_ME_ENERGYAREA)
addEvent(Teleport4, 1 * 1000, cid)
end
end

local function Teleport2(cid)
xpos = getPlayerStorageValue(cid, 111)
ypos = getPlayerStorageValue(cid, 222)
zpos = getPlayerStorageValue(cid, 333)
spos = {x=xpos, y=ypos, z=zpos}
if isPlayer(cid) == TRUE then
doSendMagicEffect(spos, CONST_ME_ENERGYAREA)
doSendMagicEffect(getCreaturePosition(cid), CONST_ME_ENERGYAREA)
addEvent(Teleport3, 1 * 1000, cid)
end
end

local function Teleport1(cid)
xpos = getPlayerStorageValue(cid, 111)
ypos = getPlayerStorageValue(cid, 222)
zpos = getPlayerStorageValue(cid, 333)
spos = {x=xpos, y=ypos, z=zpos}
if isPlayer(cid) == TRUE then
doSendMagicEffect(spos, CONST_ME_ENERGYAREA)
doSendMagicEffect(getCreaturePosition(cid), CONST_ME_ENERGYAREA)
addEvent(Teleport2, 1 * 1000, cid)
end
end



local condition = createConditionObject(CONDITION_EXHAUSTED)
setConditionParam(condition, CONDITION_PARAM_TICKS, 15000)

function onUse(cid, item, frompos, item2, topos)

-- Exhausted Settings --
local exhausted_seconds1 = 15 -- Segundos que irá demorar para usar denovo
local exhausted_storagevalue1 = 8754 -- Storage Value do exhausted
local exhausted_seconds3 = 15 -- How many seconds mana fluid will be unavailible to use. --
local exhausted_storagevalue3 = 8162 -- Storage Value to store exhaust. It MUST be unused! --exhausted


local teleport = getPlayerStorageValue(cid, 444)

if(os.time() < getPlayerStorageValue(cid, exhausted_storagevalue1)) then
doPlayerSendCancel(cid,"Você está muito cansado.")
return TRUE
end

if getPlayerSkull(cid) == 3 then
doPlayerSendCancel(cid,"Você não pode usar esse teleport enquanto estiver PK.")
return TRUE
end

if teleport == -1 or teleport == 0 then
savpos = {x=getThingPos(cid).x, y=getThingPos(cid).y, z=getThingPos(cid).z, stackpos=253}
setPlayerStorageValue(cid, 111, savpos.x)
setPlayerStorageValue(cid, 222, savpos.y)
setPlayerStorageValue(cid, 333, savpos.z)
setPlayerStorageValue(cid, 444, 1)
doSendMagicEffect(getCreaturePosition(cid), CONST_ME_MAGIC_BLUE)
doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE, 'Você gravou suas coordenadas em seu teleport mistico.')

rand = math.random(0,100)
elseif teleport == 1 and (os.time() >= getPlayerStorageValue(cid, exhausted_storagevalue1)) and rand < 40 then
addEvent(Teleport1, 1 * 1000, cid)
setPlayerStorageValue(cid, 444, 0)
doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE, 'Você ativou seu teleport mistico.')
setPlayerStorageValue(cid, exhausted_storagevalue1, os.time() + exhausted_seconds1)
setPlayerStorageValue(cid, exhausted_storagevalue3, os.time() + exhausted_seconds3)
doTargetCombatCondition(0, cid, condition, CONST_ME_NONE)
doSendMagicEffect(getCreaturePosition(cid), CONST_ME_ENERGYAREA)
doRemoveItem(item.uid,1)


elseif teleport == 1 and (os.time() >= getPlayerStorageValue(cid, exhausted_storagevalue1)) and rand > 40 then
addEvent(Teleport1, 1 * 1000, cid)
setPlayerStorageValue(cid, 444, 0)
doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE, 'Você ativou seu teleport mistico.')
setPlayerStorageValue(cid, exhausted_storagevalue1, os.time() + exhausted_seconds1)
setPlayerStorageValue(cid, exhausted_storagevalue3, os.time() + exhausted_seconds3)
doTargetCombatCondition(0, cid, condition, CONST_ME_NONE)
doSendMagicEffect(getCreaturePosition(cid), CONST_ME_ENERGYAREA)
doRemoveItem(item.uid,1)
end
end
