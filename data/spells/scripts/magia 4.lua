local function move(cid, target, playerpos, targetpos, times)
if playerdir ~= getCreatureLookDirection(cid) then
doCreatureSetLookDirection(target, getCreatureLookDirection(cid))
end

if playerpos ~= getCreaturePosition(cid) then
if playerpos.z == getCreaturePosition(cid).z then
ntpos = getCreaturePosition(cid)
local x,y,z = ntpos.x-playerpos.x,ntpos.y-playerpos.y,ntpos.z-playerpos.z
ntpos = getCreaturePosition(target)
ntpos.x, ntpos.y, ntpos.z = ntpos.x+x,ntpos.y+y,ntpos.z+z
if queryTileAddThing(target, ntpos) == RETURNVALUE_NOERROR and getCreaturePosition(cid).z == getCreaturePosition(target).z then
doMoveCreature(target, getCreatureLookDirection(cid))
end
end
end
local playerpos, targetpos = getCreaturePosition(cid), getCreaturePosition(target)
local times = times+1
if times < 700 then
addEvent(move, 1, cid, target, playerpos, targetpos, times)
else
doCreatureSetNoMove(target, 0)
doSendDistanceShoot(targetpos, playerpos, 31)
doSendAnimatedText(targetpos, "Livre!", math.random(1,255))
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Você não possui mais o controle mental do "..getCreatureName(target)..".")
if (isPlayer(target)) then
doPlayerSendTextMessage(target, MESSAGE_STATUS_CONSOLE_BLUE, "Você foi libertado do controle mental.")
setPlayerStorageValue(target, 14755, -1)
end
end
end

function onCastSpell(cid, var)
local target = getCreatureTarget(cid)
if (isPlayer(target)) or (isMonster(target)) then
if getPlayerStorageValue(cid, 14755) == -1 then
doCreatureSetNoMove(target, 1)
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Você está controlando a mente do "..getCreatureName(target)..".")
if (isPlayer(target)) then
doPlayerSendTextMessage(target, MESSAGE_STATUS_CONSOLE_BLUE, "Você teve sua mente controlada por "..getPlayerName(cid)..".")
setPlayerStorageValue(target, 14755, 1)
end
doSendAnimatedText(getCreaturePosition(target), "Possuido!", math.random(1,255))
local playerpos,playerdir,targetpos = getCreaturePosition(cid), getPlayerLookDir(cid), getCreaturePosition(target)
doSendDistanceShoot(playerpos, targetpos, 31)
doSendMagicEffect(getCreaturePosition(target), CONST_ME_SMALLCLOUDS)
local times = 1
addEvent(move, 1000, cid, target, playerpos, targetpos, times)
else
doPlayerSendCancel(cid, "Você ainda esta sobre controle mental.")
end
end
end