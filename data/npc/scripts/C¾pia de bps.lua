local focus = 0
local talk_start = 0
local attack = 0
function onCreatureDisappear(cid, pos)
 if focus == cid then
  selfSay('Good bye then.')
  focus = 0
  talk_start = 0
  attack = 0
  DeAttack()
 end
end
function onCreatureSay(cid, type, msg)
   msg = string.lower(msg)
   if (msgcontains(msg, 'hi') and (focus == 0)) and getDistanceToCreature(cid) < 4 then
    selfSay('LONG LIVE TO THE KING!!!.')
    focus = cid
    talk_start = os.clock()
   elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
    selfSay('Sorry, ' .. creatureGetName(cid) .. '! I talk to you in a minute.')
 elseif focus == cid then
  talk_start = os.clock()
  if msgcontains(msg, 'attack') or msgcontains(msg, 'atk') then
   selfSay('Ok, Attacking.')
   attack = 1
   Attack(focus)
  elseif msgcontains(msg, 'stop') then
   selfSay('Stoping!')
   attack = 0
   DeAttack()
  elseif msgcontains(msg, 'bye') and getDistanceToCreature(cid) < 4 then
   selfSay('Good bye, ' .. creatureGetName(cid) .. '!')
   focus = 0
  end
 end
end
function onCreatureChangeOutfit(creature)
end
function onThink()
 if attack == 1 then
  autoTurn(focus)
 end
end