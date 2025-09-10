-- the id of the creature we are attacking, following, etc.
 
  target = 0
  following = false
  attacking = false
 focus = 0
 
  function onThingMove(creature, thing, oldpos, oldstackpos)
 
  end
 
 
  function onCreatureAppear(creature)
 
  end
 
 
  function onCreatureDisappear(cid, pos)
 
  end
 
 
  function onCreatureTurn(creature)
 
  end
 
 
  function onCreatureSay(cid, type, msg)
  	msg = string.lower(msg)
 
  	if (string.find(msg, '(%a*)hi(%a*)')) and getDistanceToCreature(cid) < 4 then
		randsay = math.random(1,4)
		if randsay == 1 then
  		selfSay('Sings for me.')
		end
		if randsay == 2 then
  		selfSay('I Send my son to Osgiliath!')
		end
		if randsay == 3 then
  		selfSay('The war is comming! We are losted.')
		end
		if randsay == 4 then
  		selfSay('Where is Boromir?!')
		end
 		selfLook(cid)
  	end

  	if (string.find(msg, '(%a*)orc(%a*)')) and getDistanceToCreature(cid) < 4 then
  		selfSay('Orcs are comming, all is losted!')
 		selfLook(cid)
  	end

  	if (string.find(msg, '(%a*)oi(%a*)')) and getDistanceToCreature(cid) < 4 then
		randsay = math.random(1,4)
		if randsay == 1 then
  		selfSay('Cante para mim.')
		end
		if randsay == 2 then
  		selfSay('Eu mandei meu filho a Osgiliath!')
		end
		if randsay == 3 then
  		selfSay('A guerra esta prócima! Estamos todos perdidos')
		end
		if randsay == 4 then
  		selfSay('Onde esta Boromir?!')
		end
 		selfLook(cid)
  	end
  end
 
 
  function onCreatureChangeOutfit(creature)
 
  end
 
 
 function onThink() 
if focus == 0 then
cx, cy, cz = selfGetPosition()
randmove = math.random(1,20)
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
end

if focus == 0 then
randsay = math.random(1,500)
if randsay == 1 then
 selfSay('What we will do?!') 
end
if randsay == 500 then
 selfSay('I Want my son!') 
end
end
end
 
 
