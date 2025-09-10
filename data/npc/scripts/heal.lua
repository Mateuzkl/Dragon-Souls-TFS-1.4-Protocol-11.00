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

function onThingMove(creature, thing, oldpos, oldstackpos)

end


function onCreatureAppear(creature)
selfSay('Olaaa !')
end


function onCreatureDisappear(cid)
selfSay('Poxa! pq vc mato o ' .. creatureGetName(cid) .. '?!')
end


function onCreatureTurn(creature)

end


function onCreatureSay(cid, type, msg)
	msg = string.lower(msg)
	if string.find(msg, '(%a*)hi(%a*)') then
		selfSay('oi oi, ' .. creatureGetName(cid) .. '!')
	end
	if string.find(msg, '(%a*)kiss(%a*)') then
		selfSay('kiss!')
	end
	if string.find(msg, '(%a*)wuff(%a*)') then
		selfSay('cachorrinho lindo!')
	end
	if string.find(msg, '(%a*)munch.(%a*)') then
		selfSay('da um pedaço?')
	end
	if string.find(msg, '(%a*)chomp.(%a*)') then
		selfSay('da um pedaço?')
	end
	if string.find(msg, '(%a*)bye(%a*)') then
		selfSay('Ja vai?')
	end
	if string.find(msg, '(%a*)exevo con(%a*)') then
		selfSay('ai pra que vc quer flecha se nao sabe usar um arco?')
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

