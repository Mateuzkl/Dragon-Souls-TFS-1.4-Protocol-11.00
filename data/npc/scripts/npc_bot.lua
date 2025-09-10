focus = 0
talk_start = 0
target = 0
following = false
attacking = false

function onThingMove(creature, thing, oldpos, oldstackpos)
end

function onCreatureAppear(creature)
selfSay('Hello young aventurer! I\'m a bot made by Gamemasters.') -- Its greeting sentence,= when something appears
end


function onCreatureDisappear(cid, pos)
end

function onCreatureTurn(creature)
end

function msgcontains(txt, str)
end

function onCreatureSay(cid, type, msg)
end

function onCreatureChangeOutfit(creature)
end

function onThink()

if focus == 0 then -- the move sccript
cx, cy, cz = selfGetPosition()
randmove = math.random(1,15)
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
end

moveToPosition(nx, ny, cz)

randsay = math.random(1,999999) -- how frecuently your bot will say 
if randsay == 5 then -- something, you should set it to less than
                     -- 600 or it will end up crashin your serv 
selfSay('/bc white They are Welcome! This server is running with Neverland 7.6 - Version 1.2') -- Notice 1
end
if randsay == 10 then
selfSay('/raid mino') -- numbah 2
end
if randsay == 15 then
selfSay('/raid undead') -- just change the other sentences..
end
if randsay == 20 then
selfSay('/raid orsha') -- if u want to add more lines just copy the if..
end
if randsay == 25 then
selfSay('/bc white Download your Neverland version in OTFans!')
end
if randsay == 30 then
selfSay('/raid trolls')
end
end