focus = 0
talk_start = 0
target = 0
following = false
attacking = false

function onThingMove(creature, thing, oldpos, oldstackpos)
end

function onCreatureAppear(creature)
end


function onCreatureDisappear(cid, pos)
if focus == cid then
selfSay('Merry Christmas!')
focus = 0
talk_start = 0
end
end

function onCreatureTurn(creature)
end

function msgcontains(txt, str)
return (string.find(txt, str) and not string.find(txt, '(%w+)' .. str) and not string.find(txt, str .. '(%w+)'))
end

function onCreatureSay(cid, type, msg)
msg = string.lower(msg)

if ((string.find(msg, '(%a*)hi(%a*)')) and (focus == 0)) and getDistanceToCreature(cid) < 4 then
selfSay('Merry Christmas ' .. creatureGetName(cid) .. '!')
focus = cid
talk_start = os.clock()
end

if string.find(msg, '(%a*)hi(%a*)') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
selfSay('Sorry, ' .. creatureGetName(cid) .. '! Please wait.')
end

if string.find(msg, '(%a*)present(%a*)') and focus == cid and getDistanceToCreature(cid) < 4 then
present = getPlayerStorageValue(cid,1210)
if present == -1 then
buy(cid,item,1,0)
setPlayerStorageValue(cid,1210,1)
end

if present == 1 then
selfSay('Sorry, I dont have more presents for you.')
end
end

if string.find(msg, '(%a*)bye(%a*)') and focus == cid and getDistanceToCreature(cid) < 4 then
selfSay('Good bye, ' .. creatureGetName(cid) .. '!')
focus = 0
talk_start = 0
end
end


function onCreatureChangeOutfit(creature)
end


function onThink()
if (os.clock() - talk_start) > 30 then
if focus > 0 then
selfSay('Merry Christmas!')
end
focus = 0
end
if focus ~= 0 then
if getDistanceToCreature(focus) > 3 then
selfSay('Merry Christmas!')
focus = 0
end
end
if focus == 0 then
cx, cy, cz = selfGetPosition()
randmove = math.random(1,25)
if randmove == 1 then
nx = cx + 1
end
if randmove == 2 then
nx = cx - 1
end
if randmove == 3 then
ny = cy + 1
end
if randmove == 4 then
ny = cy - 1
end
if randmove >= 5 then
nx = cx
ny = cy
end
moveToPosition(nx, ny, cz)
--summons = 30
--summons2 = 30
end

if focus > 0 then
rand = math.random(1,6)
if rand == 1 then
item = 2969
elseif rand == 2 then
item = 2973
elseif rand == 3 then
item = 3363
elseif rand == 4 then
item = 3520
elseif rand == 5 then
item = 2930
else
item = 3524
end
end

if focus == 0 then
randsay = math.random(1,75)
if randsay == 1 then
selfSay('Hmmhmm...')
end
if randsay == 2 then
selfSay('Hoho...')
end
end
end

