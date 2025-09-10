-- sven, the bewitched bunny
-- it's a sample script, i dont know lua well enough to
-- make some fancy code
-- the good thing is, that this scripts can easily be developed
-- seperately from the main programm
-- perhaps we should write some docu

-- the id of the creature we are attacking, following, etc.

target = 0
following = false
attacking = false

local gname = ''		-- guild name
local cname = ''		-- name of player who talks to us

function onThingMove(creature, thing, oldpos, oldstackpos)

end


function onCreatureAppear(creature)
end


function onCreatureDisappear(cid)
end


function onCreatureTurn(creature)

end


function onCreatureSay(cid, type, msg)

  storevalue = 7123
  alerttime = 600

  pos = {x=544, y=467, z=5}

  	cname = creatureGetName(cid)
  	gname = getPlayerGuildName(cname)
  	gstat = getPlayerGuildStatus(cname)

	msg = string.lower(msg)
	if string.find(msg, '(%a*)hi(%a*)') and getDistanceToCreature(cid) < 2 then
  	selfSay('A guilda ' .. gname .. ', esta dominando o castelo!')
        doCreateItem(2327,1,pos)

  		focus = cid
  		talk_start = os.clock()
end
end

function onCreatureChangeOutfit(creature)

end


function onThink()
	--nothing special has happened
	--but perhaps we want to do an action?
	if following == true then
		moveToCreature(target)
		return
	end
	if attacking == true then
		dist = getDistanceToCreature(target)
		if dist == nil then
			selfGotoIdle()
			return
		end
		if dist <= 1 then
			selfAttackCreature(target)
		else
			moveToCreature(target)
		end
	end
end

