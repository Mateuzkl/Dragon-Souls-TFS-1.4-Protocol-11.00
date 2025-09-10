--ox = 44
--oy = 5
--oz = 6

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
selfSay('Tchau então.')
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

if ((string.find(msg, '(%a*)hi(%a*)')) and (focus == 0)) and getDistanceToCreature(cid) < 3 then
selfSay('Hello ' .. creatureGetName(cid) .. '! I selling fantastic julery. ')
focus = cid
talk_start = os.clock()
elseif string.find(msg, '(%a*)hi(%a*)') and (focus ~= cid) and getDistanceToCreature(cid) < 3 then
selfSay('Not now, ' .. creatureGetName(cid) .. '! I will talk with you for moment.') elseif focus == cid then talk_start = os.clock() 

if msgcontains(msg, 'amethyst') then
sell(cid,2971,1,200)
elseif msgcontains(msg, 'diamond') then
sell(cid,2966,1,300)
elseif msgcontains(msg, 'emerald') then
sell(cid,2970,1,250)
elseif msgcontains(msg, 'ruby') then
sell(cid,2968,1,350)
elseif msgcontains(msg, 'sapphire') then
sell(cid,2967,1,400)
elseif msgcontains(msg, 'white pearl') then
sell(cid,2964,1,160)
elseif msgcontains(msg, 'black pearl') then
sell(cid,2965,1,280)
elseif msgcontains(msg, 'blue gem') then
sell(cid,2979,1,20000)
elseif msgcontains(msg, 'yellow gem') then
sell(cid,2975,1,10000)
elseif msgcontains(msg, 'violet gem') then
sell(cid,2974,1,18000)
elseif msgcontains(msg, 'gold nugget') then
sell(cid,2978,1,30000)
elseif msgcontains(msg, 'silver brooch') then
sell(cid,2955,1,15000)
elseif msgcontains(msg, 'brooch') then
sell(cid,2948,1,25000)
elseif msgcontains(msg, 'crown') then
sell(cid,2949,1,40000)
elseif msgcontains(msg, 'big esmerald') then
sell(cid,2976,1,22000)
elseif msgcontains(msg, 'big ruby') then
sell(cid,2977,1,23000)
elseif msgcontains(msg, 'scarab coin') then
sell(cid,2980,1,100)
elseif msgcontains(msg, 'talon') then
sell(cid,2972,1,2000)
elseif msgcontains(msg, 'life crystal') then
sell(cid,2999,1,5000)
elseif msgcontains(msg, 'mind stone') then
sell(cid,3000,1,6000)
elseif msgcontains(msg, 'horn') then
sell(cid,3041,1,2000)
elseif msgcontains(msg, 'offer') then
selfSay('I can sell you all Gems, pearls, horn and many more cool julery. .')

elseif string.find(msg, '(%a*)bye(%a*)') and getDistanceToCreature(cid) < 3 then
selfSay('Goodbye, ' .. creatureGetName(cid) .. '!')
focus = 0
talk_start = 0
end
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
end 

 if (os.clock() - talk_start) > 30 then 
 if focus > 0 then 
 selfSay('Next please!') 
 talkcount = 0
 end 
 focus = 0 
 itemid = 0
 talk_start = 0 
 end 
  	if focus ~= 0 then
  		if getDistanceToCreature(focus) > 5 then
  			selfSay('Adeus.')
  			focus = 0
  		end
	end

 