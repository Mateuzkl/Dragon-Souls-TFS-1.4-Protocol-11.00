local focus = 0
local talk_start = 0
local attack = 0
following = false

function onCreatureDisappear(cid, pos)
 if focus == cid then
  selfSay('...')
  focus = 0
  talk_start = 0
  attack = 0
  DeAttack()
		following = 0
		target = 0
 end
end

function onCreatureSay(cid, type, msg)

   msg = string.lower(msg)

   if (msgcontains(msg, 'hi') and (focus == 0)) and getDistanceToCreature(cid) < 4 then
    selfSay('Long life to the Queen!')
    focus = cid
    talk_start = os.clock()

   elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
    selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')

   elseif msgcontains(msg, 'fuck') and (focus == 0) and getDistanceToCreature(cid) < 4 then
    selfSay('Hey, take care whit your mouth ' .. creatureGetName(cid) .. '!')

   elseif msgcontains(msg, 'stop') then
    attack = 0
    DeAttack()
    following = 0
    target = 0


 elseif focus == cid then
  talk_start = os.clock()

  if msgcontains(msg, 'fuck you') and getTilePzInfo(getPlayerPosition(cid)) == 1 then
   selfSay('Ha! On protect zone you coward!!')

  elseif msgcontains(msg, 'fuck you') or msgcontains(msg, 'foda') then
   selfSay('Hey! I will show you!')
   attack = 1
   Attack(focus)
	following = true
	target = cid

  elseif msgcontains(msg, 'stop') then
   selfSay('Next time, i wont stop!')
   attack = 0
   DeAttack()
		following = 0
		target = 0

  elseif msgcontains(msg, 'bye') and getDistanceToCreature(cid) < 4 then
   selfSay('Good bye, ' .. creatureGetName(cid) .. '!')
  	focus = 0
  	talk_start = 0
   	attack = 0
   	DeAttack()
		following = 0
		target = 0
  end
 end
end
function onCreatureChangeOutfit(creature)
end
function onThink()


	if following == true then
	if getTilePzInfo(getPlayerPosition(target)) == 1 then
  			selfSay('Chicken! Next time i get you!')
  		focus = 0
  		talk_start = 0
   		attack = 0
   		DeAttack()
		following = 0
		target = 0
else
		moveToCreature(target)
   		attack = 1
   		Attack(target)
		return
	end
end
	doNpcSetCreatureFocus(focus)
  	if (os.clock() - talk_start) > 30 then
  		if focus > 0 then
  			selfSay('...')
   			attack = 0
   			DeAttack()
		following = 0
		target = 0
  		end
  			focus = 0
  	end
 	if focus ~= 0 then
 		if getDistanceToCreature(focus) > 5 then
 			selfSay('Good bye then.')
 			focus = 0
   			attack = 0
   			DeAttack()
		following = 0
		target = 0
 		end
 	end
end